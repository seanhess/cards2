

define (require) ->

  ## HELPERS ######
  isImageUrl = (url) -> url.match(/\.(png|jpg|jpeg|)$/)?

  ## SERVICE ######
  urls = ($http) ->
    download: (url, cb) ->
      # assume it is a card!
      if isImageUrl url
        object =
          _type: "card"
          imageUrl: url
          position: {left: 0, top: 0}
        return cb object

      $http.get("/fetch/" + url).success (object) ->
        object.position = {left: 0, top: 0}
        cb object

