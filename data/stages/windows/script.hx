function makeCharShader(_brightness, _hue, _contrast, _saturation)
{
	var shader = newShader('adjustColor');
	shader.setFloat('brightness', _brightness);
	shader.setFloat('hue', _hue);
	shader.setFloat('contrast', _contrast);
	shader.setFloat('saturation', _saturation);
	
	return shader;
}

function onCreatePost() {
  if (!ClientPrefs.downScroll){
    scoreTxt.y = 10;
  }else{
    scoreTxt.y = 620;
  }
  
  gagbis.shader = makeCharShader(20, 250, 40, 0);
  lumi.shader = makeCharShader(20, 250, 40, 0);
  dad.shader = makeCharShader(-10, 100, -10, 0);
  iconP2.shader = makeCharShader(-10, 100, -10, 0);

  var bounceTween = {ease: FlxEase.quadInOut, type: 4, loop: true};
    
  FlxTween.tween(pud, {y: pud.y + 18}, 0.9, bounceTween);
  FlxTween.tween(pu2d, {y: pu2d.y + 18}, 0.9, bounceTween);
  FlxTween.tween(boyfriendGroup, {y: boyfriendGroup.y + 18}, 0.9, bounceTween);
  
  if (mm != null) {
        mm.cameras = [camOther];
        mm.x = (FlxG.width - mm.width) / 2;
        mm.y = (FlxG.height - mm.height) / 2;
  }
}

function onBeatHit() {
  if (curBeat % 4 == 0 && grad != null) {
        grad.alpha = 0.3;
        FlxTween.tween(grad, {alpha: 0.25}, 0.50, {ease: FlxEase.linear});
  }
}