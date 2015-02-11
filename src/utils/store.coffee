class Store
  STORAGE_KEY: "acolyte.store"

  constructor: (@robot) ->

  load: ->
    @robot.brain.get(@STORAGE_KEY) || {}

  save: (data) ->
    @robot.brain.set @STORAGE_KEY, data
    @robot.brain.save()

module.exports = Store
