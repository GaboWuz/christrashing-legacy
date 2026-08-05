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