$(function() {

  var GameLevel = function(name, source, callback) {
    this.name = name;
    this.source = source;
    this.callback = callback;

    var self = this;

    this.start = function() {
      self.load();

      $(document.body).on("click", "[data-action]", function(e){
        e.preventDefault();

        var element = $(this);
        var action = element.data("action");

        self[action]();
      });
    };

    this.stop = function() {
    };

    this.load = function() {
      $("#container").load(self.source, { level: self.name } )
    };

    this.validate = function() {
      self.callback();
    };
  };

  var GameController = function() {
    this.levels = [];
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
      // loadLevelDefinitions
      // setupLevels
      // getCurrentLevel
      this.setupLevels();
      self.levels[self.currentLevel].start();
    };

    this.setupLevels = function() {
      self.levels.push(new GameLevel("A", self.source, function(){
        self.levels[0].stop();
        self.levels[1].start();
      }));
      self.levels.push(new GameLevel("B", self.source, function(){}));
    };
  };

  window.game_controller = (new GameController()).init("#container");
});
