var sky:FlxSprite;
var city:FlxSprite;
var a:FlxSprite;
var b:FlxSprite;
var z:FlxSprite;

var mouse:FlxSprite;

var another:Character;
var bfanother:Character;

var oh:FlxSprite;

var onMouse:String = 'jogavel';
function onLoad() {
  FlxG.mouse.visible = false;
  
  sky = new FlxSprite(0, 290).loadGraphic(Paths.image('pixel/sky'));
  sky.cameras = [camHUD];
  sky.antialiasing = false;
  sky.x = (FlxG.width - sky.width) / 2;
  sky.updateHitbox();
  sky.scale.set(0, 0);
  add(sky);

  city = new FlxSprite(0, 340).loadGraphic(Paths.image('pixel/city'));
  city.cameras = [camHUD];
  city.antialiasing = false;
  city.x = (FlxG.width - city.width) / 2;
  city.updateHitbox();
  city.scale.set(0, 0);
  add(city);
  
  a = new FlxSprite(0, 360).loadGraphic(Paths.image('pixel/groundback'));
  a.cameras = [camHUD];
  a.antialiasing = false;
  a.x = (FlxG.width - a.width) / 2;
  a.updateHitbox();
  a.scale.set(0, 0);
  add(a);
  
  b = new FlxSprite(0, 360).loadGraphic(Paths.image('pixel/groundone'));
  b.cameras = [camHUD];
  b.antialiasing = false;
  b.x = (FlxG.width - b.width) / 2;
  b.updateHitbox();
  b.scale.set(0, 0);
  add(b);

  another = new Character(230, 165, 'dkpixel');
  another.cameras = [camHUD];
  another.updateHitbox();
  another.scale.set(0, 0);
  add(another);

  bfanother = new Character(620, 170, 'beefpixel');
  bfanother.cameras = [camHUD];
  bfanother.updateHitbox();
  bfanother.scale.set(0, 0);
  add(bfanother);
  
  z = new FlxSprite(0, 0).loadGraphic(Paths.image('pixel/chick'));
  z.cameras = [camHUD];
  z.x = (FlxG.width - z.width) / 2;
  z.y = (FlxG.height - z.height) / 2;
  z.scale.set(0, 0);
  add(z);

  zao = new FlxSprite(0, 0).loadGraphic(Paths.image('pixel/off'));
  zao.cameras = [camHUD];
  zao.x = (FlxG.width - z.width) / 2;
  zao.y = (FlxG.height - z.height) / 2;
  zao.alpha = 0;
  zao.scale.set(0, 0);
  add(zao);

  oh = new FlxSprite(0, 0).loadGraphic(Paths.image('pixel/pc'));
  oh.cameras = [camHUD];
  oh.x = (FlxG.width - z.width) / 2 -400;
  oh.scale.set(1.2, 1.2);
  add(oh);

  mouse = new FlxSprite(0, 0);
  mouse.frames = Paths.getSparrowAtlas('pixel/mouse');
  mouse.animation.addByPrefix('anim1', 'idle', 24, false);
  mouse.animation.addByPrefix('anim2', 'click', 24, false);
  mouse.animation.addByPrefix('anim3', 'calick', 24, false);
  mouse.antialiasing = false;
  mouse.scale.set(1.25, 1.25);
  mouse.cameras = [camHUD];
  add(mouse);
}

var clickArea:FlxSprite = null;

function onUpdatePost(elapsed:Float) {
    if (mouse != null && onMouse == 'jogavel') {
      mouse.x = (FlxG.stage.mouseX / FlxG.scaleMode.scale.x) - 177;
      mouse.y = (FlxG.stage.mouseY / FlxG.scaleMode.scale.y) - 15;

      if(FlxG.mouse.justPressed) {
        mouse.animation.play('anim3');
      }
    }
}

function eventMouseOut() {
  // anim
  mouse.animation.play('anim3');

  // a gambiarra so pra nao animar
  FlxTween.tween(sky.scale, {y: 0}, 1, {ease: FlxEase.expoInOut});
  FlxTween.tween(city.scale, {y: 0}, 1, {ease: FlxEase.expoInOut});
  FlxTween.tween(a.scale, {y: 0}, 1, {ease: FlxEase.expoInOut});
  FlxTween.tween(b.scale, {y: 0}, 1, {ease: FlxEase.expoInOut});
  FlxTween.tween(z.scale, {y: 0}, 1, {ease: FlxEase.expoInOut});
  FlxTween.tween(zao.scale, {y: 0}, 1, {ease: FlxEase.expoInOut});
  FlxTween.tween(another.scale, {y: 0}, 1, {ease: FlxEase.expoInOut});
  FlxTween.tween(bfanother.scale, {y: 0}, 1, {ease: FlxEase.expoInOut});
  FlxTween.tween(zao, {alpha: 1}, 0.65, {ease: FlxEase.linear});

  FlxTween.tween(sky, {alpha: 0}, 0.9, {ease: FlxEase.expoInOut});
  FlxTween.tween(city, {alpha: 0}, 0.9, {ease: FlxEase.expoInOut});
  FlxTween.tween(a, {alpha: 0}, 0.9, {ease: FlxEase.expoInOut});
  FlxTween.tween(b, {alpha: 0}, 0.9, {ease: FlxEase.expoInOut});
  FlxTween.tween(another, {alpha: 0}, 0.9, {ease: FlxEase.expoInOut});
  FlxTween.tween(bfanother, {alpha: 0}, 0.9, {ease: FlxEase.expoInOut});

  FlxTween.tween(sky.scale, {x: 4.25}, 1, {ease: FlxEase.expoOut});
  FlxTween.tween(city.scale, {x: 4.25}, 1, {ease: FlxEase.expoOut});
  FlxTween.tween(a.scale, {x: 4.25}, 1, {ease: FlxEase.expoOut});
  FlxTween.tween(b.scale, {x: 4.25}, 1, {ease: FlxEase.expoOut});
  FlxTween.tween(z.scale, {x: 1.25}, 1, {ease: FlxEase.expoOut});
  FlxTween.tween(zao.scale, {x: 1.25}, 1, {ease: FlxEase.expoOut});
}

function eventMouseIn() {
  // anim
  mouse.animation.play('anim3');
  zao.alpha = 1;

  // a gambiarra so pra nao animar
  FlxTween.tween(z.scale, {y: 1}, 0.9, {ease: FlxEase.expoInOut});
  FlxTween.tween(zao.scale, {y: 1}, 0.9, {
    ease: FlxEase.expoInOut,
    onComplete: function(twn:FlxTween) {
        FlxTween.tween(zao, {alpha: 0}, 0.5, {ease: FlxEase.linear});
        FlxTween.tween(sky.scale, {y: 2.5}, 0.001, {ease: FlxEase.expoInOut});
        FlxTween.tween(city.scale, {y: 2.5}, 0.001, {ease: FlxEase.expoInOut});
        FlxTween.tween(a.scale, {y: 2}, 0.001, {ease: FlxEase.expoInOut});
        FlxTween.tween(b.scale, {y: 2}, 0.001, {ease: FlxEase.expoInOut});
    }
  });

  FlxTween.tween(another.scale, {y: 3.2, x: 3.2}, 1, {ease: FlxEase.expoInOut});
  FlxTween.tween(bfanother.scale, {y: 3.2, x: 3.2}, 1, {ease: FlxEase.expoInOut});

  FlxTween.tween(sky, {alpha: 1}, 0.8, {ease: FlxEase.expoInOut});
  FlxTween.tween(city, {alpha: 1}, 0.8, {ease: FlxEase.expoInOut});
  FlxTween.tween(a, {alpha: 1}, 0.8, {ease: FlxEase.expoInOut});
  FlxTween.tween(b, {alpha: 1}, 0.8, {ease: FlxEase.expoInOut});
  FlxTween.tween(another, {alpha: 1}, 0.8, {ease: FlxEase.expoInOut});
  FlxTween.tween(bfanother, {alpha: 1}, 0.8, {ease: FlxEase.expoInOut});

  FlxTween.tween(sky.scale, {x: 3.5}, 0.001, {ease: FlxEase.expoOut});
  FlxTween.tween(city.scale, {x: 3.5}, 0.001, {ease: FlxEase.expoOut});
  FlxTween.tween(a.scale, {x: 3.5}, 0.001, {ease: FlxEase.expoOut});
  FlxTween.tween(b.scale, {x: 3.5}, 0.001, {ease: FlxEase.expoOut});
  FlxTween.tween(z.scale, {x: 1}, 0.9, {ease: FlxEase.expoOut});
  FlxTween.tween(zao.scale, {x: 1}, 0.9, {ease: FlxEase.expoOut});
}

function goodNoteHit(note:Note)
{
    var animToPlay:String = note.skin.singAnimations[Std.int(Math.abs(note.noteData))] + note.animSuffix;
    if(bfanother != null)
    {
        bfanother.playAnim(animToPlay + note.animSuffix, true);
        bfanother.holdTimer = 0;
    }
}

function noteMiss(note:Note)
{
    var animToPlay:String = note.skin.singAnimations[Std.int(Math.abs(note.noteData))] + note.animSuffix + 'miss';
    if(bfanother != null)
    {
        bfanother.playAnim(animToPlay + note.animSuffix, true);
        bfanother.holdTimer = 0;
    }
}

function opponentNoteHit(note:Note)
{
    var animToPlay:String = note.skin.singAnimations[Std.int(Math.abs(note.noteData))] + note.animSuffix;
    if(another != null)
    {
        another.playAnim(animToPlay + note.animSuffix, true);
        another.holdTimer = 0;
    }
}

function onBeatHit() {
    switch (curBeat) {
      case 124: 
        onMouse = 'cutscene';
        FlxTween.tween(mouse, {x: 670, y: 680}, 1.5, {ease: FlxEase.quartInOut});
        FlxTween.tween(oh, {y: -70}, 1, {ease: FlxEase.expoOut});
      case 128: 
        eventMouseIn();
      case 129:
        FlxTween.tween(mouse, {
            x: (FlxG.stage.mouseX / FlxG.scaleMode.scale.x) - 177, 
            y: (FlxG.stage.mouseY / FlxG.scaleMode.scale.y) - 15
        }, 1.5, {
            ease: FlxEase.quartInOut,
            onComplete: function(twn:FlxTween) {
                onMouse = 'jogavel';
            }
        });
        FlxTween.tween(oh, {y: 0}, 1, {ease: FlxEase.expoOut, startDelay: 0.67});
      case 188: 
        onMouse = 'cutscene';
        FlxTween.tween(mouse, {x: 845, y: 82}, 1.5, {ease: FlxEase.quartInOut});
      case 192: 
        eventMouseOut();
      case 193:
        FlxTween.tween(mouse, {
            x: (FlxG.stage.mouseX / FlxG.scaleMode.scale.x) - 177, 
            y: (FlxG.stage.mouseY / FlxG.scaleMode.scale.y) - 15
        }, 1.5, {
            ease: FlxEase.quartInOut,
            onComplete: function(twn:FlxTween) {
                onMouse = 'jogavel';
            }
        });
      case 252:
        onMouse = 'cutscene';
        FlxTween.tween(mouse, {x: 670, y: 680}, 1.5, {ease: FlxEase.quartInOut});
        FlxTween.tween(oh, {y: -70}, 1, {ease: FlxEase.expoOut});
      case 256: 
        eventMouseIn();
      case 257:
        FlxTween.tween(mouse, {
            x: (FlxG.stage.mouseX / FlxG.scaleMode.scale.x) - 177, 
            y: (FlxG.stage.mouseY / FlxG.scaleMode.scale.y) - 15
        }, 1.5, {
            ease: FlxEase.quartInOut,
            onComplete: function(twn:FlxTween) {
                onMouse = 'jogavel';
            }
        });
        FlxTween.tween(oh, {y: 0}, 1, {ease: FlxEase.expoOut, startDelay: 0.67});
      case 316:
        onMouse = 'cutscene';
        FlxTween.tween(mouse, {x: 845, y: 82}, 1.5, {ease: FlxEase.quartInOut});
      case 320:
        eventMouseOut();
      case 321:
        FlxTween.tween(mouse, {
            x: (FlxG.stage.mouseX / FlxG.scaleMode.scale.x) - 177, 
            y: (FlxG.stage.mouseY / FlxG.scaleMode.scale.y) - 15
        }, 1.5, {
            ease: FlxEase.quartInOut,
            onComplete: function(twn:FlxTween) {
                onMouse = 'jogavel';
            }
        });
    }
}