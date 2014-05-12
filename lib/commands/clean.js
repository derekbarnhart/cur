var eol, fs, readline;

readline = require('readline');

fs = require('fs');

eol = require('os').EOL;

module.exports = function(args, cfg) {
  var rl, savedCommands;
  savedCommands = {};
  rl = readline.createInterface({
    input: fs.createReadStream(cfg.database_path),
    output: process.stdout,
    terminal: false
  });
  rl.on('line', function(line) {
    var parsedLine;
    parsedLine = JSON.parse(line);
    return savedCommands[parsedLine.key] = {
      line: line + eol,
      val: parsedLine.val != null
    };
  });
  return rl.on('close', function() {
    var cmdList, k, output, v;
    cmdList = (function() {
      var _results;
      _results = [];
      for (k in savedCommands) {
        v = savedCommands[k];
        if (v.val) {
          _results.push(v.line);
        }
      }
      return _results;
    })();
    output = cmdList.join("");
    return fs.writeFile(cfg.database_path, output);
  });
};
