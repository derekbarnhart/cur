dirty = require "dirty"
clean = require "./clean"

module.exports = (args,cfg)->
#Parsing

#Validation
    if args._.length is 0
        console.log "Missing args, display help here"
        return

    tokenRE = /\{{2}(.*?)\}{2}/g

    commandTmpl = args._[1..].join(" ")

    options = {}
    until not token = tokenRE.exec commandTmpl
        tokens = token[1].split("=")
        key = tokens[0]
        if tokens.length > 1
            #Replace the script with the key
            args._[ args._.indexOf token[0]] = "{{#{key}}}"
            obj = { default: tokens[1]}
        else
            obj = { demand: true }
        options[key] = obj

    val =
        cmd : args._[1..].join(" ")
        options: options

#Add new command

    db = dirty cfg.database_path
    db.on 'load', ()->
        db.set args._[0], val, ()->
            clean args, cfg
            console.log "#{args._[0]} command added"
