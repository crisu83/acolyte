module.exports = (robot) ->

  memory = require("../utils/memory").use robot

  # command: !tell <thing>
  robot.hear /^!tell (.*)/, (res) ->
    username = res.message.user.name
    channel = res.message.room.substring 1
    if robot.adapter.checkAccess(username) or username.toLowerCase() is channel.toLowerCase()
      memory.tell res.match[1]
      res.reply "Thank you for telling me."

  # command: !ask <question>
  robot.hear /^!ask (.*)/, (res) ->
    query = res.match[1]
    answer = memory.ask query
    if answer
      res.reply answer
    else
      res.reply "I'm sorry, I don't know anything about that."
