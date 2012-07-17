# Cards2


# Feature a day
    [ ] Draw a card
        [x] show deck height / emptiness (just use a number)
        [ ] card draw should remove object from all clients and server

    [ ] Drag should put the card on top
        [ ] I don't want a context menu. Drag puts it on TOP, so you can order things that way. 
        --- but you more often want to put something BELOW something else in magic. 
        --- a single tap will put it on top!

    [ ] Better drag (should pick up earlier. How to work with tap as well?)

    [ ] Put cards in your Hand
        [ ] draw card to hand instead of showing it
    [ ] My Collection - a grid-based place to put things
        [ ] persistent data storage
        [ ] user accounts?
    [ ] Tokens
    [ ] Smaller, standard sized cards
    [ ] Reshuffle
    [ ] Put cards on deck
    [ ] Put cards in Discard pile

    [ ] Tap cards
    [ ] Flip cards over




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
