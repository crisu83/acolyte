# Description
#   Constains Destiny specific logic.
#
# Dependencies:
#   -
#
# Configuration:
#   -
#
# Commands:
#   !xur - Replies with whether or not Xur is at the tower.
#
# Notes:
#   -
#
# Author:
#   crisu83

module.exports = (robot) ->

  moment = require 'moment'

  # xur
  robot.hear /!xur/i, (res) ->

    # converts seconds to a human redable "time left" string.
    formatTimeLeft = (seconds) ->
      seconds = parseInt seconds, 10
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
        days + " days, " + hours + " hours and " + minutes + " minutes"
      else if hours > 0
        hours  + " hours and " + minutes + " minutes"
      else
        minutes + " minutes"

    now = moment.utc()
    arrival = moment.utc().day('Friday').set('hour', 9)
    departure = moment.utc().day('Sunday').set('hour', 9)

    if now.isAfter arrival and now.isBefore departure
      diff = (Math.abs departure - now) / 1000
      res.send "Xur is in the tower and depatures in " + formatTimeLeft diff + "."
    else
      diff = (Math.abs arrival - now) / 1000
      res.send "Xur arrives at the tower in " + formatTimeLeft diff + "."
