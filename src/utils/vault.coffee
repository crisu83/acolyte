Store = require "./store"

class Vault extends Store
  STORAGE_KEY: "acolyte.vault"

  constructor: (@robot) ->

  get: (username, key) ->
    data = @load()
    unless data[username]
      data[username] = {}
    value = data[username][key]
    @robot.logger.info "VAULT: Get #{key} for #{username} (#{value})"
    value

  set: (username, key, value) ->
    data = @load()
    unless data[username]
      data[username] = {}
    data[username][key] = value
    unless @save data
      @robot.logger.error "ERROR: Failed to save values in vault."
    @robot.logger.info "VAULT: Set #{key} for #{username} (#{value})"

module.exports = Vault
