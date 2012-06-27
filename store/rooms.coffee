
{values} = require 'underscore'

exports.Rooms = (data) ->

  data ?= {}
  
  # can't remove, just get lazily. Always created
  room: (id) -> data[id] ?= Room {}

  # in an array
  all: (cb) -> cb null, values(data)

exports.Room = Room = (data) ->

  # objects
  remove: (object, cb) ->
    delete data[object.id]
    cb()

  save: (object, cb) ->
    data[object.id] = object
    cb()

  get: (object, cb) ->
    cb null, data[object.id]

  # objects as an array
  all: (cb) ->
    cb null, values(data)



