

define (require) ->

  ## HELPERS ######
  isImageUrl = (url) -> url.match(/\.(png|jpg|jpeg|)$/)?

  ## SERVICE ######
  urls = ($http) ->
    download: (url, cb) ->
      # assume it is a card!
      if isImageUrl url
        object = imageUrl: url
        return cb [object]

      $http.get("/fetch/" + url).success (object) ->
        cb object

