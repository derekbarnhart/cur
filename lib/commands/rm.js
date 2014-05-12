var clean, dirty;

dirty = require("dirty");

clean = require("./clean");

module.exports = function(args, cfg) {
  var db;
  if (args._.length === 0) {
    console.log("Missing args, display help here");
    return;
  }
  db = dirty(cfg.database_path);
  return db.on('load', function() {
    return db.rm(args._[0], function() {
      clean(args, cfg);
      return console.log("" + args._[0] + " command removed");
    });
  });
};
