# Description
#   Twitch specific logic.
#
# Dependencies:
#   - "express": "^4.11.0"
#
# Configuration:
#   -
#
# Commands:
#   - !follows - shows a list of people following the channel
#   - !twitch_auth - shows whether hubot is authenticated with the Twitch API
#
# Notes:
#   -
#
# Author:
#   crisu83

module.exports = (robot) ->

  MAX_USERS_TO_LIST = 20

  express = require "express"

  config = robot.adapter.config
  client = robot.adapter.twitchClient
  logger = robot.logger

  # api
  robot.router.use express.static("#{__dirname}/../client/public")

  robot.router.post "/api/twitch/init", (req, res) ->
    data =
      url: client.getAuthUrl()
    res.send data

  robot.router.get "/api/twitch/auth", (req, res) ->
    code = req.param "code"
    if code
      logger.info "AUTH: received code #{code}"
      client.auth code, (error, response, body) =>
        logger.debug "body=#{JSON.stringify body}"
        token = body.access_token
        scope = body.scope
        logger.info "AUTH: received token #{token} with scope #{scope}"
        logger.debug "body=#{JSON.stringify body}"
        client.me token, (error, response, body) ->
          logger.debug "body=#{JSON.stringify body}"
          channel = body.name
          config.set "#{channel}.access_token", token
          logger.info "AUTH: access token #{token} stored for #{channel}"
      res.send "SUCCESS"
    else
      error = req.param "error"
      res.send "ERROR: #{error}"

  # show follows
  robot.enter (res) ->
    channel = res.message.room.substring 1

    checkFollows = () ->
      if config.get("#{channel}.show_follows") is "on"
        logger.info "Checking for new follows in #{channel} ..."
        client.follows channel, (error, response, body) ->
          unless error
            num = body._total
            oldNum = config.get "#{channel}.num_follows"
            if num > oldNum or oldNum is undefined
              config.set "#{channel}.num_follows", num
              if body.follows.length isnt 0 and oldNum isnt undefined
                nick = body.follows[0].user.name
                logger.info "New follower found: #{nick}"
                res.send "Thank your for the follow #{nick}."

    setInterval checkFollows, process.env.HUBOT_TWITCH_FOLLOWS_INTERVAL || 1000 * 60

  # follows
  robot.hear /^!follows/, (res) ->
    channel = res.message.room.substring 1
    client.follows channel, (error, response, body) ->
      unless error
        users = (item.user.name for item in body.follows)
        res.reply "This channel has #{user.length} followers."
      else
        res.reply "I was unable to determine the number of followers."

  # twitch_auth
  robot.hear /^!twitch_auth/, (res) ->
    if robot.adapter.checkAccess res.message.user.name
      channel = res.message.room.substring 1
      token = config.get "#{channel}.access_token"
      client.me token, (error, response, body) ->
        unless error
          res.reply "I'm authenticated with Twitch."
        else
          res.reply "I'm not authenticated with Twitch."
