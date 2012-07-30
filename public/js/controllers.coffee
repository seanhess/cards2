

# TODO native drag on an image
# TODO notify other clients
# TODO drag move image

define (require) ->
  angular = require 'angular'
  RoomCtrl = ($scope, $routeParams, Room) ->

    # make the room!
    roomId = $routeParams.id
    room = Room $scope, roomId
    room.join {name: "sean"}

    currentIndex = 0

    $scope.room = room

    $scope.order = 'modified'

    $scope.newImage = ->

    ## DROP FILES ##############################################
    $scope.onDropUrl = room.saveUrl

    $scope.dropCardInHand = (card) ->
      console.log "DROP CARD IN HAND", card

    ## DRAG A CARD #############################################

    $scope.onDragStart = (object) ->
      object.modified = Date.now()

    # # I need to call it with: object, changeX, changeY
    $scope.onDragEnd = (object) ->
      # console.log "DRAG END #{object._id}"
      room.save object

    # # local move modification
    # sorted by stuffssszz!
    $scope.onDragMove = (object, dx, dy) ->
      object.position.left += dx
      object.position.top += dy

    ## DRAW CARD ###############################################
    $scope.onDragClick = (object) ->
      if object._type is "deck"
        room.draw object
        
    $scope.offsetCard = (index) ->
      left: -index/3
      top: -index/3

  RoomsCtrl = ->

  return {RoomCtrl, RoomsCtrl}


