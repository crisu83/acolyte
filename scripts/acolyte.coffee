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

  # greet
  robot.enter (res) ->
    if res.message.user.name is process.env.HUBOT_IRC_NICK
      res.send "Greetings! I am Acolyte, your personal Twitch robot. Calistar is my master and I will do anything he demands."
    else if robot.room.users.length < 10
      res.send "Hello " + res.message.user.name + "!"

  # !psn
  robot.hear /psn/i, (res) ->
    options =
      url: "https://support.us.playstation.com/app/answers/detail/a_id/237/~/psn-status%3A-online",
      scripts: ["http://code.jquery.com/jquery.js"],
      done: (error, window) ->
        $ = window.$
        if $("#rn_AnswerText").length > 0
          $element = $("#rn_AnswerText > p > span[style] > b").first();
          status = $element.text().toUpperCase()
          res.send "PSN seems to be #{status}."
        else
          res.send "I am sorry, I was unable to determine the status of PSN."
    jsdom.env options
