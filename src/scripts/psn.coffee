jsdom = require "jsdom"

module.exports = (robot) ->

  logger = robot.logger

  # command !psn
  robot.hear /^!psn/, (res) ->
    options =
      url: "https://support.us.playstation.com/app/answers/detail/a_id/237/kw/psn%20status",
      scripts: ["http://code.jquery.com/jquery.js"],
      done: (error, window) ->
        $ = window.$
        if $("#rn_AnswerText").length > 0
          $element = $("#rn_AnswerText > p > span[style] > b").first();
          status = $element.text().toUpperCase() || "ONLINE"
          res.reply "The PlayStation Network is currently: #{status}."
        else
          res.reply "I'm sorry, I was unable to determine the status of PSN."
    jsdom.env options
