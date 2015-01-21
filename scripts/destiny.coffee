# Description
#   Destiny specific logic.
#
# Dependencies:
#   - "moment": "^2.9.0"
#   - "jsdom": "^2.0.0"
#
# Configuration:
#   -
#
# Commands:
#   !xur - Replies with whether or not Xur is at the tower.
#   !ddb <keyword> - Searches http://destinydb.com with the given keyword
#   !dwiki <keyword> - Searches http://destiny.wikia.com with the given keyword
#
# Notes:
#   -
#
# Author:
#   crisu83

module.exports = (robot) ->

  moment = require "moment"
  jsdom = require "jsdom"

  logger = robot.logger

  # xur
  robot.hear /^!xur/i, (res) ->

    # converts seconds to a human redable "time left" string.
    formatTimeLeft = (seconds) ->
      minute = 60
      hour = minute * 60
      day = hour * 24

      days = Math.floor seconds / day
      seconds -= days * day
      hours = Math.floor seconds / hour
      seconds -= hours * hour
      minutes = Math.floor seconds / minute
      seconds -= minutes * minute

      if days > 0
        "#{days} days, #{hours} hours and #{minutes} minutes"
      else if hours > 0
        "#{hours} hours and #{minutes} minutes"
      else
        "#{minutes} minutes"

    now = moment.utc()
    arrival = moment.utc().day(5).hours(9).minutes(0).seconds(0)
    departure = moment.utc().day(7).hours(9).minutes(0).seconds(0)

    if now.isAfter arrival and now.isBefore departure
      time = formatTimeLeft(Math.abs(now - departure) / 1000)
      res.reply "Xûr is in the tower and depatures in #{time}."
    else
      time = formatTimeLeft(Math.abs(now - arrival) / 1000)
      res.reply "Xûr arrives at the tower in #{time}."

  # ddb
  robot.hear /^!ddb (.*)/i, (res) ->
    endpoint = "http://destinydb.com"
    keyword = res.match[1]
    options =
      url: endpoint + "/search?q=" + encodeURIComponent(keyword),
      scripts: ["http://code.jquery.com/jquery.js"],
      done: (error, window) ->
        $ = window.$
        if $("#related-1").length > 0
          $element = $("#related-1 tr:first-child .name > div > a").first();
          label = $element.text().toUpperCase()
          url = endpoint + $element.attr "href"
          res.reply "This is what I found with '#{keyword}': #{label} #{url}"
        else
          res.reply "I'm sorry, I was unable to find anything with '#{keyword}'."
    jsdom.env options

  # dwiki
  robot.hear /^!dwiki (.*)/i, (res) ->
    endpoint = "http://destiny.wikia.com"
    keyword = res.match[1]
    options =
      url: endpoint + "/wiki/Special:Search?search=" + encodeURIComponent(keyword) + "&fulltext=Search"
      scripts: ["http://code.jquery.com/jquery.js"]
      done: (error, window) ->
        $ = window.$
        if $(".Results").length > 0
          $element = $(".Results .result:first-child > article > h1 > a")
          label = $element.text().toUpperCase()
          url = $element.attr "href"
          res.reply "This is what I found with '#{keyword}': #{label} #{url}"
        else
          res.reply "I'm sorry, I was unable to find anything with '#{keyword}'."
    jsdom.env options
