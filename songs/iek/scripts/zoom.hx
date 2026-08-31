var sky:FlxSprite;
var city:FlxSprite;
var a:FlxSprite;
var b:FlxSprite;
var z:FlxSprite;

var another:Character;
var bfanother:Character;
function onLoad() {
  sky = new FlxSprite(0, 290).loadGraphic(Paths.image('pixel/sky'));
  sky.cameras = [camHUD];
  sky.antialiasing = false;
  sky.x = (FlxG.width - sky.width) / 2;
  sky.updateHitbox();
  sky.scale.set(3.5, 2.5);
  add(sky);

  city = new FlxSprite(0, 340).loadGraphic(Paths.image('pixel/city'));
  city.cameras = [camHUD];
  city.antialiasing = false;
  city.x = (FlxG.width - city.width) / 2;
  city.updateHitbox();
  city.scale.set(3.5, 2.5);
  add(city);
  
  a = new FlxSprite(0, 360).loadGraphic(Paths.image('pixel/groundback'));
  a.cameras = [camHUD];
  a.antialiasing = false;
  a.x = (FlxG.width - a.width) / 2;
  a.updateHitbox();
  a.scale.set(3.5, 2);
  add(a);
  
  b = new FlxSprite(0, 360).loadGraphic(Paths.image('pixel/groundone'));
  b.cameras = [camHUD];
  b.antialiasing = false;
  b.x = (FlxG.width - b.width) / 2;
  b.updateHitbox();
  b.scale.set(3.5, 2);
  add(b);

  another = new Character(230, 165, 'dkpixel');
  another.cameras = [camHUD];
  another.updateHitbox();
  another.scale.set(3.2, 3.2);
  add(another);

  bfanother = new Character(620, 170, 'beefpixel');
  bfanother.cameras = [camHUD];
  bfanother.updateHitbox();
  bfanother.scale.set(3.2, 3.2);
  add(bfanother);
  
  z = new FlxSprite(0, 0).loadGraphic(Paths.image('pixel/chick'));
  z.cameras = [camHUD];
  z.x = (FlxG.width - z.width) / 2;
  z.y = (FlxG.height - z.height) / 2;
  add(z);
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