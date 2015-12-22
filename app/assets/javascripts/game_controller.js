$(function() {

  var apiClient = new APIClient();

  var GameLevel = function(level, source, callback) {
    this.level = level;
    this.submission = null;
    this.source = source;
    this.callback = callback;

    var self = this;

    this.start = function() {
      $("#summary").hide();
      $("#conversation").hide();
      $("#challenge").show();

      self.editor = CodeMirror.fromTextArea(document.getElementById("submission"), {
        lineNumbers: true
      });
    };

    this.stop = function() {
    };

    this.load = function() {
      $("#container").load(self.source, { level: self.level.name }, function() {
        self.listen();
      });
    };

    this.validate = function() {
      var content = self.editor.getValue();

      apiClient.submitCode(self.level.id, content, function(data) {
        self.submission = data.submission;
        $("#summary").show();
        $("#challenge").hide();

        setTimeout(function() { self.ping() }, 500);
      }, function(e) {
        console.error("Failed to submit content!");
      });
    };

    this.next = function() {
      self.callback();
    };

    this.ping = function() {
      apiClient.getSubmission(self.submission.id, function(data){
        self.submission = data.submission;

        var status = self.submission.status;

        if (status === "pending") {
          setTimeout(function() { self.ping() }, 500);
        } else {
          $("#summary").hide();
          $("#failed").hide();
          $("#" + status).show();
        }
      }, function() {
        console.error("Failed to get submission!");
      });
    };

    //

    this.listen = function() {
      $("#level").on("click", "[data-action]", function(e){
        e.preventDefault();

        var element = $(this);
        var action = element.data("action");

        self[action]();
      });
    };
  };

  var GameController = function() {
    this.levels = [];
    this.hash = window.location.hash;
    this.currentLevel = 0;
    this.source;

    var self = this;

    this.init = function(element) {
      self.element = $(element);
      self.source = self.element.data("source");

      this.bootstrap();
      return self;
    };

    this.bootstrap = function() {
      // loading...
      // loadLevelDefinitions
      // setupLevels
      // getCurrentLevel
      this.setupLevels();

      // loading...

      if (self.hash !== "") {
        self.currentLevel = self.hash.substring(self.hash.indexOf('#') + 1);
        self.levels[self.currentLevel].load();
      }

      $("#game").on("click", "[data-action]", function(e){
        e.preventDefault();

        var element = $(this);
        var action = element.data("action");

        self[action]();
      });
    };

    this.setupLevels = function() {
      var lists = apiClient.listLevels(function(data) {
        var levelCount = data.levels.length;
        self.currentLevel = 0;

        $.each(data.levels, function(index, level) {
          var i = index;
          self.levels.push(new GameLevel(level, self.source, function() {
            self.levels[i].stop();
            if (i + 1 < levelCount) {
              self.levels[i + 1].load();
              self.currentLevel = i + 1;
              document.location.hash = i + 1;
            } else {
              alert("CONGRATZZZ");
            }
          }));
        });
      }, function() {
        console.error("Failed to download levels");
      });
    };

    //

    this.new = function() {
      self.levels[0].load();
    };

    this.continue = function() {
      self.levels[self.currentLevel].load();
    };
  };

  window.game_controller = (new GameController()).init("#container");
});
