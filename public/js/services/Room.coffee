
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

      save = (remote) ->
        local = room.objectsById[remote._id]
        if not local?
          local = room.objectsById[remote._id] = remote
          room.objects.push remote
        else
          extend local, remote

      remove = (object) ->
        delete room.objectsById[object._id]
        room.objects = room.objects.filter isNotId(object._id)

      apply = (cb) ->
        (args...) ->
          $scope.$apply ->
            cb args...

      join = (user) ->
        room.users.push user

      getObject = (id) ->
        room.objects.filter(isId(id))[0]

      sendRemove = (object) ->
        emit 'remove', pick(object, "_id")
      sendJoin = (user) ->
        emit 'join', user
      sendSave = (object, fields...) ->
        if fields.length
          object = pick object, fields.concat("_id")

        emit 'save', object

      # socket. must call $scope.apply. Is there a better way to do this?
      socket.on 'save', apply(save)
      socket.on 'remove', apply(remove)
      socket.on 'join', apply(join)
      socket.on 'error', (err) -> dump "socket.io ERROR #{err}"

      room =
        roomId: roomId
        users: []
        objects: []
        objectsById: {}
        save: sendSave
        remove: sendRemove
        join: sendJoin
        # lets you specify a url, and we create an object out of it

