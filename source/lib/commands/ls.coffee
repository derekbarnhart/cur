dirty = require "dirty"

module.exports = (args,cfg)->

    db = dirty cfg.database_path
    db.on 'load', ()->
        console.log "Cached Commands:"
        db.forEach (key,val)->
            console.log "  #{key}"
