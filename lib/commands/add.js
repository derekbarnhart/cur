var clean, dirty;

dirty = require("dirty");

clean = require("./clean");

module.exports = function(args, cfg) {
  var commandTmpl, db, key, obj, options, token, tokenRE, tokens, val;
  if (args._.length === 0) {
    console.log("Missing args, display help here");
    return;
  }
  tokenRE = /\{{2}(.*?)\}{2}/g;
  commandTmpl = args._.slice(1).join(" ");
  options = {};
  while (!!(token = tokenRE.exec(commandTmpl))) {
    tokens = token[1].split("=");
    key = tokens[0];
    if (tokens.length > 1) {
      args._[args._.indexOf(token[0])] = "{{" + key + "}}";
      obj = {
        "default": tokens[1]
      };
    } else {
      obj = {
        demand: true
      };
    }
    options[key] = obj;
  }
  val = {
    cmd: args._.slice(1).join(" "),
    options: options
  };
  db = dirty(cfg.database_path);
  return db.on('load', function() {
    return db.set(args._[0], val, function() {
      clean(args, cfg);
      return console.log("" + args._[0] + " command added");
    });
  });
};
