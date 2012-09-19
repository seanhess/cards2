
{curry} = require 'fjs'
{ObjectId} = require 'mongolian'
{pick, without, groupBy} = require 'underscore'
async = require 'async'

module.exports = (db) ->

  collection = db.collection 'objects'

  defaultId = (object) ->
    object._id ?= new ObjectId().toString()
    object

  defaults = (roomId, object) ->
    object = defaultId object
    object.modified = Date.now()
    object.roomId = roomId
    object.position ?= {top: 0, left: 0}
    object

  save = curry (roomId, object, cb) =>
    object = defaults roomId, object
    collection.save object, cb

  update = (fields, object, cb) ->
    object.modified = Date.now()
    updates = pick object, fields.concat("modified")...
    collection.update {_id: object._id}, {$set: updates}, cb

  remove = curry (query, cb) ->
    collection.remove query, cb


  class Command
    constructor: ({@roomId, @action, @object}) ->
    go: (cb) -> throw new Error "Override go"
    run: (cb) ->
      @go (err, info) =>
        return cb err if err?
        cb null, this

  class CreateChildrenCommand extends Command
    # object is an array
    constructor: ({@roomId, @objects, @parentId}) ->
    run: (cb) => super cb
    go: (cb) ->
      return cb() if not (@objects?.length > 0)

      objects = @objects.map (obj) =>
        obj.stack = @parentId
        defaults @roomId, obj

      collection.insert objects, cb

  class CreateCommand extends Command
    go: (cb) ->

      @object = defaultId @object

      # we don't want to SAVE the sub objects

      allFields = without Object.keys(@object), "objects"
      objectWithoutChildren = pick @object, allFields

      multiCommand = new CreateChildrenCommand {roomId: @roomId, objects: @object.objects, parentId: @object._id}
      async.series [save(@roomId, objectWithoutChildren), multiCommand.run], cb

  class RemoveCommand extends Command
    go: (cb) -> 
      async.parallel [
        remove {_id: @object._id}
        remove {stack: @object._id}
      ], cb

  class MoveCommand extends Command
    go: (cb) -> update ["position"], @object, cb

  class StackCommand extends Command
    go: (cb) -> update ["stack"], @object, cb

  class UnstackCommand extends Command
    go: (cb) -> 
      @object.modified = Date.now()
      collection.update {_id: @object._id}, {$unset: {stack:1}, $set: {modified: Date.now()}}, cb

  commandForAction = (action) ->
    Class = switch action
      when "create" then CreateCommand
      when "remove" then RemoveCommand
      when "move" then MoveCommand
      when "stack" then StackCommand
      when "unstack" then UnstackCommand
      else throw new Error "Could not find command: #{action}"

  # we need to join them to their children as well!
  getAllObjects = (roomId, cb) ->
    collection.find({roomId}).toArray(cb)

  return {
    commandForAction
    getAllObjects
  }
