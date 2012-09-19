socketio = require "socket.io"


module.exports = (Room) ->

  listen: (app) ->
  
    io = require("socket.io").listen(app)

    io.configure ->
      # io.set 'store', store
      # io.set 'log level', 0
    
    # simple CRUD for objects, based on channel
    io.sockets.on 'connection', (socket) ->

      dump = (err) ->
        if err?
          console.log "ERROR #{err.message}"
          socket.emit 'error', err.message




      # COMMAND any manipulation of the objects

      socket.on "command", (commandData) ->
        roomId = commandData.roomId
        if not roomId?
          return dump new Error "roomId is required"

        CommandClass = Room.commandForAction commandData.action
        command = new CommandClass commandData

        command.run (err, command) ->
          return dump err if err?
          io.sockets.in(roomId).emit "command", command




      # JOIN when a new user joins the club
      # send everyone the message that they are here
      # and give them all the objects in the room

      socket.on "join", (data) ->
        roomId = data.roomId
        if not roomId?
          return dump new Error "roomId is required"

        socket.join roomId
        io.sockets.in(roomId).emit "join", data

        Room.objects roomId, (err, objects) ->
          objects.forEach (obj) ->
            socket.emit 'command',
              roomId: roomId
              action: "create"
              object: obj

