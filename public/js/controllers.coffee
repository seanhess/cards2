

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

    $scope.room = room

    $scope.newImage = ->

    ## DROP FILES ##############################################
    $scope.onDropUrl = room.saveUrl

    ## DRAG A CARD #############################################
    # # I need to call it with: object, changeX, changeY
    $scope.onDragEnd = (object) ->
      room.save object

    # # local move modification
    $scope.onDragMove = (object, dx, dy) ->
      object.position.left += dx
      object.position.top += dy


  RoomsCtrl = ->

  return {RoomCtrl, RoomsCtrl}


