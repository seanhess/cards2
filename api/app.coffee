express = require 'express'
sockets = require './sockets'
{curry, series} = require 'fjs'
{send} = require './lib/web/send'
{Rooms} = require './store/rooms'
{downloadUrl} = require './services/remote'
request = require 'request'
Mongolian = require 'mongolian'

stylus = require 'stylus'
nib = require 'nib'


coffeepot = require 'coffeepot'


exports.createServer = ->
  app = express.createServer()

  db = new Mongolian "mongodb://localhost:27017/cards"
  rooms = Rooms db.collection 'objects'
  sockets.listen app, rooms

  app.configure ->
    publicDir = __dirname + "/../public"
    app.use express.bodyParser()
    app.use coffeepot publicDir

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

    app.use express.static publicDir


  # proxy fetch json data
  app.get /\/fetch\/(.*)/, (req, res) ->
    request.get {url: req.params[0], json: true}, (err, rs, body) ->
      if err? then res.send 500
      res.send body



  # fake data
  app.get '/debug/cards/example', (req, res) ->
    res.send {imageUrl:'http://magiccards.info/scans/en/pd3/2.jpg'}

  app.get '/debug/decks/example', (req, res) ->
    res.send
      backImageUrl: "http://upload.wikimedia.org/wikipedia/en/a/aa/Magic_the_gathering-card_back.jpg"
      _type: "deck"
      objects: [
        {imageUrl: "http://magiccards.info/scans/en/pd3/3.jpg", _type: "card"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/4.jpg", _type: "card"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/5.jpg", _type: "card"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/6.jpg", _type: "card"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/7.jpg", _type: "card"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/8.jpg", _type: "card"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/9.jpg", _type: "card"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/3.jpg", _type: "card"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/4.jpg", _type: "card"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/5.jpg", _type: "card"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/6.jpg", _type: "card"}
        {imageUrl: "http://magiccards.info/scans/en/pd3/7.jpg", _type: "card"}
      ]

  return app


if module is require.main
  PORT = process.env.PORT || 4022
  app = exports.createServer()
  app.listen PORT

  console.log "CARDS :: port #{PORT}"
