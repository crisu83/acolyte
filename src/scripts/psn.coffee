jsdom = require "jsdom"

module.exports = (robot) ->

  logger = robot.logger

  # command !psn
  robot.hear /^!psn/, (res) ->
    options =
      url: "https://support.us.playstation.com",
      scripts: ["http://code.jquery.com/jquery.js"],
      done: (error, window) ->
        $ = window.$
        if $("#rn_AnswerText").length > 0
          $element = $("#rn_AnswerText > p > span[style] > b").first();
          status = $element.text().toUpperCase() || "ONLINE"
          res.reply "PSN seems to be #{status}."
        else
          res.reply "I'm sorry, I was unable to determine the status of PSN."
    jsdom.env options
