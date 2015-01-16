# Description
#   Personality of Acolyte.
#
# Dependencies:
#   - jsdom
#
# Configuration:
#   HUBOT_IRC_NICK
#   HUBOT_IRC_PASSWORD
#   HUBOT_IRC_ROOMS
#
# Commands:
#   - !psn - Tells you the current status of the PlayStation Network
#
# Notes:
#   -
#
# Author:
#   crisu83

module.exports = (robot) ->

  jsdom = require "jsdom"

  # todo: move this configuration class to a separate file
  class Config
    STORAGE_KEY: "acolyte.config"

    constructor: (@robot) ->

    get: (key) ->
      data = @load()
      data[key] ? null

    set: (key, value) ->
      data = @load()
      data[key] = value
      if @save(data)
        @robot.logger.info("#{@STORAGE_KEY}.#{key} = #{value}")

    load: () ->
      @robot.brain.get(@STORAGE_KEY) || {}

    save: (data) ->
      @robot.brain.set(@STORAGE_KEY, data)


  config = new Config(robot)

  # greet
  robot.enter (res) ->
    channel = res.message.room.substring(1)
    if res.message.user.name is process.env.HUBOT_IRC_NICK
      res.send "Greetings! I'm Acolyte, your personal Twitch robot. Calistar is my master and I'll do anything he demands."
    else if config.get "#{channel}.greet" is "on"
      res.send "Hello " + res.message.user.name + "!"

  # config
  robot.hear /config (\w+) (on|off)/i, (res) ->
    channel = res.message.room.substring(1)
    key = res.match[1]
    value = res.match[2]
    if res.message.user.name is channel and ['greet'].indexOf(key) isnt -1
      config.set "#{channel}.#{key}", value
      res.send "#{key.toUpperCase()} is now #{value.toUpperCase()}."

  # psn
  robot.hear /psn/i, (res) ->
    options =
      url: "https://support.us.playstation.com/app/answers/detail/a_id/237/~/psn-status%3A-online",
      scripts: ["http://code.jquery.com/jquery.js"],
      done: (error, window) ->
        $ = window.$
        if $("#rn_AnswerText").length > 0
          $element = $("#rn_AnswerText > p > span[style] > b").first();
          status = $element.text().toUpperCase() || "ONLINE"
          res.send "PSN seems to be #{status}."
        else
          res.send "I'm sorry, I was unable to determine the status of PSN."
    jsdom.env options
