express = require "express"

module.exports = (robot, utils) ->

  twitch = robot.adapter.twitchClient
  {logger, router} = robot
  {config, keyring} = utils

  # static
  router.use express.static("#{__dirname}/../client/public")

  # twitch authenticaiton url
  router.post "/api/twitch/authUrl", (req, res) ->
    data =
      success: true
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
          keyring.add body.name, token
          data =
            success: true
            user: body
            scope: scope
            token: token
          res.send data
    else
      error = req.param "error"
      data =
        success: false
        error: error
      res.send data

  # get config
  router.get "/api/settings", (req, res) ->
    username = req.param "username"
    settings = config.get(username) || {}
    data =
      success: true
      settings: settings
    res.send data

  # save config
  router.post "/api/settings", (req, res) ->
    username = req.param "username"
    settings = req.param "settings"
    config.set username, settings
    data =
      success: true
    res.send data
