module.exports = (robot, utils) ->

  memory = utils.memory

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
      res.reply "This is what I know about '#{query}': #{answer}"
    else
      res.reply "Unfortunately I don't know anything about '#{query}'."
