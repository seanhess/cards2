# Cards2

CLEANUP
[ ] single click no longer triggers the modifcation thing (end?) Make it so it changes it so they can be on top. 



EVEN BETTER MODEL
the best model would be the most like a single environment: an array with the objects on the board, you can MOVE them to another array, but they stay in memory, so you never duplicate them
  -- that's like: relational data. The cards can be MOVED to another array, but not duped
  :: ensure they can't be in more than one: put the property on the card

card: id, group, order

what does it mean to be IN another thing? 
  - data perspective: need to be able to access the cards in a particular group / get the first one (drawing a card)
  = a function: objectsInGroup(group), or optimize by ALSO putting them in an array (but, the same object) (ah.... that's what I need to do) (naw, it's more complicated, just do the function)

  - visually: hand cards need to disappear for everyone else
  = hide them via the filter

  - visually: deck cards need to appear on top of each other
  = hide them via the filter


relationships?
  - array of ids
  = makes ordering simple. makes updates more complicated
  = makes the deck more complicated: do we maintain a map of id -> object? (I already have one of those anyway!)
    :: first card = easy, grab id, look up in map, remove from array, save deck
    :: # of cards = easiest - check order
    :: shuffle = easiest - reorder and save the deck

  - or an array of the actual objects
    :: first card = easyish?, get 0, remove from array. save deck? (just save it with the full objects? just up and save?) (not actually easier!)
    :: # of cards = easiest
    :: shuffle = easyish - reorder and save the deck

    ?? If I do it this way, there will be a card object, and a duplicate one in the deck (both are stored), but I have to make sure that when they are saved, the deck one refers to the real one. (If it exists?). It doesn't matter, they will be in sync. The only danger is if the one outside doesn't have its _group_ set property. Then it might show up, even though it is inside the deck. Try it!

  So in the end, they are similar. But definitly use one of these!

  DECK TIME
    - i think it would be cooler to have each side store them the way that is best
    - that won't make it easier though, because I have to have a special save, no?
    -- unless I have a simple thing that looks for sub objects, or children
    -- hand? do I have the "hand" object?

  CLIENT SIDE

  - from other data sources
    :: you don't want to just have IDS. You want the whole object.
    :: which means that a "deck object" will probably be more like #2


deletion
  - add a deleted property. have a cleanup method later

moving them around
  - just change the group and save

reordering via shuffle
  - the deck has an array of ids (no, an array of objects!) (well, not on the server, right?)

your hand
  - is an array of ids


CLIENT-SIZE MODEL WITH SERVER STORE
[x] save: updates the properties specified (underscore's pick)
[x] change to use a database
[x] decks: draw a card
[x] remove an object

[x] draw from deck.
[ ] decks: put card back in (on top)
[ ] decks: shuffle

[ ] decks: if you delete a deck, it doesn't delete all the cards (because they are in the group, but the parent doesn't exist)

[ ] don't use group unless you use that instead of sub-arrays. just remove them!

!!! keep them in an array, because that makes the most sense
--- you don't have to REMOVE them, because you have the filter

[ ] move a card to your hand
[ ] move a card out of your hand
[ ] card to discard pile

[ ] put a card back in a deck

Decks/Hands - does the deck "contain" all its cards?


EVERYTHING ON THE BOARD
just in a stack, or in your hand. it's "where" it is. either on the table, or on something else

$scope.table = []
$scope.hand = []

when you pick something up, it's not really on the table, it's floating

but for syncing, it's better to do it the other way

does $scope.table have EVERYTHING? no, scope.objects does, but not scope.table. Try using filters?


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
