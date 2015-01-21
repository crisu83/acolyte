# Description
#   Personality of Acolyte.
#
# Dependencies:
#   - "jsdom": "^2.0.0"
#
# Configuration:
#   -
#
# Commands:
#   - !join <channel> - Joins a channel
#   - !leave <channel> - Leaves a channel
#   - !config <key> (on|off|remove) - Enables, disabled or removes a configuration
#   - !psn - Tells you the current status of the PlayStation Network
#
# Notes:
#   -
#
# Author:
#   crisu83

module.exports = (robot) ->

  jsdom = require "jsdom"
  moment = require "moment-timezone"

  logger = robot.logger

  # greet
  robot.enter (res) ->
    channel = res.message.room.substring 1
    if robot.adapter.checkAccess res.message.user.name
      res.send "Greetings! I'm Acolyte, your personal Twitch robot. I was created by Calistar to assist you."
    else if robot.adapter.config.get("#{channel}.show_greet") is "on"
      res.send "Hello " + res.message.user.name + "!"

  # acolyte_bot
  robot.hear /^acolyte_bot$/, (res) ->
    res.reply "At your service."

  # join
  robot.hear /^!join (.*)/, (res) ->
    current = res.message.room.substring 1
    channel = res.match[1]
    if robot.adapter.checkAccess(res.message.user.name) and current.toLowerCase() isnt channel.toLowerCase()
      robot.adapter.join "#" + channel
      res.reply "Joining #{channel}"

  # leave
  robot.hear /^!leave (.*)/, (res) ->
    current = res.message.room.substring 1
    channel = res.match[1]
    if robot.adapter.checkAccess(res.message.user.name) and current.toLowerCase() isnt channel.toLowerCase()
      robot.adapter.part "#" + channel
      res.reply "Leaving #{channel}"

  # config
  robot.hear /^!config ([\w_]+) (on|off|remove)/i, (res) ->
    channel = res.message.room.substring 1
    [key, value] = res.match.splice 1
    if res.message.user.name.toLowerCase() is channel.toLowerCase()
      unless value is "remove"
        robot.adapter.config.set "#{channel}.#{key}", value
        res.send "#{key} is now #{value}."
      else
        robot.adapter.config.remove "#{channel}.#{key}"
        res.send "#{key} removed."

  # psn
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

  # time
  robot.hear /^!time(.*)?/, (res) ->
    map =
      UTC: "UTC"
      # Europe
      GMT: "UTC"
      WET: "UTC"
      CET: "Europe/Berlin"
      EET: "Europe/Helsinki"
      MSK: "Europe/Moscow"
      # US & Canada
      HST: "Pacific/Honolulu"
      PST: "America/Los_Angeles"
      MST: "America/Denver"
      CST: "America/Chicago"
      EST: "America/New_York"
      # Australia
      AEST: "Australia/Brisbane"
      ACST: "Australia/Darwin"
      AWST: "Australia/Perth"
    abbr = res.match[1]?.toUpperCase() || "UTC"
    timezone = map[abbr] || "UTC"
    time = moment.tz(timezone).format "h:mm:ss a"
    res.reply "The time is #{time} #{abbr}."
