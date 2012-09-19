
{ObjectId} = require 'mongolian'
{pick} = require 'underscore'

module.exports = (db) ->

  collection = db.collection 'objects'

  class Command
    constructor: ({@roomId, @action, @object}) ->
    go: (cb) -> throw new Error "Override go"
    run: (cb) ->
      @go (err, info) =>
        return cb err if err?
        cb null, this

    defaults: (object) ->
    save: (cb) ->
      @object._id ?= new ObjectId().toString()
      @object.modified = Date.now()
      @object.roomId = @roomId
      collection.save @object, cb
    update: (fields, cb) ->
      @object.modified = Date.now()
      #console.log "TESTING", @object, updates
      updates = pick @object, fields.concat("modified")...
      collection.update {_id: @object._id}, {$set: updates}, cb

  class CreateCommand extends Command
    go: (cb) -> @save cb

  class RemoveCommand extends Command
    go: (cb) -> collection.remove {_id: @object._id}, cb

  class MoveCommand extends Command
    go: (cb) -> @update ["position"], cb

  class StackCommand extends Command
    go: (cb) -> @update ["stack"], cb

  commandForAction = (action) ->
    Class = switch action
      when "create" then CreateCommand
      when "remove" then RemoveCommand
      when "move" then MoveCommand
      else throw new Error "Could not find command: #{command.action}"

  objects = (roomId, cb) ->
    collection.find({roomId}).toArray(cb)

  return {
    commandForAction
    objects
  }
