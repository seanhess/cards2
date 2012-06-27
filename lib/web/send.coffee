
exports.send = (res) ->
  (err, data) ->
    if err? then return res.send err.message, 500
    if not data? then return res.send 404
    res.send data
