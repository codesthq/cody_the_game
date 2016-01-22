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
  apiClient: APIClient;

  constructor(asset_paths : any) {
    this.layers      = {}
    this.views       = {};
    this.snap        = Snap('#game-wrap');
    this.asset_paths = asset_paths;
    this.apiClient   = new APIClient("/api");
  }

  start() {
    this.loadLevels(() => {
      let level = this.getCurrentLevel();

      if (level == 0) {
        this.loadIntro(() => {
          this.initLevelController(level);
        });
      } else {
        this.initLevelController(level);
      }
    });
    // this.loadIntro();
  }

  loadLevels(callback?: () => any) {
    this.apiClient.listLevels((data) => {
      this.levels = data.levels;
      if (callback) {
        callback();
      }
    }, () => {
      console.error("Could not load levels");
    })
  }

  getCurrentLevel() {
    return this.readLevelFromHash() || 0;
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

      this.intro = new Intro(this, callback);
      this.intro.init();
    });
  }

  initLevelController(level : number) {
    Snap.load(this.asset_paths.world, (f : any) => {
      this.snap.append(f);

      this.views.world = this.snap.select('svg#world');

      this.layers.tree = this.snap.select('#layer1');
      this.layers.layer1 = this.snap.select('#layer2');
      this.layers.layer2 = this.snap.select('#layer3');
    });

    Snap.load(this.asset_paths.hollow, (f : any) => {
      this.snap.append(f);

      this.views.hollow = this.snap.select('svg#hollow');
      this.views.hollow.attr({ visibility: 'hidden', opacity: 0 });

      this.level = new LevelController(this, level);
      this.level.init();

      setTimeout(() => { this.level.enterLevel() }, 500);
    });
  };
}
