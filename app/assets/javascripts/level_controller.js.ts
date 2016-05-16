/// <reference path='./codemirror.d.ts'/>

class LevelController {
  game:            GameController;
  step:            number = 900;
  position:        number;
  level:           any;
  last_position:   number;
  t:               any;
  sqrl:            any;
  bulbs:           Array<number> = [];
  buttons:         any = {};
  ui:              any = {};
  messages:        { [character_id: number] : Array<string> } = {};
  editor:          any = document.getElementById("content");
  submission:      any = {};
  submission_ttl:  number = 60;


  constructor(game: GameController, position: number) {
    this.game     = game;
    this.position = position;
    this.last_position = game.levels[game.levels.length - 1].position - 1;
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
    this.loadLevelCharacter(this.position);

    this.buttons.play = this.game.views.hollow.select('.button.play');
    this.buttons.play.click(() => {
      this.play();
    });

    this.buttons.validate = this.game.views.hollow.select('.button.validate');
    this.buttons.validate.click(() => {
      if (this.isLocked()) {
        alert("Easy, I'm locked");
        return;
      }
      this.handleSubmissionForm();
    });

    this.buttons.inprogress = this.game.views.hollow.select('.button.inprogress');
  }

  loadLevelCharacter(level: number) {
    console.log(level)

    Snap.load(this.game.asset_paths.characters[level], (f : any) => {
      this.game.views.hollow.select('.character').append(f);
    });
  }

  handleSubmissionForm() {
    let content = this.editor.value;

    if (content === "") {
      alert("You can't submit empty answer");
    } else {
      this.lockSubmission();
      this.game.apiClient.submitCode(this.level.id, content, (data) => {
        this.submission = data.submission;
        this.resetSubmissionTTL();
        setTimeout(() => { this.checkSubmissionStatus(); }, 500);
      }, () => {
        this.unlockSubmission();
        alert("Can't submit content of submission");
      });
    }
  }

  checkSubmissionStatus() {
    this.game.apiClient.getSubmission(this.submission.id, (data) => {
      this.submission = data.submission;
      let status = this.submission.status;

      if (status === "pending") {
        if (this.checkAndDecrementSubmissionTTL()) {
          setTimeout(() => { this.checkSubmissionStatus() }, 500);
        } else {
          this.unlockSubmission();
          alert("Can't finish your submission. Please try again.")
        }
      } else if (status === "failed") {
        this.unlockSubmission();
        alert("FAILED!");
      } else if (status === "succeed") {
        this.unlockSubmission();
        this.exitLevel(() => {
          this.changeLevel(this.position, this.enterLevel.bind(this));
        });
      }
    }, () => {
      this.unlockSubmission();
      alert("Can't check status of submission")
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
      alert("Can't load level");
    });
  }

  changeLevel(level : number, callback : () => any) {
    let next_position = level + 1;
    if (next_position > this.last_position) {
      window.location.href = "/summary";
    }

    this.hideSubmissionForm();

    var _timeout  = 3000;
    var _move = this.step * next_position;
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
    this.hide(this.buttons.inprogress);

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

        let p = Snap.parse('<foreignObject width="552" height="190"><body xmlns="http://www.w3.org/1999/xhtml"><div class="scrollable-area-wrap"><div class="scrollable-area"><div class="bulb-body"><p>' + message + '</p></div></div></div></body></foreignObject>')

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

    let body = Snap.parse('<foreignObject width="552" height="190"><body xmlns="http://www.w3.org/1999/xhtml"><div class="scrollable-area-wrap"><div class="scrollable-area"><div class="bulb-body"><p class="pre-code">' + questionContent + '</p></div></div></div></body></foreignObject>');
    let bulb = this.getBulb(0);

    bulb.transform('t0,0')
    bulb.append(body)
    bulb.select('foreignObject').attr({
      transform: 'translate('+ bulb.select('text.bulb-matrix').transform().string +')'
    })
  }

  turnOnSubmissionButton(){
    this.show(this.buttons.validate);
    this.hide(this.buttons.inprogress);
  }

  turnOffSubmissionButton(){
    this.hide(this.buttons.validate);
    this.show(this.buttons.inprogress);
  }

  lockSubmission() {
    this.lockEditor();
    this.turnOffSubmissionButton();
  }

  unlockSubmission() {
    this.unlockEditor();
    this.turnOnSubmissionButton();
  }

  isLocked() {
   return this.editor.getOption("readOnly");
  }

  lockEditor() {
   this.editor.setOption("readOnly", true);
  }

  unlockEditor() {
   this.editor.setOption("readOnly", false);
  }

  checkAndDecrementSubmissionTTL() {
    return this.submission_ttl-- > 0;
  }

  resetSubmissionTTL() {
    this.submission_ttl = 60;
  }

  private showSubmissionForm() {
    $("#submission").show();
    this.showQuestionContent();
  }

  private hideSubmissionForm() {
    $("#submission").hide();
    this.clearEditor();
    this.getBulb(0).select('foreignObject').remove();
  }

  private clearEditor() {
    this.editor.value = "";
  }

};
