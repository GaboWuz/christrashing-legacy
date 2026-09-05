var idklool:FlxSprite;

function onCreatePost() {
  idklool = new FlxSprite(720, 620).loadGraphic(Paths.image('menus/pause/' + songName));
  idklool.scale.set(0.87, 0.87);
  add(idklool);

  FlxTween.tween(idklool, {x: 630, y: 65}, 1.15, {ease: FlxEase.quartInOut});
}