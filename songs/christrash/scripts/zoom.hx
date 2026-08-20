var b:FlxSprite;
function onLoad() {
  b = new FlxSprite(-720, 0).makeGraphic(600, 720, 0xFF000000);
  b.cameras = [camHUD];
  add(b);
}

function onBeatHit() {
	switch (curBeat) {
		case 32: defaultCamZoom = 0.7;
		case 64: defaultCamZoom = 0.69;
		case 128: defaultCamZoom = 0.578;
		case 160: defaultCamZoom = 0.72;
		case 192: defaultCamZoom = 0.545;
    case 250:
      FlxTween.tween(b, {x: 0}, 1.8, {ease: FlxEase.quartInOut});
		case 256: defaultCamZoom = 0.62;
      dadGroup.x = -720;
      dadGroup.y = dadGroup.y -200;
      
      dadGroup.cameras = [camOther];
      FlxTween.tween(dadGroup, {x: -85}, 0.7, {ease: FlxEase.quartInOut});
		case 260: defaultCamZoom = 0.70;
		case 264: defaultCamZoom = 0.62;
		case 268: defaultCamZoom = 0.70;
		case 272: defaultCamZoom = 0.75;
		case 276: defaultCamZoom = 0.81;
		case 280: defaultCamZoom = 0.75;
		case 284: defaultCamZoom = 0.81;
		case 288: defaultCamZoom = 0.62;
		case 292: defaultCamZoom = 0.70;
		case 296: defaultCamZoom = 0.62;
		case 300: defaultCamZoom = 0.70;
		case 304: defaultCamZoom = 0.75;
		case 308: defaultCamZoom = 0.81;
		case 312: defaultCamZoom = 0.75;
      FlxTween.tween(b, {x: -720}, 5.82, {ease: FlxEase.quartInOut});
      FlxTween.tween(dadGroup, {x: -720}, 1.6, {ease: FlxEase.quartInOut});
		case 316: defaultCamZoom = 0.9;
		case 320: defaultCamZoom = 0.62;
      dadGroup.cameras = [camGame];
  
      dadGroup.x = -120;
      dadGroup.y = 34.7;
		case 352: defaultCamZoom = 0.79;
		case 384: defaultCamZoom = 0.7;
		case 448: defaultCamZoom = 0.545;
		case 480: defaultCamZoom = 0.6;
		case 512: defaultCamZoom = 0.67;
	 }
 }