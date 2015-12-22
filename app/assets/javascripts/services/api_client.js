(function($) {
  var APIClient = function() {
    var API_PATH = "/api";

    var levels_path = API_PATH + '/levels';
    var level_path = function(id) { return levels_path + '/' + id; };
    var submissions_path = API_PATH + '/submissions';
    var submission_path = function(id) { return submissions_path + '/' + id; };

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
    //  error - function to be called when an error occurs
    // data format:
    //
    this.getLevel = function(id, callback, error) {
      $.get(level_path(id))
        .done(callback)
        .fail(error);
    }

    // Get data about specific level
    // PARAMS:
    //  code - code to be submitted
    //  callback - function to be called with retrieved data
    //   error - function to be called when an error occurs
    // data format:
    //
    this.submitCode = function(code, callback, error) {
      $.post(submissions_path, { submission: { content: code } })
        .done(callback)
        .fail(error);
    }

    // Get submission status
    // PARAMS:
    //  id - id of the submission
    //  callback - function to be called with retrieved data
    //  error - function to be called when an error occurs
    // data format:
    //
    this.getSubmission = function(id, callback, error) {
      $.get(submission_path(id))
        .done(callback)
        .fail(error);
    }
  }

  window.APIClient = APIClient;
})(jQuery);
