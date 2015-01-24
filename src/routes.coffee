express = require "express"

module.exports = (robot) ->

  logger = robot.logger
  router = robot.router
  twitch = robot.adapter.twitchClient

  # static
  router.use express.static("#{__dirname}/../client/public")

  # acolyte config
  router.get "/api/config", (req, res) ->
    token = req.param "token"
    client.me token, (error, response, body) ->
      # todo: implement this

  # twitch authenticaiton url
  router.post "/api/twitch/authUrl", (req, res) ->
    data =
      url: twitch.getAuthUrl()
    res.send data

  # twitch authentication callback
  router.post "/api/twitch/token", (req, res) ->
    code = req.param "code"
    if code
      logger.info "AUTH: received code #{code}"
      twitch.auth code, (error, response, body) ->
        logger.debug "body=#{JSON.stringify body}"
        token = body.access_token
        scope = body.scope
        logger.info "AUTH: received token #{token} with scope #{scope}"
        logger.debug "body=#{JSON.stringify body}"
        twitch.me token, (error, response, body) ->
          logger.debug "body=#{JSON.stringify body}"
          username = body.name
          # todo: save this somewhere else
          #config.set "#{username}.access_token", token
          #logger.info "AUTH: access token #{token} stored for #{username}"
          data =
            name: username
            scope: scope
            token: token
          res.send data
    else
      error = req.param "error"
      res.send "ERROR: #{error}"
