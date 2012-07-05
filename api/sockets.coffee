socketio = require "socket.io"
{series, curry} = require "fjs"
{downloadUrl} = require "./services/remote"

exports.listen = (app, rooms) ->
  
  io = require("socket.io").listen(app)

  io.configure ->
    # io.set 'store', store
    # io.set 'log level', 0
  
  # simple CRUD for objects, based on channel
  io.sockets.on 'connection', (socket) ->

    # just sayin hi!
    socket.emit 'hello', "hello ##{socket.id}!"

    dump = (err) ->
      if err?
        console.log "ERROR #{err.message}"
        socket.emit 'error', err.message

    # cb helper to get all the info you need. Data is 3rd param
    info = (cb) ->
      (data) ->
        roomId = data.roomId
        if not roomId?
          return dump new Error "roomId is required"

        # we want to broadcast to EVERYONE in the room, including ourselves
        # channel = socket. roomId
        channel = io.sockets.in roomId

        room = rooms.room roomId
        cb channel, room, data


    saveObject = curry (channel, room, object) ->
      room.save object, (err, object) ->
        channel.emit "save", object

    socket.on "save", info(saveObject)

    socket.on "remove", info (channel, room, object) ->
      room.remove object, (err, object) ->
        channel.emit "remove", object

    socket.on "saveUrl", info (channel, room, object) ->
      url = object.url
      downloadUrl url, (err, object) ->
        saveObject channel, room, object

    socket.on "join", info (channel, room, user) ->
      socket.join user.roomId
      channel.emit "join", user

      room.all (err, objects) ->
        objects.forEach (obj) ->
          socket.emit 'save', obj
