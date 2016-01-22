class LevelController {
  game:         GameController;
  step:         number = 900;
  position:     number;
  level:        any;
  t:            any;
  sqrl:         any;
  bulbs:        Array<number> = [];
  buttons:      any = {};
  messages:     { [character_id: number] : Array<string> } = {};

  constructor(game: GameController, position: number) {
    this.game        = game;
    this.position    = position;
  }

  init() {
    this.loadLevelData();

    this.sqrl = this.game.views.hollow.select('.sqrl');
    this.buttons.play = this.game.views.hollow.select('.button.play');
    this.buttons.play.click(() => {
      this.play();
    });

    this.buttons.validate = this.game.views.hollow.select('.button.validate');
    this.buttons.validate.click(() => {
      // submission
      this.exitLevel(() => {
        this.changeLevel(this.position, this.enterLevel.bind(this));
      });
    });
  }

  loadConversation() {
    this.game.apiClient.getLevel(this.level.id, (data) => {
      let level = data.level;
      let characters = level.characters;
      let conversation = level.conversation;

      for(let character of characters) {
        this.bulbs.push(character.id);
      }

      for(let message of conversation.messages) {
        if (!this.messages[message.character_id]) {
          this.messages[message.character_id] = new Array();
        }
        this.messages[message.character_id].push(message.content);
      }

      console.log(this.messages);
    }, () => {
      console.error("Can't load conversations");
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

    this.position++;
    this.loadLevelData();
  };

  loadLevelData() {
    window.location.hash = String(this.position);
    this.level = this.game.levels[this.position];
    this.loadConversation();
  }

  enterLevel() {
    this.hide(this.game.views.world);
    this.show(this.game.views.hollow);

    this.sqrl.transform('t-500,0');
    this.showBulbs();
    this.startConversation();

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
    this.hideBulbs();

    this.hideAndAnimate(this.buttons.play);
    setTimeout( () => { this.showAndAnimate(this.buttons.validate); }, 600);
  }

  animationEntering() {
    this.sqrl.animate({
      transform: 't0,0'
    }, 300, mina.easein);

    for (let i in this.bulbs) {
      let bulb:any = this.getBulb(i);
      bulb.animate({
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

  showBulbs() {
    for(let i in this.bulbs) {
      let bulb:any = this.getBulb(i);
      bulb.transform('t0,-1000').select('text').attr('opacity', 0);
    }
  }

  hideBulbs() {
    for(let i in this.bulbs) {
      let bulb:any = this.getBulb(i);
      bulb.transform('t0,-1000').animate({ transform: 't0,-1000' }, 200);
    }
  }

  getBulb(character_id: number) {
    return this.game.views.hollow.select('#bulb' + character_id);
  }

  startConversation() {
    for(let i in this.bulbs) {
      let bulb:any = this.getBulb(i);
      let character_id = this.bulbs[i];
      let message = this.getNextMessageForCharacter(character_id);
      if (message) {
        bulb.select("text").attr({text: message});
      }
    }
  }

  getNextMessageForCharacter(character_id: number) {
    return this.messages[character_id].pop();
  }
};
