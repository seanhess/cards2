
{values} = require 'underscore'

# TODO change this to a real persistent data store later

exports.Rooms = (data) ->

  data ?= {}
  
  # can't remove, just get lazily. Always created
  room: (id) -> data[id] ?= Room {}

  # in an array
  all: (cb) -> cb null, values(data)

exports.Room = Room = (data) ->

  # objects
  remove: (object, cb) ->
    delete data[object._id]
    cb null, object

  save: (object, cb) ->
    object._id ?= Math.random().toString(36).replace("0.", "")
    data[object._id] = object
    cb null, object

  get: (object, cb) ->
    cb null, data[object._id]

  # objects as an array
  all: (cb) ->
    cb null, values(data)



