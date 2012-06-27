express = require 'express'
sockets = require './sockets'
{curry} = require 'fjs'
{send} = require './lib/web/send'
{Rooms} = require './store/rooms'

exports.createServer = ->
  app = express.createServer()

  rooms = Rooms()
  sockets.listen app, rooms

  app.configure ->
    app.use express.bodyParser()
    app.use express.static(__dirname+"/public")

  app.get '/rooms', (req, res) -> rooms.all send(res)
  app.get '/rooms/:id/objects', (req, res) ->
    room = rooms.room req.param 'id'
    room.all send(res)

  return app


if module is require.main
  PORT = process.env.PORT || 4022
  app = exports.createServer()
  app.listen PORT

  console.log "CARDS :: port #{PORT}"
