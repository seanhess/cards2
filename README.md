# Cards2

CLEANUP
[ ] single click no longer triggers the modifcation thing (end?) Make it so it changes it so they can be on top. 



CLIENT-SIZE MODEL WITH SERVER STORE
[x] save: updates the properties specified (underscore's pick)
[x] change to use a database
[ ] decks: are a bunch of items at the same place, with the "group" property set
[ ] decks: draw a card

BEST MODEL
either:
  1. have all the functionality on the server. RPC. "drawCard", "blah", "blah"
  2. have everything on the client: direct manipulation and just call "save"

I think it will be easier to write if I adopt Rob's model: clients making changes to a shared data model (with locking? ownership?)



Server Model: 
+ more reusable between clients
- more annoying
- hard to do things like dragging, where the client state is out of sync, or drawing from a hand, if you want to drag

Collections
  1. have a "collection" object on the server
  2. have a "group" property on the objects (lets you drag it around as a group)

[x] Drag and Drop:
[ ] My Hand
  [ ] drop cards into it, they get added to its collection
      [ ] store hands on the server
  [ ] cards get removed from the board
      [ ] store on the server
  [ ] draw moves immediately to the hand

  [ ] drag out removes from hand. + persist
  [ ] drag out adds to board
      [ ] get position from start event
      [ ] put it at the right spot. and let it move


  [ ] GENERIC: collections / groups of stuff
    --- hand, discard piles, decks
    you can drag items into them    
    you can drag items OUT of them (different depending on type)
    items end up BACK on the board (maybe I shouldn't actually HIDE them then. Do what rob does and just set the position. keep it simple)
    (OR - I need a way to add/remove them, etc)



    [ ] Build a deck
        [ ] My Collection - a grid-based place to put things
        [ ] persistent data storage
        [ ] user accounts?

    [ ] Shuffle
    [ ] Put cards on deck
    [ ] Put cards in Discard pile

    [ ] Flip cards over
    [ ] Tokens/Counters? (No, just use extra cards)
    [ ] Context Menu! (there are too many actions to perform, like move back)

    [ ] Zoom? How are you going to fit everything?
      [ ] focus card (closer look)
      [ ] scrolling works great
      [ ] zoom gestures?

# Todo
√ drag and drop images

* users: current state
* users: leave

√ drag and drop json files?
* decks
  √ add a deck (json file? json url?)
  √ render the card back, with some borders
  * draw a card (what does it do?)
      double-click: takes a card out and adds it to the board (should be just a save card) (+ update the deck?, that's ... a lot of crap to update) you can choose to only render the 1st item in a deck, no?


DECKS ARE AN IMAGE (no cards in the data)
  = each time you draw a card, you have to re-save the whole deck!
  = UNLESS you don't send down all the deck details. Draw a card can be a request. Gives you back the drawn card and updates the deck, but doesn't need to send down an UPDATE to the deck, really, except for the deck size.

DECKS ARE A CARD STACK
  = draw a card is easy: just move it
  = move is more complicated. you have to move ALL of them
      
  * flip cards
  * shuffle

# THOUGHTS
How to render a deck? 
  - lay out all the cards
  - have a "deck" image
  - repeat the card back depending on how many cards there are?

# QUESTIONS
* how can I get my socket service to work without passing the $scope? seems lame to use $rootScope, or is it not that bad?
* better way to pass variables back to your function, without them needing to magically know it?







jquery nearest plugin: will find the nearest element matching a selector
