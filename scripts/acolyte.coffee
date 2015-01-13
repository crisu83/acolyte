module.exports = (robot) ->

  # hello
  robot.enter (res) ->
    res.send "Hello " + res.message.user.name + "!"

  robot.hear /!now/i, (res) ->
    now = new Date
    res.send "The time is " + now

  # more ...
