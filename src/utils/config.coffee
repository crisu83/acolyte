class Config
  STORAGE_KEY: "acolyte.config"

  constructor: (@robot) ->

  get: (channel) ->
    data = @load()
    config = data[channel] || {}
    @robot.logger.info "CONFIG: Get config for #{channel} (#{JSON.stringify config})"
    config

  set: (channel, config) ->
    data = @load()
    data[channel] = config
    unless @save data
      @robot.logger.error "ERROR: Failed to save config."
    @robot.logger.info "CONFIG: Update config for #{channel} (#{JSON.stringify config})"

  remove: (channel) ->
    data = @load()
    config = data[channel]
    delete data[channel]
    @robot.logger.info "CONFIG: Remove config for #{channel} (#{JSON.stringify config})"

  load: ->
    @robot.brain[@STORAGE_KEY] || {}

  save: (data) ->
    @robot.brain[@STORAGE_KEY] = data

module.exports = Config
