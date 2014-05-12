dirty = require "dirty"
clean = require "./clean"

module.exports = (args,cfg)->
    #Parsing
    #Validation
    if args._.length is 0
        console.log "Missing args, display help here"
        return

    #Add new command
    db = dirty cfg.database_path
    db.on 'load', ()->
        db.rm args._[0], ()->
            clean args, cfg
            console.log "#{args._[0]} command removed"
