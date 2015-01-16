# Description
#   Twitch specific logic.
#
# Dependencies:
#   - "request": "^2.51.0"
#
# Configuration:
#   -
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

  MAX_FOLLOWS_TO_SHOW = 20

  acolyte = require "../src/acolyte"
  TwitchClient = require "../src/twitch-client"

  # note: these are not yet used as authentication is not implemented yet
  clientId = process.env.HUBOT_TWITCH_CLIENT_ID
  clientSecret = process.env.HUBOT_TWITCH_CLIENT_SECRET

  client = new TwitchClient clientId, clientSecret

  # check follows
  robot.enter (res) ->
    channel = res.message.room.substring 1

    checkFollows = () ->
      if acolyte.config.get("#{channel}.show_follows") is "on"
        robot.logger.info "Checking for new follows in #{channel} ..."
        client.follows channel, (error, response, body) ->
          unless error
            num = body._total
            oldNum = acolyte.config.get "#{channel}.num_follows"
            unless oldNum
              if num > oldNum and body.follows.length isnt 0
                nick = body.follows[0].user.name
                robot.logger.info "New follower found: #{nick}"
                res.send "Thank your for the follow #{nick}"
              acolyte.config.set "#{channel}.num_follows", num

    setInterval checkFollows, process.env.HUBOT_TWITCH_FOLLOWS_INTERVAL || 1000 * 60

  # follows
  robot.hear /^follows/i, (res) ->
    channel = res.message.room.substring 1
    client.follows channel, (error, response, body) ->
      unless error
        users = (item.user.name for item in body.follows)
        if users.length > MAX_FOLLOWS_TO_SHOW
          more = users.length - MAX_FOLLOWS_TO_SHOW - 1
          users = users.slice(0, MAX_FOLLOWS_TO_SHOW)
          res.send "This channel is followed by: #{users.join(", ")} and #{more} more."
        else
          res.send "This channel is followed by: #{users.join(", ")}."
      else
        res.send "I was unable to get a list of the followers.";
