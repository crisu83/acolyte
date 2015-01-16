class Config
  STORAGE_KEY: "acolyte.config"

  VALID_KEYS: ["greet", "show_follows"]

  constructor: (@robot) ->

  get: (key) ->
    data = @load()
    value = data[key]
    @robot.logger.info "Config.get: #{@STORAGE_KEY}.#{key} (#{value})"
    value

  set: (key, value) ->
    @robot.logger.info "Config.set: #{@STORAGE_KEY}.#{key} = #{value}"
    data = @load()
    data[key] = value
    unless @save data
      @robot.logger.error "ERROR: Failed to save config."

  exists: (key) ->
    @VALID_KEYS.indexOf key isnt -1

  load: () ->
    @robot.brain[@STORAGE_KEY] || {}

  save: (data) ->
    @robot.brain[@STORAGE_KEY] = data

module.exports = Config
