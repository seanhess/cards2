socketio = require "socket.io"

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
        channel = socket.broadcast.to roomId
        room = rooms.room roomId
        cb channel, room, data

    socket.on "save", info (channel, room, widget) ->
      channel.emit "save", widget
      room.save widget, dump

    socket.on "remove", info (channel, room, widget) ->
      channel.emit "remove", widget
      room.remove widget, dump

    socket.on "join", info (channel, room, user) ->
      socket.join user.roomId
      channel.emit "join", user
