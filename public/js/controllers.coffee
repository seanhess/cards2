

# TODO native drag on an image
# TODO notify other clients
# TODO drag move image

define ->
  window.RoomCtrl = ($scope) ->

    fakeObject = {imageUrl: "http://magiccards.info/scans/en/pd3/2.jpg"}

    # make this a directive instead!


    $scope.objects = []

    # send back the File object?
    # how am I even going to store this stuff?
    $scope.onDrop = (files) ->
      console.log "WOOT", files, files[0]

    $scope.newImage = ->
      console.log "HI"
      imageUrl = $scope.imageUrl
      console.log "NEW IMAGE!", {imageUrl}
      $scope.objects.push {imageUrl}

  window.RoomsCtrl = ->
