import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxEmitterMode;

var redCooldown:Int = 0;
var pinkCooldown:Int = 0;
var yellowCooldown:Int = 0;
var greenCooldown:Int = 0;

var particleEmitter:FlxEmitter;

import funkin.game.shaders.DropShadowShader;

var rimSprites:Array<Dynamic> = [];
var rimShaders:Array<Dynamic> = [];
var rimFrames:Array<Dynamic> = [];

function makeRimForSpr(spr, angle:Float = 0)
{
	if (spr == null || spr.frame == null)
		return null;

	var rim = new DropShadowShader();

	rim.setAdjustColor(0, 0, 0, 0);
	rim.color = 0xFFFFFFFF;
	rim.angle = angle;

	rim.antialiasAmt = 1;

	rim.attachedSprite = spr;
	spr.shader = rim;

	rimSprites.push(spr);
	rimShaders.push(rim);
	rimFrames.push(spr.frame);

	return rim;
}

function onCreatePost()
{
	var dadRim = makeRimForSpr(dad, 10);
	if (dadRim != null)
		dadRim.threshold = 0.2;

  FlxTween.tween(un, {y: un.y + 18}, 0.9, {ease: FlxEase.quadInOut, type: 4, loop: true});
  FlxTween.tween(pud, {y: pud.y + 18}, 0.9, {ease: FlxEase.quadInOut, type: 4, loop: true});
  FlxTween.tween(boyfriendGroup, {y: boyfriendGroup.y + 18}, 0.9, {ease: FlxEase.quadInOut, type: 4, loop: true});
  FlxTween.tween(gfGroup, {y: gfGroup.y + 18}, 0.9, {ease: FlxEase.quadInOut, type: 4, loop: true});
  FlxTween.tween(dadGroup, {y: dadGroup.y + 18}, 0.9, {ease: FlxEase.quadInOut, type: 4, loop: true});

  mm.cameras = [camHUD];
  mm.x = (FlxG.width - mm.width) / 2;
  mm.y = (FlxG.height - mm.height) / 2;
}

function onUpdatePost(elapsed:Float)
{
	for (i in 0...rimShaders.length)
	{
		var spr = rimSprites[i];

		// Atualiza somente quando o PNG+XML troca de frame.
		if (spr != null && spr.frame != null && rimFrames[i] != spr.frame)
		{
			rimShaders[i].updateFrameInfo(spr.frame);
			rimFrames[i] = spr.frame;
		}
	}
}

function onLoad() {
    particleEmitter = new FlxEmitter(-500, 1000, 20);
    particleEmitter.width = 2200;
    particleEmitter.launchMode = FlxEmitterMode.SQUARE;
    
    particleEmitter.velocity.set(0, -680, 0, -680, 0, 0, 0, 0);
    
    particleEmitter.alpha.set(0.15, 0.15, 0.45, 0.45);
    particleEmitter.lifespan.set(5, 5);
    
    particleEmitter.loadParticles(Paths.image("backgrounds/bola"), 20, 0, false);
    
    for (particle in particleEmitter.members) {
        particle.setGraphicSize(0.01, 0.01);
        particle.updateHitbox();
        particle.scrollFactor.set(0.1, 0.1);
        particle.antialiasing = false;
    }
    particleEmitter.zIndex = 69;
    
    stage.add(particleEmitter);
    particleEmitter.start(false, 0.12);
}

function onSongStart() {
    FlxTween.tween(black, {alpha: 0}, 5, {ease: FlxEase.circOut});
}

function onBeatHit() {
    switch (curBeat) {
        case 32: defaultCamZoom = 1;
        case 64: defaultCamZoom = 0.785;
        case 96: defaultCamZoom = 0.6;
        case 125: defaultCamZoom = 0.67;
        case 128: defaultCamZoom = 0.7;
        case 192: defaultCamZoom = 0.875;
        case 224: defaultCamZoom = 0.92;
        case 256: defaultCamZoom = 0.94;
        case 288: defaultCamZoom = 0.7;
        case 320: defaultCamZoom = 0.76;
        case 352: defaultCamZoom = 0.72;
    }

    if (curBeat % 4 == 0) {
        grandMoon.alpha = 1;
        FlxTween.tween(grandMoon, {alpha: 0}, 0.50, {ease: FlxEase.linear});
    }

    redCooldown = updateChar(red, redCooldown);
    pinkCooldown = updateChar(pink, pinkCooldown);
    yellowCooldown = updateChar(yellow, yellowCooldown);
    greenCooldown = updateChar(green, greenCooldown);
}

function updateChar(spr:Dynamic, cooldown:Int):Int {
    cooldown--;
    if (cooldown <= 0) {
        if (spr.animation.curAnim != null) {
            spr.animation.stop();
            spr.animation.curAnim.curFrame = 0;
        }
        spr.animation.play('idle', true);
        spr.alpha = 1;
        return FlxG.random.int(4, 16);
    }
    return cooldown;
}