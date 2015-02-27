module.exports = (robot, utils) ->

  MAX_USERS_TO_LIST = 20

  config = require("../utils/config").use robot
  keyring = require("../utils/keyring").use robot
  vault = require("../utils/vault").use robot

  client = robot.adapter.twitchClient
  logger = robot.logger

  # event: enter
  robot.enter (res) ->
    channel = res.message.room.substring 1
    settings = config.get channel

    checkFollows = () ->
      if settings.show_follows
        logger.info "Checking for new follows in #{channel} ..."
        client.follows channel, (error, response, body) ->
          unless error
            num = body._total
            oldNum = vault.get channel, "num_follows"
            if num > oldNum or oldNum is undefined
              vault.set channel, "num_follows", num
              if body.follows.length isnt 0 and oldNum isnt undefined
                nick = body.follows[0].user.name
                logger.info "New follower found: #{nick}"
                res.send "Thank your for the follow #{nick}."

    setInterval checkFollows, process.env.HUBOT_TWITCH_FOLLOWS_INTERVAL || 1000 * 60

  # command: !follows
  robot.hear /^!follows/, (res) ->
    channel = res.message.room
    client.follows channel, (error, response, body) ->
      unless error
        users = (item.user.name for item in body.follows)
        res.reply "This channel has #{user.length} followers."
      else
        res.reply "I was unable to determine the number of followers."

  # command: !twitch_auth
  robot.hear /^!twitch_auth/, (res) ->
    username = res.message.user.name
    if robot.adapter.checkAccess username
      channel = res.message.room
      token = keyring.get channel
      client.me token, (error, response, body) ->
        unless error
          res.reply "I'm authenticated with Twitch."
        else
          res.reply "I'm not authenticated with Twitch."
