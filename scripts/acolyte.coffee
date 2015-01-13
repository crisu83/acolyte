require 'newrelic'

module.exports = (robot) ->

  # hello
  robot.enter (res) ->
    if res.message.user.name is process.env.HUBOT_IRC_NICK
      res.send "Hi there! I am Acolyte, your personal Twitch robot. Calistar is my master and I will do anything he demands."
    else
      res.send "Hello " + res.message.user.name + "!"

  robot.hear /!now/i, (res) ->
    now = new Date
    res.send "The time is " + now

  # more ...
