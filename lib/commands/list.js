var dirty;

dirty = require("dirty");

module.exports = function(args, cfg) {
  var db;
  db = dirty(cfg.database_path);
  return db.on('load', function() {
    return db.forEach(function(key, val) {
      return console.log(key);
    });
  });
};
