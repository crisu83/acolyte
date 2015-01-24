fs = require "fs"
path = require "path"
Config = require "../utils/config.coffee"
Keyring = require "../utils/keyring.coffee"
Memory = require "../utils/memory.coffee"
Vault = require "../utils/vault.coffee"

module.exports = (robot) ->

  utils =
    config: new Config robot
    keyring: new Keyring robot
    memory: new Memory robot
    vault: new Vault robot

  require("../routes.coffee")(robot, utils)

  dir = path.resolve "#{__dirname}/../commands"
  for file in fs.readdirSync dir
    filename = "#{dir}/#{file}"
    if fs.statSync(filename).isFile()
      require(filename)(robot, utils)
