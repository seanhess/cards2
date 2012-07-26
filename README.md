# Cards2
[ ] Drag and Drop:
  - use html5 drag and drop, totally simple/natural, just change the drag target/image thing and tie into it. it'll all work.  DO THIS!
  xxx not going to look as good. you can't do the effects like you can otherwise
  xxx must be a drag IMAGE
  xxx hard to get it working. why is it too hard

  - figure out how to tie your fake drag and drop into the real one
  xxx doesn't work to make it do BOTH.

  - fully fake drag and drop (don't use real, if something is draggable, then check to see if it hits it. 
    -- who needs the native stuff! It's annoying. See how rob does it.
  xxx rob keeps a freaking GLOBAL array of droppables

  - find a jquery plugin that does something close
  xxx t0o hard with bad internet
  xxx it looks like they just do it custom anyway

  OK, MAKE YOUR OWN CUSTOM
  -- already can get it draggable, and get data onto the event, or something
  -- how to get a drop hover thing going?

  -- on draggable drag move, check for hits at event location?

# Feature a day
    [ ] Draw a card
        [x] show deck height / emptiness (just use a number)
        [ ] card draw should remove object from all clients and server

    [x] Drag should put the card on top
    [x] Better drag (should pick up earlier. How to work with tap as well?)


DRAG AND DROP
  - don't support touch devices. The resolutions are all different. Everything is different
  - then you can use normal drag and drop instead of your custom one (then you can set data)


    [ ] My Hand - persistent thing. Collection, with reorder?
        --- just make one hand for now
        [ ] drop cards onto it, they disappear? (they get added to a hand)
        [ ] draw card to hand instead of showing it

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
