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

  # show follows
  robot.enter (res) ->
    channel = res.message.room.substring 1

    checkFollows = () ->
      if robot.adapter.config.get("#{channel}.show_follows") is "on"
        robot.logger.info "Checking for new follows in #{channel} ..."
        robot.adapter.twitchClient.follows channel, (error, response, body) ->
          unless error
            num = body._total
            oldNum = robot.adapter.config.get "#{channel}.num_follows"
            if num > oldNum or oldNum is undefined
              robot.adapter.config.set "#{channel}.num_follows", num
              if body.follows.length isnt 0 and oldNum isnt undefined
                nick = body.follows[0].user.name
                robot.logger.info "New follower found: #{nick}"
                res.send "Thank your for the follow #{nick}."

    setInterval checkFollows, process.env.HUBOT_TWITCH_FOLLOWS_INTERVAL || 1000 * 60

  # follows
  robot.hear /^follows/i, (res) ->
    channel = res.message.room.substring 1
    robot.adapter.twitchClient.follows channel, (error, response, body) ->
      unless error
        users = (item.user.name for item in body.follows)
        if users.length > MAX_FOLLOWS_TO_SHOW
          more = users.length - MAX_FOLLOWS_TO_SHOW - 1
          users = users.slice(0, MAX_FOLLOWS_TO_SHOW)
          res.reply "This channel is followed by: #{users.join ", "} and #{more} more."
        else
          res.reply "This channel is followed by: #{users.join ", "}."
      else
        res.reply "I was unable to get a list of the followers."
