
define (require) ->
  angular = require 'angular'
  {find, clone, extend, max, pick} = require 'underscore'
  {curry} = require 'fjs'
  $ = require 'jquery'
  socketio = require 'socketio'

  dump = (data) -> console.log data

  # a room is a synced collection
  Room = () ->
    ($scope, roomId) ->

      # connect
      if not roomId? then throw new Error "Missing RoomId"
      socket = io.connect 'http://localhost'

      isId = curry (id, obj) -> obj._id is id
      isNotId = curry (id, obj) -> obj._id isnt id

      emit = curry (event, data) ->
        data.roomId = roomId
        socket.emit event, data


      findLocal = (obj) ->
        local = room.objectsById[obj._id] 
        if not local? then throw new Error "Object #{obj._id} does not exist"
        return local

      create = (obj) ->
        local = room.objectsById[obj._id]
        if local? then throw new Error "Object #{obj._id} already exists"
        room.objectsById[obj._id] = obj
        room.objects.push obj

      update = curry (fields, obj) ->
        local = findLocal obj
        updates = pick obj, fields...
        extend local, updates

      move = update ["position", "modified"]

      remove = (object) ->
        delete room.objectsById[object._id]
        room.objects = room.objects.filter isNotId(object._id)

      apply = (cb) ->
        (args...) ->
          $scope.$apply ->
            cb args...

      onJoin = (user) ->
        room.users.push user

      onCommand = (cmd) ->
        if cmd.action is "create" then create cmd.object
        else if cmd.action is "move" then move cmd.object
        else if cmd.action is "remove" then remove cmd.object
        else throw new Error "Could not find action #{cmd.action}"


      #getObject = (id) ->
        #room.objects.filter(isId(id))[0]

      sendRemove = (object) ->
        object.deleted = true
        sendCommand "remove", pick(object, "_id")

      sendMove = (object) ->
        return if object.deleted
        sendCommand "move", pick(object, "_id", "position")

      sendCreate = (object) ->
        sendCommand "create", object

      sendCommand = (action, object) ->
        emit 'command',
          action: action
          roomId: roomId
          object: object

      sendJoin = (user) ->
        emit 'join', user

      #sendSave = (object, fields...) ->
        #if fields.length
          #object = pick object, fields.concat("_id")

        #emit 'save', object

      # socket. must call $scope.apply. Is there a better way to do this?
      socket.on 'join', apply(onJoin)
      socket.on 'command', apply(onCommand)
      socket.on 'error', (err) -> dump "socket.io ERROR #{err}"

      room = {

        # BINDABLE attributes
        roomId: roomId
        users: []
        objects: []
        objectsById: {}

        # METHODS to manipulate stuff
        sendMove
        sendJoin
        sendCreate
        sendRemove
      }

