

# TODO native drag on an image
# TODO notify other clients
# TODO drag move image

define (require) ->
  {pick, clone} = require 'underscore'
  RoomCtrl = ($scope, $routeParams, Room, urls) ->

    # make the room!
    roomId = $routeParams.id
    room = Room $scope, roomId
    room.sendJoin {name: "sean"}

    $scope.room = room
    $scope.objectOrder = 'modified'

    $scope.hand = room.ensureParentExists "hand"

    # put in some fake data
    # room.save {_id:"fake", _type: "card", imageUrl: "http://magiccards.info/scans/en/mbp/47.jpg", position: {left: 200, top:10}}


    ## DROP FILES ##############################################
    $scope.onDropUrl = (url) ->
      urls.download url, (object) ->
        room.sendCreate object
        # objects.forEach (obj) -> room.save object

    $scope.isOnTable = (object) -> not object.deleted

    $scope.dropCardInHand = (card) ->
      card.stack = "hand"
      room.sendStack card

    $scope.playCardFromHand = (card) ->
      # $scope.hand
      room.sendUnstack card

    ## DRAG A CARD #############################################

    $scope.onDragStart = (object) ->
      object.modified = Date.now()

    $scope.onDragEnd = (object) ->
      room.sendMove object

    $scope.onDragMove = (object, dx, dy) ->
      object.position.left += dx
      object.position.top += dy

    ## DRAW CARD ###############################################
    $scope.onDragClick = (object) ->
      object.modified = Date.now()

      if object._type is "deck"
        deck = object
        card = deck.objects.pop()
        card.modified = Date.now()
        card.position = {left: 0, top: 0}
        card.stack = "hand"
        room.sendStack card
        # draw a card


    $scope.addToDeck = (deck, card) ->
      deck.objects.push card
      room.remove card
      room.save deck

    $scope.trash = (object) ->
      room.sendRemove object
        
  RoomsCtrl = ->

  return {RoomCtrl, RoomsCtrl}






###

      # draw a card from the deck and return it (PUT THIS ON THE SERVER)
      draw = (deck) ->
        card = deck.objects.shift()
        if card?
          card.position =
            left: deck.position.left + 200
            top: deck.position.top
          sendSave card

###
