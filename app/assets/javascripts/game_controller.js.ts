/// <reference path='./snapsvg.d.ts'/>
/// <reference path='./level.js.ts'/>
/// <reference path='./intro.js.ts'/>

class GameController {
  s:           any;
  views:       any;
  layers:      any;
  level:       Level;
  intro:       Intro;
  asset_paths: any;

  constructor(asset_paths : any) {
    this.layers      = {}
    this.views       = {};
    this.s           = Snap('#game-wrap');
    this.asset_paths = asset_paths;
  }

  loadIntro() {
    Snap.load(this.asset_paths.intro, (f : any) => {
      this.s.append(f);

      this.views.intro = this.s.select('svg#intro');

      this.intro = new Intro(this);
      this.intro.init();
    });
  }

  loadGame(callback: () => any) {
    Snap.load(this.asset_paths.world, (f : any) => {
      this.s.append(f);

      this.views.world = this.s.select('svg#world');

      this.layers.tree = this.s.select('#layer1');
      this.layers.layer1 = this.s.select('#layer2');
      this.layers.layer2 = this.s.select('#layer3');
    });

    Snap.load(this.asset_paths.hollow, (f : any) => {
      this.s.append(f);

      this.views.hollow = this.s.select('svg#hollow');
      this.views.hollow.attr({ visibility: 'hidden', opacity: 0 });

      this.level = new Level(this);
      this.level.init();

      if (callback) {
        callback();
      }
    });
  };
}
