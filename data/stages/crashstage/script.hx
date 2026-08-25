import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.effects.particles.FlxEmitterMode;

var particleEmitter:FlxEmitter;

function onLoad() {
  if (songName == 'interesting') {
    particleEmitter = new FlxEmitter(-500, 1000, 20);
    particleEmitter.width = 2200;
    particleEmitter.launchMode = FlxEmitterMode.SQUARE;
    
    particleEmitter.velocity.set(0, -680, 0, -680); 
    particleEmitter.alpha.set(0.15, 0.15, 0.45, 0.45);
    particleEmitter.lifespan.set(5, 5);
    
    particleEmitter.scale.set(0.6, 0.6, 0.6, 0.6); 

    particleEmitter.loadParticles(Paths.image("backgrounds/bola"), 20, 0, false);
    
    for (particle in particleEmitter.members) {
        particle.scrollFactor.set(0.1, 0.1);
        particle.antialiasing = false;
        particle.updateHitbox();
    }
    
    particleEmitter.zIndex = 69;
    stage.add(particleEmitter);
    
    particleEmitter.start(false, 0.12);
  }

  flash = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFFFFFFFF);
  flash.scrollFactor.set();
  flash.scale.set(2, 2);
  flash.zIndex = 10000;
  flash.alpha = 0;
  add(flash);
}

function badApple(mode:String) {
    if (mode == "six") {
        if (boyfriend != null) boyfriend.color = 0xFF000000;
        if (dad != null) dad.color = 0xFF000000;
        if (uff != null) uff.alpha = 0;
        if (gagbis != null) gagbis.alpha = 0;
        if (estrelanew != null) estrelanew.alpha = 0;
        if (uhhh != null) uhhh.alpha = 1;
        doFlash();
    } else if (mode == "seven") {
        if (boyfriend != null) boyfriend.color = 0xFFFFFFFF;
        if (dad != null) dad.color = 0xFFFFFFFF;
        if (uff != null) uff.alpha = 1;
        if (gagbis != null) gagbis.alpha = 1;
        if (estrelanew != null) estrelanew.alpha = 1;
        if (uhhh != null) uhhh.alpha = 0;
        doFlash();
    }
}

function doFlash() {
    if (flash != null) {
        FlxTween.cancelTweensOf(flash);
        flash.alpha = 1;
        FlxTween.tween(flash, {alpha: 0}, 1, {ease: FlxEase.linear});
    }
}

function doStageAlpha(mode:String) {
    var tweenSet = {ease: FlxEase.linear};
    
    if (mode == "gex") {
        if (uff != null) FlxTween.tween(uff, {alpha: 0.34}, 0.2, tweenSet);
        if (eh != null) FlxTween.tween(eh, {alpha: 0.9}, 0.2, tweenSet);
    } else if (mode == "say") {
        if (uff != null) FlxTween.tween(uff, {alpha: 1}, 0.35, tweenSet);
        if (eh != null) FlxTween.tween(eh, {alpha: 1}, 0.35, tweenSet);
        if (ground != null) FlxTween.tween(ground, {alpha: 1}, 0.35, tweenSet);
        if (tap != null) FlxTween.tween(tap, {alpha: 1}, 0.35, tweenSet);
        if (vasa != null) FlxTween.tween(vasa, {alpha: 1}, 0.35, tweenSet);
        if (sofa != null) FlxTween.tween(sofa, {alpha: 1}, 0.35, tweenSet);
        if (oh != null) FlxTween.tween(oh, {alpha: 1}, 0.35, tweenSet);
    }
}

function fadeProps(a1:Float, a2:Float) {
    var tweenSet = {ease: FlxEase.linear};
    
    if (eh != null) FlxTween.tween(eh, {alpha: a2}, 0.2, tweenSet);
    if (ground != null) FlxTween.tween(ground, {alpha: a2}, 0.2, tweenSet);
    if (tap != null) FlxTween.tween(tap, {alpha: a2}, 0.2, tweenSet);
    if (vasa != null) FlxTween.tween(vasa, {alpha: a2}, 0.2, tweenSet);
    if (sofa != null) FlxTween.tween(sofa, {alpha: a2}, 0.2, tweenSet);
    if (oh != null) FlxTween.tween(oh, {alpha: a2}, 0.2, tweenSet);
}

function onCreatePost()
{
    if (mm != null) {
        mm.cameras = [camOther];
        mm.x = (FlxG.width - mm.width) / 2;
        mm.y = (FlxG.height - mm.height) / 2;
    }
}

function onBeatHit() {
  if (songName == 'interesting') {
    switch (curBeat) {
      case 96: 
        badApple("six"); 
        defaultCamZoom = 0.9;
      case 128: 
        badApple("seven");
        defaultCamZoom = 0.825;
      case 192: 
        defaultCamZoom = 0.9;
        doStageAlpha("gex");
      case 208: 
        defaultCamZoom = 0.92;
        fadeProps(0.2, 0.9);
      case 224: 
        defaultCamZoom = 0.94;
        fadeProps(0.15, 0.8);
      case 240: 
        defaultCamZoom = 0.96;
        fadeProps(0.1, 0.7);
      case 248: 
        defaultCamZoom = 0.95;
        fadeProps(0.15, 0.8);
      case 256: 
        defaultCamZoom = 0.8;
        doStageAlpha("say");
        doFlash();
      case 320: 
        defaultCamZoom = 0.805;
        doFlash();
    }
    
    if (curBeat % 4 == 0 && eehh != null) {
          eehh.alpha = 0.3;
          FlxTween.tween(eehh, {alpha: 0.2}, 0.50, {ease: FlxEase.linear});
    }
  }
}