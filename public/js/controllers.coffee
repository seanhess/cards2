

# TODO native drag on an image
# TODO notify other clients
# TODO drag move image

define (require) ->
  angular = require 'angular'
  {pick} = require 'underscore'
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
      urls.download url, (object) ->
        room.save object

    # $scope.dropCardInHand = (card) ->
    #   $scope.hand.push card

    # $scope.dragHand = (card) ->
    #   # $scope.hand
    #   card.position = {top: 100, left: 100}
    #   $scope.room.objects.push card
    #   $scope.onDragStart(card)

      # are hands local, or synced?
      # if you disconnect, what happens to your hand?

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
      # if object._type is "deck"
      #   room.draw object
        
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
