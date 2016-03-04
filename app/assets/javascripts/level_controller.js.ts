/// <reference path='./codemirror.d.ts'/>

class LevelController {
  game:         GameController;
  step:         number = 900;
  position:     number;
  level:        any;
  t:            any;
  sqrl:         any;
  bulbs:        Array<number> = [];
  buttons:      any = {};
  ui:           any = {};
  messages:     { [character_id: number] : Array<string> } = {};
  editor:       CodeMirror.EditorFromTextArea;
  submission:   any = {};

  constructor(game: GameController, position: number) {
    this.game     = game;
    this.position = position;
  }

  init() {
    this.initializeLevel();

    this.ui = Snap('svg#ui');
    this.ui.select('g#hint-trigger').click( () => {
      this.showHint();
    });

    this.ui.select('g#menu-trigger').click( () => {
      this.showMenu();
    });

    this.sqrl = this.game.views.hollow.select('.sqrl');

    this.buttons.play = this.game.views.hollow.select('.button.play');
    this.buttons.play.click(() => {
      this.play();
    });

    this.buttons.validate = this.game.views.hollow.select('.button.validate');
    this.buttons.validate.click(() => {
      this.handleSubmissionForm();
    });
  }

  handleSubmissionForm() {
    let content = this.editor.getDoc().getValue();

    this.game.apiClient.submitCode(this.level.id, content, (data) => {
      this.submission = data.submission;

      setTimeout(() => { this.checkSubmissionStatus(); }, 500);

    }, () => {
      console.error("Can't submit content of submission");
    });
  }

  checkSubmissionStatus() {
    this.game.apiClient.getSubmission(this.submission.id, (data) => {
      this.submission = data.submission;
      let status = this.submission.status;

      if (status === "pending") {
        setTimeout(() => { this.checkSubmissionStatus() }, 500);
      } else if (status === "failed") {
        alert("FAILED!");
      } else if (status === "succeed") {
        this.exitLevel(() => {
          this.changeLevel(this.position, this.enterLevel.bind(this));
        });
      }
    }, () => {
      console.error("Can't check status of submission")
    });
  }

  loadLevelData(levelId: number) {
    this.game.apiClient.getLevel(levelId, (data) => {
      this.level = data.level;
      let characters = this.level.characters;
      let conversation = this.level.conversation;
      this.bulbs = [];

      for(let character of characters) {
        this.bulbs.push(character.id);
      }

      for(let message of conversation.messages) {
        if (!this.messages[message.character_id]) {
          this.messages[message.character_id] = new Array();
        }
        this.messages[message.character_id].push(message.content);
      }
    }, () => {
      console.error("Can't load level");
    });
  }

  changeLevel(level : number, callback : () => any) {
    this.hideSubmissionForm();

    var _timeout  = 3000;
    var _move     = this.step * (level + 1);

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
    this.initializeLevel();
  };

  initializeLevel() {
    window.location.hash = String(this.position);
    let levelId = this.game.levels[this.position].id;
    this.loadLevelData(levelId);
  }

  enterLevel() {
    this.hide(this.game.views.world);
    this.show(this.game.views.hollow);

    this.showAndAnimate(this.ui, 500);

    this.sqrl.transform('t-500,0');
    this.showBulbs();
    this.startConversation();

    this.hide(this.buttons.play);
    this.hide(this.buttons.validate);

    this.animationEntering();
  }

  exitLevel(callback : () => any) {
    this.hide(this.ui);
    this.show(this.game.views.world);
    this.hide(this.game.views.hollow);

    if (callback) {
      callback();
    }
  }

  play() {
    this.hideBulbs();

    this.hideAndAnimate(this.buttons.play);
    setTimeout( () => {
      this.showSubmissionForm();
      this.showAndAnimate(this.buttons.validate);
    }, 600);
  }

  showHint() {
    this.setScore(20);
    window.alert('This is a hint! x.x');
  }

  showMenu() {
    window.location.href = '/';
  }

  setScore(score: number) {

    this.ui.select('text#score').attr({ text: score });
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
      bulb.transform('t0,-1000')//.select('text').attr('opacity', 0);
    }
  }

  hideBulbs() {
    for(let i in this.bulbs) {
      let bulb:any = this.getBulb(i);
      bulb.transform('t0,-1000').animate({ transform: 't0,-1000' }, 200);
      bulb.select('foreignObject').remove();
    }
  }

  getBulb(bulb_id: number) {
    return this.game.views.hollow.select('#bulb' + bulb_id);
  }

  startConversation() {
    for(let i in this.bulbs) {
      let bulb:any = this.getBulb(i);
      let character_id = this.bulbs[i];
      let message = this.getNextMessageForCharacter(character_id);
      if (message) {

        let p = Snap.parse('<foreignObject width="600" height="190"><body xmlns="http://www.w3.org/1999/xhtml"><div class="bulb-body"><p>' + message + '</p></div></body></foreignObject>')

        bulb.append(p)
        bulb.select('foreignObject').attr({
          transform: 'translate('+ bulb.select('text.bulb-matrix').transform().string +')'
        })

      }
    }
  }

  getNextMessageForCharacter(character_id: number) {
    return this.messages[character_id].pop();
  }


  showQuestionContent() {
    let questionContent = this.level.task.content;

    let body = Snap.parse('<foreignObject width="600" height="190"><body xmlns="http://www.w3.org/1999/xhtml"><div class="bulb-body"><div class="scrollable-area"><pre><code>' + questionContent + '</code></pre></div></div></body></foreignObject>');
    let bulb = this.getBulb(0);

    bulb.transform('t0,0')
    bulb.append(body)
    bulb.select('foreignObject').attr({
      transform: 'translate('+ bulb.select('text.bulb-matrix').transform().string +')'
    })
  }

  private showSubmissionForm() {
    $("#submission").show();
    this.addEditor();
    this.showQuestionContent();
  }

  private hideSubmissionForm() {
    $("#submission").hide();
    this.removeEditor();
    this.getBulb(0).select('foreignObject').remove();
  }

  private removeEditor() {
    this.editor.toTextArea();
    this.editor.getTextArea().value = "";

    this.editor = null;
  }

  private addEditor() {
    this.editor = CodeMirror.fromTextArea(<HTMLTextAreaElement>document.getElementById("content"), {
      lineNumbers: true
    });
  }
};
