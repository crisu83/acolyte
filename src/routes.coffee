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

  # get status
  router.get "/api/status", (req, res) ->
    channel = req.param "channel"
    token = req.param "token"
    if keyring.validate channel, token
      status = robot.adapter.active '#' + channel
      json =
        success: true
        status: status
    else
      json =
        success: false
        error: "Invalid token"
    res.send json

  # post join
  router.post "/api/join", (req, res) ->
    channel = req.param "channel"
    token = req.param "token"
    if keyring.validate channel, token
      status = robot.adapter.join "#" + channel
      json =
        success: true
        status: status
    else
      json =
        success: false
        error: "Invalid token"
    res.send json

  # post part
  router.post "/api/part", (req, res) ->
    channel = req.param "channel"
    token = req.param "token"
    if keyring.validate channel, token
      status = !robot.adapter.part "#" + channel
      json =
        success: true
        status: status
    else
      json =
        success: false
        error: "Invalid token"
    res.send json

  # get config
  router.get "/api/settings", (req, res) ->
    channel = req.param "channel"
    token = req.param "token"
    if keyring.validate channel, token
      settings = config.get channel || {}
      json =
        success: true
        settings: settings
    else
      json =
        success: false
        error: "Invalid token"
    res.send json

  # save config
  router.post "/api/settings", (req, res) ->
    channel = req.param "channel"
    token = req.param "token"
    settings = req.param "settings"
    if keyring.validate channel, token
      config.set channel, settings
      json =
        success: true
    else
      json =
        success: false
        error: "Invalid token"
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
