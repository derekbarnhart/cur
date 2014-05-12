var dirty;

dirty = require("dirty");

module.exports = function(path) {
  this.path = path;
  return {
    test: function() {
      return console.log(this.path);
    }
  };
};
