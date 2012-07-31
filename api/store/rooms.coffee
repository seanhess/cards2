
{values, extend, pick, clone} = require 'underscore'
{ObjectId} = require 'mongolian'

# TODO change this to a real persistent data store later

exports.Rooms = (collection) ->

  # Objects MUST have a roomId property

  # objects
  remove: (object, cb) ->
    collection.remove {_id: object._id}, cb

  # save/update
  save: (object, cb) ->
    object._id ?= Math.random().toString(36).replace("0.", "")
    updates = clone object
    delete updates._id
    collection.update {_id: object._id}, {$set: updates}, true, cb

  get: (object, cb) ->
    collection.findOne {_id: object._id}, cb

  # objects as an array
  all: (roomId, cb) ->
    collection.find({roomId}).toArray(cb)



