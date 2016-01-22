/// <reference path='./snapsvg.d.ts'/>
var Game = (function () {
    function Game() {
        this.layers = {};
        this.views = {};
        this.s = Snap('#game-wrap');
    }
    Game.prototype.loadIntro = function () {
        var _this = this;
        Snap.load('intro.svg', function (f) {
            _this.s.append(f);
            _this.views.intro = _this.s.select('svg#intro');
            _this.intro = new Intro(_this);
            _this.intro.init();
        });
    };
    Game.prototype.loadGame = function (callback) {
        var _this = this;
        Snap.load('world.svg', function (f) {
            _this.s.append(f);
            _this.views.world = _this.s.select('svg#world');
            _this.layers.tree = _this.s.select('#layer1');
            _this.layers.layer1 = _this.s.select('#layer2');
            _this.layers.layer2 = _this.s.select('#layer3');
        });
        Snap.load('hollow.svg', function (f) {
            _this.s.append(f);
            _this.views.hollow = _this.s.select('svg#hollow');
            _this.views.hollow.attr({ visibility: 'hidden', opacity: 0 });
            _this.level = new Level(_this);
            _this.level.init();
            if (callback) {
                callback();
            }
        });
    };
    ;
    return Game;
})();
var Intro = (function () {
    function Intro(game) {
        this.game = game;
        this.clouds = this.game.s.select('g#clouds');
        this.eyes = this.game.s.select('g#eyes-closed');
        this.clouds.after(this.clouds.use().attr({
            x: document.getElementById('game-wrap').getBoundingClientRect().width
        }));
    }
    Intro.prototype.play = function () {
        var _this = this;
        this.game.s.select('svg#intro').remove();
        this.game.loadGame(function () {
            setTimeout(function () { _this.game.level.enterLevel(); }, 500);
        });
    };
    Intro.prototype.init = function () {
        var _this = this;
        this.startAmbientAnimation();
        this.game.s.select('g.button.play').click(function () { _this.play(); });
    };
    Intro.prototype.startAmbientAnimation = function () {
        this.cloudsAnimationLoop();
        this.eyesAnimLoop();
    };
    Intro.prototype.cloudsAnimationLoop = function () {
        var _this = this;
        this.clouds.transform('t0,0');
        this.clouds.animate({
            transform: 't-' + this.game.s.node.offsetWidth + ',0'
        }, 90000, function () { _this.cloudsAnimationLoop(); });
    };
    Intro.prototype.eyesAnimLoop = function () {
        var _this = this;
        clearInterval(this.t);
        this.t = setInterval(function () {
            _this.eyes.animate({
                transform: 't0,-5'
            }, 400, function () {
                setTimeout(function () {
                    _this.eyes.animate({
                        transform: 't0,0'
                    }, 300, function () {
                        _this.eyes.stop();
                    });
                }, 500);
            }, mina.elastic);
        }, 8000);
    };
    return Intro;
})();
var Level = (function () {
    function Level(game) {
        this.game = game;
        this.currentLvl = 1;
        this.step = 900;
        this.bulbs = {};
        this.buttons = {};
    }
    Level.prototype.init = function () {
        var _this = this;
        this.sqrl = game.views.hollow.select('.sqrl');
        this.bulbs[1] = game.views.hollow.select('.bulb1');
        this.bulbs[2] = game.views.hollow.select('.bulb2');
        this.buttons.play = game.views.hollow.select('.button.play');
        this.buttons.play.click(function () {
            _this.play();
        });
        this.buttons.validate = game.views.hollow.select('.button.validate');
        this.buttons.validate.click(function () {
            _this.exitLevel(function () {
                _this.changeLevel(_this.currentLvl, _this.enterLevel.bind(_this));
            });
        });
    };
    Level.prototype.changeLevel = function (level, callback) {
        var _timeout = 3000;
        var _move = this.step * level;
        game.layers.tree.animate({
            transform: 't0,' + _move
        }, _timeout, function () {
            game.layers.tree.stop();
            if (callback) {
                callback();
            }
        }, mina.easeinout);
        game.layers.layer1.animate({
            transform: 't0,' + _move / 3
        }, _timeout, function () {
            game.layers.layer1.stop();
        }, mina.easeinout);
        game.layers.layer2.animate({
            transform: 't0,' + _move / 5
        }, _timeout, function () {
            game.layers.layer2.stop();
        }, mina.easeinout);
        this.currentLvl++;
    };
    ;
    Level.prototype.enterLevel = function () {
        this.hide(game.views.world);
        this.show(game.views.hollow);
        this.sqrl.transform('t-500,0');
        this.bulbs[1].transform('t0,-1000').select('text').attr('opacity', 0);
        this.bulbs[2].transform('t0,1000').select('text').attr('opacity', 0);
        this.hide(this.buttons.play);
        this.hide(this.buttons.validate);
        this.animationEntering();
    };
    Level.prototype.exitLevel = function (callback) {
        this.show(game.views.world);
        this.hide(game.views.hollow);
        if (callback) {
            callback();
        }
    };
    Level.prototype.play = function () {
        var _this = this;
        this.bulbs[1].animate({ transform: 't0,-1000' }, 200);
        this.bulbs[2].animate({ transform: 't0,1000' }, 200);
        this.hideAndAnimate(this.buttons.play);
        setTimeout(function () { _this.showAndAnimate(_this.buttons.validate); }, 600);
    };
    Level.prototype.animationEntering = function () {
        var _this = this;
        this.sqrl.animate({
            transform: 't0,0'
        }, 300, mina.easein);
        for (var i in this.bulbs) {
            this.bulbs[i].animate({
                transform: 't0,0'
            }, 400, function () {
                this.select('text').animate({ opacity: 1 }, 400);
            }, mina.easein);
        }
        setTimeout(function () { _this.showAndAnimate(_this.buttons.play, 300); }, 600);
    };
    Level.prototype.showAndAnimate = function (element, duration) {
        if (duration === void 0) { duration = 300; }
        element.attr({ visibility: 'visible' }).animate({ opacity: 1 }, duration);
    };
    Level.prototype.hideAndAnimate = function (element, duration) {
        if (duration === void 0) { duration = 300; }
        element.attr({ visibility: 'hidden' }).animate({ opacity: 0 }, duration);
    };
    Level.prototype.hide = function (element) {
        element.attr({ visibility: 'hidden', opacity: 0 });
    };
    Level.prototype.show = function (element) {
        element.attr({ visibility: 'visible', opacity: 1 });
    };
    return Level;
})();
;
var game = new Game();
game.loadIntro();
// game.loadGame(() => {});
// setTimeout(() => { game.level.enterLevel.bind(game.level)(); }, 800);
