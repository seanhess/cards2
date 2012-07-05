request = require 'request'
{curry} = require 'fjs'

# downloads the url, and creates an object based on it
exports.downloadUrl = curry (url, cb) ->

  if isImageUrl url
    object =
      imageUrl: url
      position: {left: 0, top: 0}
    return cb null, object

  request.get {url, json:true}, (err, res, body) ->
    if err? then return cb err
    object = body
    object.position = {left: 0, top: 0}
    cb null, object


## HELPERS ######
isImageUrl = (url) -> url.match(/\.(png|jpg|jpeg|)$/)?



