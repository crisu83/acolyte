fs = require "fs"
path = require "path"
Config = require "../utils/config.coffee"

module.exports = (robot) ->

  config = new Config robot

  require("../routes.coffee")(robot);

  dir = path.resolve "#{__dirname}/../commands"
  for file in fs.readdirSync dir
    filename = "#{dir}/#{file}"
    if fs.statSync(filename).isFile()
      require(filename)(robot, config)
