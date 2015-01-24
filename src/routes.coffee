express = require "express"

module.exports = (robot, utils) ->

  twitch = robot.adapter.twitchClient
  {logger, router} = robot
  {config, keyring, memory} = utils

  # static
  router.use express.static("#{__dirname}/../client/public")

  # twitch authenticaiton url
  router.post "/api/twitch/authUrl", (req, res) ->
    json =
      success: true
      url: twitch.getAuthUrl()
    res.send json

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
          json =
            success: true
            user: body
            scope: scope
            token: token
          res.send json
    else
      error = req.param "error"
      json =
        success: false
        error: error
      res.send json

  # get config
  router.get "/api/settings", (req, res) ->
    username = req.param "username"
    settings = config.get(username) || {}
    json =
      success: true
      settings: settings
    res.send json

  # save config
  router.post "/api/settings", (req, res) ->
    username = req.param "username"
    settings = req.param "settings"
    config.set username, settings
    json =
      success: true
    res.send json

  # get memory
  router.get "/api/memory", (req, res) ->
    data = memory.load()
    json =
      success: true,
      memory: data
    res.send json

  # delete memory
  router.delete "/api/memory", (req, res) ->
    id = req.param "id"
    data = memory.forget id
    json =
      success: true
    res.send json
