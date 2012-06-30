

# TODO native drag on an image
# TODO notify other clients
# TODO drag move image

define ->
  window.RoomCtrl = ($scope, $routeParams, Room) ->

    # make the room!
    roomId = $routeParams.id
    room = Room $scope, roomId
    room.join {name: "sean"}

    $scope.room = room

    $scope.newImage = ->
      object =
        imageUrl: $scope.imageUrl
        position: {left: 0, top: 0}
      room.save object

    ## DROP FILES ##############################################
    # # send back the File object?
    # # how am I even going to store this stuff?
    # $scope.onDrop = (files) ->
    #   console.log "WOOT", files, files[0]


    ## DRAG A CARD #############################################
    # # I need to call it with: object, changeX, changeY
    $scope.onDragEnd = (object) ->
      room.save object

    # # local move modification
    $scope.onDragMove = (object, dx, dy) ->
      object.position.left += dx
      object.position.top += dy





  window.RoomsCtrl = ->
