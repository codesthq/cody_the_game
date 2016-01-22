class Intro {
  game:    GameController;
  clouds:  any;
  eyes:    any;
  t:       any;

  constructor(game: GameController) {
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
