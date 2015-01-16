Config = require "./config"
TwitchClient = require "./twitch-client"

class Acolyte
  constructor: () ->

  configure: (robot) ->
    @config = new Config robot

module.exports = new Acolyte # singleton
