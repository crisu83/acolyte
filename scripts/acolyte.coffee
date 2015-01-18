# Description
#   Personality of Acolyte.
#
# Dependencies:
#   - "jsdom": "^2.0.0"
#
# Configuration:
#   -
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

  # greet
  robot.enter (res) ->
    channel = res.message.room.substring 1
    if res.message.user.name is robot.name
      res.send "Greetings! I'm Acolyte, your personal Twitch robot. I was created by Calistar to assist you."
    else if robot.adapter.config.get("#{channel}.show_greet") is "on"
      res.send "Hello " + res.message.user.name + "!"

  # config
  robot.hear /^config ([\w_]+) (on|off|remove)/i, (res) ->
    channel = res.message.room.substring 1
    [key, value] = res.match.splice 1
    if res.message.user.name.toLowerCase() is channel.toLowerCase()
      unless value is "remove"
        robot.adapter.config.set "#{channel}.#{key}", value
        res.send "#{key} is now #{value}."
      else
        robot.adapter.config.remove "#{channel}.#{key}"
        res.send "#{key} removed."

  # psn
  robot.hear /^psn/, (res) ->
    options =
      url: "https://support.us.playstation.com/app/answers/detail/a_id/237/~/psn-status%3A-online",
      scripts: ["http://code.jquery.com/jquery.js"],
      done: (error, window) ->
        $ = window.$
        if $("#rn_AnswerText").length > 0
          $element = $("#rn_AnswerText > p > span[style] > b").first();
          status = $element.text().toUpperCase() || "ONLINE"
          res.reply "PSN seems to be #{status}."
        else
          res.reply "I'm sorry, I was unable to determine the status of PSN."
    jsdom.env options
