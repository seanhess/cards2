# just some schema definitions.
# TODO use protobuf or avro (maybe thrift?)



exports.Position = class Position
  top: Number
  left: Number

exports.Object = class Object
  _id: String
  imageUrl: String
  position: Position
  # any object can have things ON TOP OF IT
  # if you move it around, they come with it
  objects: [Object]

exports.Card = class Card extends Object
  backImageUrl: String

exports.Deck = class Deck = extends Object
  cards: [Object]


# TODO validate?
# exports.validate = validate = (schema, object) ->




###
how to sync this data model to the server
1. person drags an object onto another
2. update the top/left to be where it is. then update the rest?
  OR actually remove it from the dom and add it to its parent, so you get it to move around for free?

- think about what is easiest to SYNC between client and server
  x if you can send down the whole array

  - parentId? - have a collection object too?

  do I really need to have every object be down on there? when you load the page, you don't need to send everything down.

  what is an array, really? 
    1. order. I don't actually care
    2. a bunch of objects

  TCP packet size: 1500 bytes = 1400 before header. So don't send down the whole array :) Obviously the state change of an individual object is important, but that's easy to sync.

  parentId: would require updating EVERY item in the array anyway
  remove: would require removing EVERY item in the array

  Just do that then!

  Well, wait. You're not usually going to be putting things INTO a deck. You'll be taking them out.

  Take a card out. DECIDE THIS LATER

  does every card have a back image?

1. add a deck of cards
2. figure out how to draw a card off
3. add card backs
4. add flipping

###
