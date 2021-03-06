moment = require "moment-timezone"

module.exports = (robot) ->

  logger = robot.logger

  # command: !time (<timezone>)
  robot.hear /^!time\s?(.*)?/, (res) ->
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
    if map[abbr]
      timezone = map[abbr]
      time = moment.tz(timezone).format "h:mm:ss a"
      res.reply "The time is #{time} #{abbr}."
    else
      res.reply "I'm sorry, I'm unaware of that timezone."
