/// <reference path='./jquery.d.ts'/>
/// <reference path='./snapsvg.d.ts'/>
/// <reference path='./codemirror.d.ts'/>
/// <reference path='./level_controller.js.ts'/>
/// <reference path='./intro.js.ts'/>
/// <reference path='./services/api_client.js.ts'/>

class GameController {
  snap:        any;
  views:       any;
  layers:      any;
  level:       LevelController;
  intro:       Intro;
  asset_paths: any;
  levels:      Array<any>
  viewport:    any;
  apiClient: APIClient;
  maxLevel:    number;

  constructor(asset_paths : any) {
    this.layers      = {}
    this.views       = {};
    this.viewport    = {
      width:  window.innerWidth,
      height: window.innerHeight
    };
    this.snap        = Snap('#game-wrap');
    this.asset_paths = asset_paths;
    this.apiClient   = new APIClient("/api");
  }

  start() {
    this.loadLevels(() => {
      let level = this.getCurrentLevel();
      let last_level = this.levels[this.levels.length - 1].position - 1;

      if (level === last_level) {
        window.location.href = "/summary";
        return;
      }

      if (level > last_level) {
        window.location.href = "/";
        return;
      }

      if (level == 0) {
        this.loadIntro(() => {
          this.initLevelController(level);
        });
      } else {
        this.initLevelController(level);
      }
    });
  }

  loadLevels(callback?: () => any) {
    let errorFunction = () => { alert("Could not load levels"); }
    this.apiClient.listLevels((data) => {
      this.levels = data.levels;
      this.apiClient.getCurrentUserLevel((data) => {
        this.maxLevel = data.current_level_id - 1;
        if (callback) {
          callback();
        }
      }, errorFunction)
    }, errorFunction)
  }

  getCurrentLevel() {
    let levelFromHash = this.readLevelFromHash();

    if (levelFromHash) {
      return (levelFromHash > this.maxLevel) ? this.maxLevel : levelFromHash;
    } else {
      return 0;
    }
  }

  readLevelFromHash(): number {
    let hash = window.location.hash;

    if (hash !== "") {
      let levelNum = parseInt(hash.substring(hash.indexOf('#') + 1))
      return isNaN(levelNum) ? undefined : levelNum;
    }
  }

  loadIntro(callback: () => any) {
    Snap.load(this.asset_paths.intro, (f : any) => {
      this.snap.append(f);

      this.views.intro = this.snap.select('svg#intro');
      this.views.intro.attr({
        width:  this.viewport.width,
        height: this.viewport.height
      });

      this.intro = new Intro(this, callback);
      this.intro.init();
    });
  }

  initLevelController(level : number) {
    Snap.load(this.asset_paths.world, (f : any) => {
      this.snap.append(f);

      this.views.world = this.snap.select('svg#world');
      this.views.world.attr({
        width:  this.viewport.width,
        height: this.viewport.height
      });

      this.layers.tree   = this.snap.select('#layer1');
      this.layers.layer1 = this.snap.select('#layer2');
      this.layers.layer2 = this.snap.select('#layer3');
    });

    Snap.load(this.asset_paths.hollow, (f : any) => {
      this.snap.append(f);

      this.views.hollow = this.snap.select('svg#hollow');
      this.views.hollow.attr({
        width:      this.viewport.width,
        height:     this.viewport.height,
        visibility: 'hidden',
        opacity:    0
      });

      this.level = new LevelController(this, level);
      this.level.init();

      setTimeout(() => { this.level.enterLevel(); }, 500);
    });
  };
}
