

# TODO native drag on an image
# TODO notify other clients
# TODO drag move image

define (require) ->
  angular = require 'angular'
  {pick, clone} = require 'underscore'
  RoomCtrl = ($scope, $routeParams, Room, urls) ->

    # make the room!
    roomId = $routeParams.id
    room = Room $scope, roomId
    room.join {name: "sean"}

    $scope.room = room
    $scope.objectOrder = 'modified'

    $scope.hand = []

    # put in some fake data
    # room.save {_id:"fake", _type: "card", imageUrl: "http://magiccards.info/scans/en/mbp/47.jpg", position: {left: 200, top:10}}


    ## DROP FILES ##############################################
    $scope.onDropUrl = (url) ->
      urls.download url, (objects) ->
        room.save object
        objects.forEach (obj) -> room.save object

    $scope.isTable = (object) -> not object.group?

    $scope.dropCardInHand = (card) ->
      card.group = "hand"
      $scope.hand.push card
      # TODO save the hand. 

    $scope.playCardFromHand = (card) ->
      # $scope.hand
      delete card.group
      card.modified = Date.now()
      $scope.hand = $scope.hand.filter (c) -> c._id isnt card._id

    ## DRAG A CARD #############################################

    $scope.onDragStart = (object) ->
      console.log "DRAG START"
      object.modified = Date.now()

    $scope.onDragEnd = (object) ->
      room.save object, "position", "modified"

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
        card.position = {left: deck.position.left + 200, top: deck.position.top}
        room.save card
        room.save deck, "objects"
        # draw a card


    $scope.trash = (object) ->
      console.log "TRASH!", object
      room.remove object
        
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
