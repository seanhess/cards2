
{values, extend} = require 'underscore'

# TODO change this to a real persistent data store later

exports.Rooms = (data) ->

  data ?=
    woot: Room
      '6equd9v9pphkt9':
        imageUrl: 'http://magiccards.info/scans/en/pd3/3.jpg'
        position: { left: 476, top: 44 }
        roomId: 'woot'
        _id: '6equd9v9pphkt9'
        _type: 'card'
  
  # can't remove, just get lazily. Always created
  room: (id) ->
    data[id] ?= Room {}

  # in an array
  all: (cb) -> cb null, values(data)

exports.Room = Room = (data) ->

  # objects
  remove: (object, cb) ->
    delete data[object._id]
    cb null, object

  # save/update
  save: (object, cb) ->
    object._id ?= Math.random().toString(36).replace("0.", "")
    existing = data[object._id] ? {}
    data[object._id] = extend existing, object
    cb null, object

  get: (object, cb) ->
    cb null, data[object._id]

  # objects as an array
  all: (cb) ->
    cb null, values(data)



