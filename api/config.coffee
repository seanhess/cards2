
{container} = require 'dependable'
Mongolian = require 'mongolian'



config = container()

# ENV variables
PORT = process.env.PORT || 4022
MONGODB = process.env.MONGODB || "mongodb://localhost:27017/cards"

config.register "PORT", PORT
config.register "db", new Mongolian MONGODB
config.register "Room", require("./store/Room")
config.register "sockets", require("./sockets")

module.exports = config
