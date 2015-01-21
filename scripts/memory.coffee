# Description
#   A memory for Hubot's brain powered by Lunr.
#
# Dependencies:
#   - "lunr": "^0.5.7"
#   - "shortid": "^2.1.3"
#
# Configuration:
#   -
#
# Commands:
#   - !learn <thing> - Teaches Hubot a new thing
#   - !ask <question> - Asks Hubot a question
#
# Notes:
#   -
#
# Author:
#   crisu83

lunr = require "lunr"
shortid = require "shortid"

class Memory
  STORAGE_KEY: "memory"

  constructor: (@robot) ->
    @logger = @robot.logger
    @index = lunr ->
      @ref "id"
      @field "body"
      @field "time"
    @recall()

  recall: ->
    data = @load()
    num = 0
    for item in data
      @index.add item
      num++
    @logger.info "MEMORY: Recalled #{num} things"

  tell: (thing) ->
    data = @load()
    item = @createItem thing
    @index.add item
    data[item.id] = item.body
    unless @save data
      @logger.error "ERROR: Failed to learn a new thing."
    @logger.info "MEMORY: Learned that '#{thing}' (#{item.id})"

  ask: (query) ->
    data = @load()
    @logger.info "MEMORY: Trying to answer '#{query}'"
    result = @index.search query
    @logger.debug "result=#{JSON.stringify result} data=#{JSON.stringify data}"
    if result.length isnt 0
      items = []
      for match in result
        items.push data[match.ref]
      items.sort (a, b) ->
        a.time - b.time
      answer = items[0]
      @logger.info "MEMORY: Found answer '#{answer}' to question '#{query}'"
      answer
    else
      @logger.info "MEMORY: Could not answer question '#{query}'"
      null

  createItem: (thing) ->
    item =
      id: shortid.generate()
      body: thing
      time: +new Date()

  load: ->
    @robot.brain[@STORAGE_KEY] || {}

  save: (data) ->
    @robot.brain[@STORAGE_KEY] = data

module.exports = (robot) ->

  memory = new Memory robot

  robot.hear /^!tell (.*)/, (res) ->
    username = res.message.user.name
    channel = res.message.room.substring 1
    if robot.adapter.checkAccess(username) or username.toLowerCase() is channel.toLowerCase()
      memory.tell res.match[1]
      res.reply "Thank you for telling me."

  robot.hear /^!ask (.*)/, (res) ->
    query = res.match[1]
    answer = memory.ask query
    if answer
      res.reply "This is what I know about '#{query}': #{answer}"
    else
      res.reply "Unfortunately I don't know anything about '#{query}'."
