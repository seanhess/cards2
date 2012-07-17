
define (require) ->
  angular = require 'angular'
  {find, clone, extend, max} = require 'underscore'
  {curry} = require 'fjs'
  $ = require 'jquery'
  socketio = require 'socketio'

  dump = (data) -> console.log data

  Room = () ->
    ($scope, roomId) ->

      # connect
      if not roomId? then throw new Error "Missing RoomId"
      socket = io.connect 'http://localhost'

      isId = curry (id, obj) -> obj._id is id
      isNotId = curry (id, obj) -> obj._id isnt id

      emit = (event, data) ->
        data.roomId = roomId
        socket.emit event, data

      save = (object) ->
        existing = room.objectsById[object._id]
        if not existing?
          existing = room.objectsById[object._id] = object
          room.objects.push object
        else
          extend existing, object

      remove = (object) ->
        delete room.objectsById[object._id]
        room.objects = room.objects.filter isNotId(object._id)

      join = (user) ->
        room.users.push user

      apply = (cb) ->
        (args...) ->
          $scope.$apply ->
            cb args...

      getObject = (id) ->
        room.objects.filter(isId(id))[0]

      sendRemove = (object) ->
        emit 'remove', {_id: object._id}

      sendJoin = (user) ->
        emit 'join', user

      sendSave = (object) ->
        # we don't want to update the objects of an object
        object = clone object
        delete object.objects
        emit 'save', object

      sendSaveUrl = (url) ->
        emit 'saveUrl', {url}

      # draw a card from the deck and return it
      draw = (deck) ->
        console.log "DECK", deck._id
        card = deck.objects.shift()
        if card?
          card.position =
            left: deck.position.left + 200
            top: deck.position.top
          sendSave card

      # tells you the next highest index in the room
      currentIndex = null
      nextIndex = (index) ->
        if not currentIndex?
          currentIndex = max room.objects, (obj) -> obj.index
          currentIndex or= 0
        return ++currentIndex

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
        saveUrl: sendSaveUrl
        draw: draw
        nextIndex: nextIndex

