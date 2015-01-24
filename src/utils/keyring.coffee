class Keyring
  STORAGE_KEY: "acolyte.keyring"

  constructor: (@robot) ->

  get: (username) ->
    data = @load()
    token = data[username]
    @robot.logger.info "KEYRING: Get token for #{username} (#{token})"
    token

  add: (username, token) ->
    data = @load()
    data[username] = token
    unless @save data
      @robot.logger.error "ERROR: Failed to save token in keyring."
    @robot.logger.info "KEYRING: Added token #{token} for #{username}"

  remove: (username) ->
    data = @load()
    token = data[username]
    delete data[username]
    @robot.logger.info "KEYRING: Remove token for #{username} (#{token})"

  load: ->
    @robot.brain[@STORAGE_KEY] || {}

  save: (data) ->
    @robot.brain[@STORAGE_KEY] = data

module.exports = Keyring
