# Description
#   Contains generic logic for Acolyte.
#
# Dependencies:
#   -
#
# Configuration:
#   HUBOT_IRC_NICK
#   HUBOT_IRC_PASSWORD
#   HUBOT_IRC_ROOMS
#
# Commands:
#   -
#
# Notes:
#   -
#
# Author:
#   crisu83

module.exports = (robot) ->

  # hello
  robot.enter (res) ->
    if res.message.user.name is process.env.HUBOT_IRC_NICK
      res.send "Hi there! I am Acolyte, your personal Twitch robot. Calistar is my master and I will do anything he demands."
    else
      res.send "Hello " + res.message.user.name + "!"
