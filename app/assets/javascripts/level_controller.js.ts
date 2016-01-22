class LevelController {
  game:        GameController;
  step:        number;
  currentLvl:  number;
  t:           any;
  sqrl:        any;
  bulbs:       any;
  buttons:     any;

  constructor(game: GameController) {
    this.game        = game;
    this.currentLvl  = 1;
    this.step        = 900;
    this.bulbs       = {};
    this.buttons     = {};
  }

  init() {
    this.sqrl = this.game.views.hollow.select('.sqrl');
    this.bulbs[1] = this.game.views.hollow.select('.bulb1');
    this.bulbs[2] = this.game.views.hollow.select('.bulb2');
    this.buttons.play = this.game.views.hollow.select('.button.play');
    this.buttons.play.click(() => {
      this.play();
    });

    this.buttons.validate = this.game.views.hollow.select('.button.validate');
    this.buttons.validate.click(() => {
      // submission
      this.exitLevel(() => {
        this.changeLevel(this.currentLvl, this.enterLevel.bind(this));
      });
    });
  }

  changeLevel(level : number, callback : () => any) {
    var _timeout  = 3000;
    var _move     = this.step * level;

    this.game.layers.tree.animate({
      transform: 't0,'+ _move
    }, _timeout, () => {
      this.game.layers.tree.stop();

      if (callback) {
        callback();
      }
    }, mina.easeinout);

    this.game.layers.layer1.animate({
      transform: 't0,'+ _move/3
    }, _timeout, () => {
      this.game.layers.layer1.stop();
    }, mina.easeinout);

    this.game.layers.layer2.animate({
      transform: 't0,'+ _move/5
    }, _timeout, () => {
      this.game.layers.layer2.stop();
    }, mina.easeinout);

    this.currentLvl++;
  };

  enterLevel() {
    this.hide(this.game.views.world);
    this.show(this.game.views.hollow);

    this.sqrl.transform('t-500,0');
    this.bulbs[1].transform('t0,-1000').select('text').attr('opacity', 0);
    this.bulbs[2].transform('t0,1000').select('text').attr('opacity', 0);
    this.hide(this.buttons.play);
    this.hide(this.buttons.validate);

    this.animationEntering();
  }

  exitLevel(callback : () => any) {
    this.show(this.game.views.world);
    this.hide(this.game.views.hollow);

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
