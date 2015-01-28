jsdom = require "jsdom"

module.exports = (robot, utils) ->

  logger = robot.logger
  config = utils.config

  about = "I'm Acolyte, your personal Twitch assistant. Calistar created me to assist everyone in your channel. For more information please visit http://acolyte.io"

  # event: enter
  robot.enter (res) ->
    username = res.message.user.name
    channel = res.message.room.substring 1
    settings = config.get channel
    if robot.name is username
      res.send "Greetings! #{about}"
    else if settings.show_greet
      res.send "Hello #{username}!"

  # event: leave
  robot.leave (res) ->
    username = res.message.user.name
    if robot.name is username
      res.send "Good bye!"

  # command: #{robot.name}
  robot.hear new RegExp("/^#{robot.name}$/"), (res) ->
    res.reply "At your service."

  # command: !join
  robot.hear /^!join (.*)/, (res) ->
    current = res.message.room.substring 1
    channel = res.match[1]
    if robot.adapter.checkAccess(res.message.user.name) and current.toLowerCase() isnt channel.toLowerCase()
      robot.adapter.join "#" + channel
      res.reply "Joining #{channel}"

  # command: !leave
  robot.hear /^!leave (.*)/, (res) ->
    current = res.message.room.substring 1
    channel = res.match[1]
    if robot.adapter.checkAccess(res.message.user.name) and current.toLowerCase() isnt channel.toLowerCase()
      robot.adapter.part "#" + channel
      res.reply "Leaving #{channel}"

  # command: !commands
  robot.hear /^!commands/, (res) ->
    res.reply "A list of the commands that I understand can be found at http://acolyte.io/#/commands"

  # command: !about
  robot.hear /^!about/, (res) ->
    res.reply about
