cs = require 'coffee-script'

module.exports = coffeepot = ->
  handler = (req, res, next) ->
    return next() if not req.url.match /.coffee$/

    {write, end} = res

    content = ""
    err = null

    res.write = (data, encoding) ->
      try
        content += cs.compile data.toString()
      catch error
        err = error
        content = err.toString()

    res.end = (data, encoding) ->
      if err?
        res.statusCode = 500
        console.log "COMPILE ERROR #{req.url}", content, err
      end.call res, content, encoding

    res.on 'header', ->
      res.header 'Content-Length', content.length
      res.header 'Content-Type', 'text/javascript'

    next()
