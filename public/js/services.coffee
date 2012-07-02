# Services


define (require) ->
  angular = require 'angular'
  {find, extend} = require 'underscore'
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
        console.log "SAVE!", object, existing?
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
        save: (object) ->
          emit 'save', object
          # save object

        remove: (object) ->
          emit 'remove', object
          # remove object

        join: (user) ->
          emit 'join', user
          # join user

  # Demonstrate how to register services
  # In this case it is a simple value service.
  angular.module('cards.services', [])
    .value('version', '0.1')
    .factory('Room', Room)


