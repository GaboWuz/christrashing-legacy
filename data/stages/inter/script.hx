import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxEmitterMode;

var particleEmitter:FlxEmitter;
var flash:FlxSprite;

function onLoad() {
    particleEmitter = new FlxEmitter(-500, 1000, 20);
    particleEmitter.width = 2200;
    particleEmitter.launchMode = FlxEmitterMode.SQUARE;
    
    particleEmitter.velocity.set(0, -680, 0, -680, 0, 0, 0, 0);
    particleEmitter.alpha.set(0.15, 0.15, 0.45, 0.45);
    particleEmitter.lifespan.set(5, 5);
    
    particleEmitter.loadParticles(Paths.image("backgrounds/bruh"), 20, 0, false);
    
    for (particle in particleEmitter.members) {
        particle.setGraphicSize(0.01, 0.01);
        particle.updateHitbox();
        particle.scrollFactor.set(0.1, 0.1);
        particle.antialiasing = false;
    }
    particleEmitter.zIndex = 69;
    
    stage.add(particleEmitter);
    particleEmitter.start(false, 0.12);

    flash = new FlxSprite(0, 0);
    flash.makeGraphic(1280, 720, 0xFFFFFFFF);
    flash.scrollFactor.set();
    flash.scale.set(2, 2);
    flash.zIndex = 10000;
    flash.alpha = 0;
    add(flash);
}

function badApple(mode:String) {
    switch(mode) {
        case "six":
            boyfriend.color = 0xFF000000;
            dad.color = 0xFF000000;
            eehh.alpha = 0;
            uff.alpha = 0;
            uhhh.alpha = 1;
            doFlash();
        case "seven":
            boyfriend.color = 0xFFFFFFFF;
            dad.color = 0xFFFFFFFF;
            eehh.alpha = 0.3;
            uff.alpha = 1;
            uhhh.alpha = 0;
            doFlash();
    }
}

function doFlash() {
    flash.alpha = 1;
    FlxTween.tween(flash, {alpha: 0}, 1, {ease: FlxEase.linear});
}

function doStageAlpha(mode:String) {
    switch(mode) {
        case "gex":
            FlxTween.tween(uff, {alpha: 0.34}, 0.2, {ease: FlxEase.linear});
            FlxTween.tween(eehh, {alpha: 0.25}, 0.2, {ease: FlxEase.linear});
            FlxTween.tween(eh, {alpha: 0.9}, 0.2, {ease: FlxEase.linear});
        case "say":
            FlxTween.tween(uff, {alpha: 1}, 0.35, {ease: FlxEase.linear});
            FlxTween.tween(eehh, {alpha: 0.3}, 0.35, {ease: FlxEase.linear});
            FlxTween.tween(eh, {alpha: 1}, 0.35, {ease: FlxEase.linear});
            FlxTween.tween(cao, {alpha: 1}, 0.35, {ease: FlxEase.linear});
            FlxTween.tween(janel, {alpha: 1}, 0.35, {ease: FlxEase.linear});
    }
}

function fadeProps(a1:Float, a2:Float) {
    FlxTween.tween(eehh, {alpha: a1}, 0.2, {ease: FlxEase.linear});
    FlxTween.tween(eh, {alpha: a2}, 0.2, {ease: FlxEase.linear});
    FlxTween.tween(cao, {alpha: a2}, 0.2, {ease: FlxEase.linear});
    FlxTween.tween(janel, {alpha: a2}, 0.2, {ease: FlxEase.linear});
}

function onBeatHit() {
    switch (curBeat) {
        case 3: defaultCamZoom = 0.89;
        case 4: defaultCamZoom = 0.81;
        case 12: defaultCamZoom = 0.87;
        case 32: defaultCamZoom = 0.9;
        case 44: defaultCamZoom = 0.865;
        case 48: defaultCamZoom = 0.88;
        case 60: defaultCamZoom = 0.93;
        case 64: defaultCamZoom = 0.8;
        case 96: 
            badApple("six"); 
            defaultCamZoom = 0.9;
        case 128: 
            badApple("seven");
            defaultCamZoom = 0.825;
        case 144: defaultCamZoom = 0.895;
        case 160: defaultCamZoom = 0.868;
        case 168: defaultCamZoom = 0.87;
        case 176: defaultCamZoom = 0.81;
        case 184: defaultCamZoom = 0.832;
        case 191: defaultCamZoom = 0.8;
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
        case 272: defaultCamZoom = 0.83;
        case 288: defaultCamZoom = 0.81;
        case 304: defaultCamZoom = 0.85;
        case 312: defaultCamZoom = 0.86;
        case 317: defaultCamZoom = 0.87;
        case 320: 
            defaultCamZoom = 0.805;
            doFlash();
    }
}