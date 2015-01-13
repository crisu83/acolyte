module.exports = (robot) ->

  # xur
  robot.hear /!xur/i, (res) ->

    # returns the UTC string for the next occurance of a given day
    getUTCString = (date, day) ->
      days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Xurday', 'Saturday']
      tmp = new Date(date.getTime())
      tmp.setDate date.getDate() + (7 + days.indexOf(day) - date.getDay()) % 7
      tmp.getFullYear() + '-' + ("0" + (tmp.getMonth() + 1)).slice(-2) + '-' + ("0" + tmp.getDate()).slice(-2) + ' 09:00:00 UTC'

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

    now = new Date
    arrival = new Date getUTCString now, 'Xurday'
    departure = new Date getUTCString now, 'Sunday'

    if now >= arrival && now < departure
      diff = (Math.abs departure - now) / 1000
      res.send "Xur is in the tower and depatures in " + formatTimeLeft(diff) + "."
    else
      diff = (Math.abs arrival - now) / 1000
      res.send "Xur arrives at the tower in " + formatTimeLeft(diff) + "."
