/// <reference path='./snapsvg.d.ts'/>

class Game {
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
    Snap.load('intro.svg', (f) => {
      this.s.append(f);

      this.views.intro = this.s.select('svg#intro');

      this.intro = new Intro(this);
      this.intro.init();
    });
  }

  loadGame(callback) {
    Snap.load('world.svg', (f) => {
      this.s.append(f);

      this.views.world = this.s.select('svg#world');

      this.layers.tree = this.s.select('#layer1');
      this.layers.layer1 = this.s.select('#layer2');
      this.layers.layer2 = this.s.select('#layer3');

    });

    Snap.load('hollow.svg', (f) => {
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

class Intro {
  game:    Game;
  clouds:  any;
  eyes:    any;
  t:       any;

  constructor(game: Game) {
    this.game   = game;
    this.clouds = this.game.s.select('g#clouds');
    this.eyes   = this.game.s.select('g#eyes-closed');

    this.clouds.after(this.clouds.use().attr({
      x: document.getElementById('game-wrap').getBoundingClientRect().width
    }));
  }

  play() {
    this.game.s.select('svg#intro').remove();

    this.game.loadGame(() => {
      setTimeout( () => { this.game.level.enterLevel(); }, 500 )
    });
  }

  init() {
    this.startAmbientAnimation();

    this.game.s.select('g.button.play').click(() => { this.play(); });
  }

  startAmbientAnimation() {
    this.cloudsAnimationLoop();
    this.eyesAnimLoop();
  }

  cloudsAnimationLoop() {
    this.clouds.transform('t0,0');
    this.clouds.animate({
      transform: 't-' + this.game.s.node.offsetWidth + ',0'
    }, 90000, () => { this.cloudsAnimationLoop(); });
  }

  eyesAnimLoop() {
    clearInterval(this.t);

    this.t = setInterval(() => {
      this.eyes.animate({
        transform: 't0,-5'
      }, 400, () => {

        setTimeout(() => {
          this.eyes.animate({
            transform: 't0,0'
          }, 300, () => {
            this.eyes.stop();
          });
        }, 500);

      }, mina.elastic);
    }, 8000);

  }
}

class Level {
  game:        Game;
  step:        number;
  currentLvl:  number;
  t:           any;
  sqrl:        any;
  bulbs:       any;
  buttons:     any;

  constructor(game: Game) {
    this.game        = game;
    this.currentLvl  = 1;
    this.step        = 900;
    this.bulbs       = {};
    this.buttons     = {};
  }

  init() {
    this.sqrl = game.views.hollow.select('.sqrl');
    this.bulbs[1] = game.views.hollow.select('.bulb1');
    this.bulbs[2] = game.views.hollow.select('.bulb2');
    this.buttons.play = game.views.hollow.select('.button.play');
    this.buttons.play.click(() => {
      this.play();
    });

    this.buttons.validate = game.views.hollow.select('.button.validate');
    this.buttons.validate.click(() => {
      this.exitLevel(() => {
        this.changeLevel(this.currentLvl, this.enterLevel.bind(this));
      });
    });
  }

  changeLevel(level, callback) {
    var _timeout  = 3000;
    var _move     = this.step * level;

    game.layers.tree.animate({
      transform: 't0,'+ _move
    }, _timeout, () => {
      game.layers.tree.stop();

      if (callback) {
        callback();
      }
    }, mina.easeinout);

    game.layers.layer1.animate({
      transform: 't0,'+ _move/3
    }, _timeout, () => {
      game.layers.layer1.stop();
    }, mina.easeinout);

    game.layers.layer2.animate({
      transform: 't0,'+ _move/5
    }, _timeout, () => {
      game.layers.layer2.stop();
    }, mina.easeinout);

    this.currentLvl++;
  };

  enterLevel() {
    this.hide(game.views.world);
    this.show(game.views.hollow);

    this.sqrl.transform('t-500,0');
    this.bulbs[1].transform('t0,-1000').select('text').attr('opacity', 0);
    this.bulbs[2].transform('t0,1000').select('text').attr('opacity', 0);
    this.hide(this.buttons.play);
    this.hide(this.buttons.validate);

    this.animationEntering();
  }

  exitLevel(callback) {
    this.show(game.views.world);
    this.hide(game.views.hollow);

    if (callback) {
      callback();
    }
  }

  play() {
    this.bulbs[1].animate({ transform: 't0,-1000' }, 200);
    this.bulbs[2].animate({ transform: 't0,1000' }, 200);

    this.hideAndAnimate(this.buttons.play);
    setTimeout( () => { this.showAndAnimate(this.buttons.validate); }, 600);
  }

  animationEntering() {
    this.sqrl.animate({
      transform: 't0,0'
    }, 300, mina.easein);

    for (let i in this.bulbs) {
      this.bulbs[i].animate({
        transform: 't0,0'
      }, 400, function () {
        this.select('text').animate({ opacity: 1 }, 400);
      }, mina.easein);
    }

    setTimeout( () => { this.showAndAnimate(this.buttons.play, 300); }, 600);
  }

  showAndAnimate(element: any, duration = 300) {
    element.attr({ visibility: 'visible' }).animate({ opacity: 1 }, duration);
  }

  hideAndAnimate(element: any, duration = 300) {
    element.attr({ visibility: 'hidden' }).animate({ opacity: 0 }, duration);
  }

  hide(element: any) {
    element.attr({ visibility: 'hidden', opacity: 0 });
  }

  show(element: any) {
    element.attr({ visibility: 'visible', opacity: 1 });
  }
};

var game = new Game();
game.loadIntro();
// game.loadGame(() => {});

// setTimeout(() => { game.level.enterLevel.bind(game.level)(); }, 800);
