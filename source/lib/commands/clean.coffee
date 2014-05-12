readline = require 'readline'
fs = require 'fs'
eol = require('os').EOL

module.exports = (args,cfg)->
    savedCommands = {}

    rl = readline.createInterface
        input: fs.createReadStream cfg.database_path
        output: process.stdout
        terminal: false

    rl.on 'line', (line)->
        parsedLine = JSON.parse line
        savedCommands[parsedLine.key] = { line:line+eol, val:parsedLine.val?}

    rl.on 'close', ()->
        cmdList = (v.line for k,v of savedCommands when v.val)
        output = cmdList.join("")
        fs.writeFile cfg.database_path, output
