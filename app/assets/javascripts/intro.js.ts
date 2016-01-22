class Intro {
  game:     GameController;
  clouds:   any;
  eyes:     any;
  t:        any;
  callback: () => any;

  constructor(game: GameController, callback: () => any) {
    this.game     = game;
    this.clouds   = this.game.snap.select('g#clouds');
    this.eyes     = this.game.snap.select('g#eyes-closed');
    this.callback = callback;

    this.clouds.after(this.clouds.use().attr({
      x: document.getElementById('game-wrap').getBoundingClientRect().width
    }));
  }

  play() {
    this.game.snap.select('svg#intro').remove();

    this.callback();
  }

  init() {
    this.startAmbientAnimation();

    this.game.snap.select('g.button.play').click(() => { this.play(); });
  }

  startAmbientAnimation() {
    this.cloudsAnimationLoop();
    this.eyesAnimLoop();
  }

  cloudsAnimationLoop() {
    this.clouds.transform('t0,0');
    this.clouds.animate({
      transform: 't-' + this.game.snap.node.offsetWidth + ',0'
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
