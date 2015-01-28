express = require "express"
JsonResponse = require "./utils/json-response.coffee"

module.exports = (robot, utils) ->

  twitch = robot.adapter.twitchClient
  {logger, router} = robot
  {config, keyring, memory} = utils

  # static
  router.use express.static("#{__dirname}/../client/public")

  # get twitch authentication url
  router.get "/api/twitch/authUrl", (req, res) ->
    json = new JsonResponse
    json.add "url", twitch.getAuthUrl()
    res.send json.success()

  # post twitch authentication code
  router.post "/api/twitch/code", (req, res) ->
    json = new JsonResponse
    code = req.param "code"
    if code
      logger.info "AUTH: received code #{code}"
      twitch.auth code, (error, response, body) ->
        unless error
          logger.debug "body=#{JSON.stringify body}"
          token = body.access_token
          scope = body.scope
          logger.info "AUTH: received token #{token} with scope #{scope}"
          logger.debug "body=#{JSON.stringify body}"
          twitch.me token, (error, response, body) ->
            unless error
              logger.debug "body=#{JSON.stringify body}"
              keyring.add body.name, token
              json.add "user", body
              json.add "scope", scope
              json.add "token", token
              res.send json.success()
            else
              res.send json.error(error)
        else
          res.send json.error(error)
    else
      res.send json.error(req.param "error")

  # get twitch follows
  router.get "/api/twitch/follows", (req, res) ->
    json = new JsonResponse
    channel = req.param "channel"
    token = req.param "token"
    if keyring.validate channel, token
      twitch.follows channel, (error, response, body) ->
        unless error
          json.add "follows", body.follows
          res.send json.success()
        else
          res.send json.error(error)
    else
      res.send json.error("Authentication failed")

  # get twitch subscriptions
  router.get "/api/twitch/subscriptions", (req, res) ->
    json = new JsonResponse
    channel = req.param "channel"
    token = req.param "token"
    if keyring.validate channel, token
      twitch.subscriptions channel, (error, response, body) ->
        unless error
          # todo: implement
          res.send json.success()
        else
          res.send json.error(error)
    else
      res.send json.error("Authentication failed")

  # get status
  router.get "/api/status", (req, res) ->
    json = new JsonResponse
    channel = req.param "channel"
    token = req.param "token"
    if keyring.validate channel, token
      status = robot.adapter.active '#' + channel
      json.add "status", status
      res.send json.success()
    else
      res.send json.error("Authentication failed")

  # post join
  router.post "/api/join", (req, res) ->
    json = new JsonResponse
    channel = req.param "channel"
    token = req.param "token"
    if keyring.validate channel, token
      status = robot.adapter.join "#" + channel
      json.add "status", status
      res.send json.success()
    else
      res.send json.error("Authentication failed")

  # post part
  router.post "/api/part", (req, res) ->
    json = new JsonResponse
    channel = req.param "channel"
    token = req.param "token"
    if keyring.validate channel, token
      status = !robot.adapter.part "#" + channel
      json.add "status", status
      res.send json.success()
    else
      res.send json.error("Authentication failed")

  # get config
  router.get "/api/settings", (req, res) ->
    json = new JsonResponse
    channel = req.param "channel"
    token = req.param "token"
    if keyring.validate channel, token
      settings = config.get channel || {}
      json.add "settings", settings
      res.send json.success()
    else
      res.send json.error("Authentication failed")

  # save config
  router.post "/api/settings", (req, res) ->
    json = new JsonResponse
    channel = req.param "channel"
    token = req.param "token"
    settings = req.param "settings"
    if keyring.validate channel, token
      config.set channel, settings
      res.send json.success()
    else
      res.send json.error("Authentication failed")

  # get memory
  router.get "/api/memory", (req, res) ->
    json = new JsonResponse
    data = memory.load()
    json.add "memory", data
    res.send json.success()

  # delete memory
  router.delete "/api/memory", (req, res) ->
    json = new JsonResponse
    id = req.param "id"
    if id
      data = memory.forget id
      res.send json.success()
    else
      res.send json.error()
