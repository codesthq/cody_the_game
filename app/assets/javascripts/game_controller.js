$(function() {

  var GameLevel = function(name, source, callback) {
    this.name = name;
    this.source = source;
    this.callback = callback;

    var self = this;

    this.start = function() {
      self.load();
    };

    this.stop = function() {
    };

    this.load = function() {
      $("#container").load(self.source, { level: self.name }, function() {
        self.listen();

        var editor = CodeMirror.fromTextArea(document.getElementById("textarea"), {
          lineNumbers: true
        });
      });
    };

    this.validate = function() {
      self.callback();
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
        self.levels[self.currentLevel].start();
      }

      $("#game").on("click", "[data-action]", function(e){
        e.preventDefault();

        var element = $(this);
        var action = element.data("action");

        self[action]();
      });
    };

    this.setupLevels = function() {
      self.levels.push(new GameLevel("A", self.source, function(){
        self.levels[0].stop();
        self.levels[1].start();
        self.currentLevel = 1;
        document.location.hash = 1;
      }));
      self.levels.push(new GameLevel("B", self.source, function(){
        self.levels[1].stop();
        self.levels[2].start();
        self.currentLevel = 2;
        document.location.hash = 2;
      }));
      self.levels.push(new GameLevel("C", self.source, function(){
        self.levels[2].stop();
        self.levels[3].start();
        self.currentLevel = 3;
        document.location.hash = 3;
      }));
      self.levels.push(new GameLevel("D", self.source, function(){
        self.levels[3].stop();
        self.levels[4].start();
        self.currentLevel = 4;
        document.location.hash = 4;
      }));
      self.levels.push(new GameLevel("E", self.source, function(){
        self.levels[4].stop();
        alert("OMG!");
      }));
    };

    // 

    this.new = function() {
      self.levels[0].start();
    };

    this.continue = function() {
      self.levels[self.currentLevel].start();
    };
  };

  window.game_controller = (new GameController()).init("#container");
});
