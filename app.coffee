express = require 'express'
sockets = require './sockets'
{curry} = require 'fjs'
{send} = require './lib/web/send'
{Rooms} = require './store/rooms'

coffeepot = require 'coffeepot'


exports.createServer = ->
  app = express.createServer()

  rooms = Rooms()
  sockets.listen app, rooms

  app.configure ->
    publicDir = __dirname + "/public"
    app.use express.bodyParser()
    app.use coffeepot publicDir
    app.use express.static publicDir

  app.get '/rooms', (req, res) -> rooms.all send(res)
  app.get '/rooms/:id/objects', (req, res) ->
    room = rooms.room req.param 'id'
    room.all send(res)


  app.get '/debug/decks/example', (req, res) ->
    res.send
      objects: [
        {imageUrl: "http://magiccards.info/scans/en/pd3/3.jpg"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/4.jpg"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/5.jpg"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/6.jpg"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/7.jpg"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/8.jpg"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/9.jpg"}
      ]

  return app


if module is require.main
  PORT = process.env.PORT || 4022
  app = exports.createServer()
  app.listen PORT

  console.log "CARDS :: port #{PORT}"
