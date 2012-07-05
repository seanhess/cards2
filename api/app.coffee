express = require 'express'
sockets = require './sockets'
{curry, series} = require 'fjs'
{send} = require './lib/web/send'
{Rooms} = require './store/rooms'
{downloadUrl} = require './services/remote'

stylus = require 'stylus'
nib = require 'nib'


coffeepot = require 'coffeepot'


exports.createServer = ->
  app = express.createServer()

  rooms = Rooms()
  sockets.listen app, rooms

  app.configure ->
    publicDir = __dirname + "/../public"
    console.log publicDir
    app.use express.bodyParser()
    app.use coffeepot publicDir
    app.use express.static publicDir

    # stylus
    app.use stylus.middleware
      src: publicDir
      firebug: true
      compile: (str, path) ->
        stylus(str)
          .include(publicDir)
          .use(nib())
          .import('nib') # global access to nib functions
          .set('filename', path)

  app.get '/rooms', (req, res) -> rooms.all send(res)
  app.get '/rooms/:id/objects', (req, res) ->
    roomActions.newObject req.param('id'), req.body
    room = rooms.room req.param 'id'
    room.all send(res)

  # given a url, look up an object and then create it
  app.post '/rooms/:id/objects/url', (req, res) ->
    room = rooms.room req.param 'id'
    url = req.body
    series downloadUrl(url), room.save, send(res)

  # create
  app.post '/rooms/:id/objects', (req, res) ->
    room = rooms.room req.param 'id'
    object = req.body
    room.save object, send(res)


  app.get '/debug/cards/example', (req, res) ->
    res.send {imageUrl:'http://magiccards.info/scans/en/pd3/2.jpg'}

  app.get '/debug/decks/example', (req, res) ->
    res.send
      backImageUrl: "http://www.magicspoiler.com/wp-content/uploads/2012/04/MTG-Card-Back.jpg"
      _type: "deck"
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
