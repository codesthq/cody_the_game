/// <reference path='./snapsvg.d.ts'/>
/// <reference path='./level.js.ts'/>
/// <reference path='./intro.js.ts'/>

class GameController {
  s:      any;
  views:  any;
  layers: any;
  level:  Level;
  intro:  Intro;

  constructor() {
    this.layers  = {}
    this.views   = {};
    this.s       = Snap('#game-wrap');
  }

  loadIntro() {
    Snap.load('/assets/intro.svg', (f : any) => {
      this.s.append(f);

      this.views.intro = this.s.select('svg#intro');

      this.intro = new Intro(this);
      this.intro.init();
    });
  }

  loadGame(callback: () => any) {
    Snap.load('/assets/world.svg', (f : any) => {
      this.s.append(f);

      this.views.world = this.s.select('svg#world');

      this.layers.tree = this.s.select('#layer1');
      this.layers.layer1 = this.s.select('#layer2');
      this.layers.layer2 = this.s.select('#layer3');
    });

    Snap.load('/assets/hollow.svg', (f : any) => {
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
