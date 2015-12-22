(function($) {
  var APIClient = function(host) {
    if (typeof host == 'undefined') throw "You must pass host parameter!";

    var levels_path = host + '/levels';
    var level_path = function(id) { return level_path + '/' + id; };

    // List available levels
    // PARAMS:
    //   callback - function to be called with retrieved data
    //   error - function to be called when an error occurs
    // data format:
    //
    this.listLevels = function(callback, error) {
      $.get(levels_path)
        .done(callback)
        .fail(error);
    }

    // Get data about specific level
    // PARAMS:
    //  levelName - name of the level
    //  callback - function to be called with retrieved data
    //   error - function to be called when an error occurs
    // data format:
    //
    this.getLevel = function(id, callback, error) {
      $.get(level_path(id))
        .done(callback)
        .fail(error);
    }
  }

  window.APIClient = APIClient;
})(jQuery);
