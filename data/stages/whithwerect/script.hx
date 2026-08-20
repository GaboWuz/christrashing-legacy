import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.effects.particles.FlxEmitterMode;
import funkin.game.shaders.DropShadowShader;

typedef RimData = {
    var sprite:FlxSprite;
    var shader:DropShadowShader;
    var lastFrame:Dynamic; 
}

var rimDataList:Array<RimData> = [];

var redCooldown:Int = 0;
var pinkCooldown:Int = 0;
var yellowCooldown:Int = 0;
var greenCooldown:Int = 0;

var particleEmitter:FlxEmitter;

function makeRimForSpr(spr:FlxSprite, angle:Float = 0):DropShadowShader
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

    rimDataList.push({sprite: spr, shader: rim, lastFrame: spr.frame});

    return rim;
}

function onLoad() {
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

function onCreatePost()
{
    var dadRim = makeRimForSpr(dad, 10);
    if (dadRim != null) dadRim.threshold = 0.2;
    
    var gfRim = makeRimForSpr(gf, 10); 
    if (gfRim != null) gfRim.threshold = 0.2;

    var bounceTween = {ease: FlxEase.quadInOut, type: 4, loop: true};
    
    FlxTween.tween(un, {y: un.y + 18}, 0.9, bounceTween);
    FlxTween.tween(pud, {y: pud.y + 18}, 0.9, bounceTween);
    FlxTween.tween(boyfriendGroup, {y: boyfriendGroup.y + 18}, 0.9, bounceTween);
    FlxTween.tween(gfGroup, {y: gfGroup.y + 18}, 0.9, bounceTween);
    FlxTween.tween(dadGroup, {y: dadGroup.y + 18}, 0.9, bounceTween);

    if (mm != null) {
        mm.cameras = [camHUD];
        mm.x = (FlxG.width - mm.width) / 2;
        mm.y = (FlxG.height - mm.height) / 2;
    }
}

function onUpdatePost(elapsed:Float)
{
    for (i in 0...rimDataList.length)
    {
        var data = rimDataList[i];
        var spr = data.sprite;

        if (spr != null && spr.frame != null && data.lastFrame != spr.frame)
        {
            data.shader.updateFrameInfo(spr.frame);
            data.lastFrame = spr.frame;
        }
    }
}

function onSongStart() {
    if (black != null) FlxTween.tween(black, {alpha: 0}, 5, {ease: FlxEase.circOut});
}

function onBeatHit() {
    switch (curBeat) {
        case 32: defaultCamZoom = 1;
        case 64: defaultCamZoom = 0.785;
        case 96: defaultCamZoom = 0.6;
        case 125: defaultCamZoom = 0.67;
        case 128: defaultCamZoom = 0.7;
        case 160: defaultCamZoom = 0.75;
        case 192: defaultCamZoom = 0.875;
        case 224: defaultCamZoom = 0.92;
        case 256: defaultCamZoom = 0.94;
        case 288: defaultCamZoom = 0.7;
        case 320: defaultCamZoom = 0.76;
        case 352: defaultCamZoom = 0.72;
    }

    if (curBeat % 4 == 0 && grandMoon != null) {
        grandMoon.alpha = 1;
        FlxTween.tween(grandMoon, {alpha: 0}, 0.50, {ease: FlxEase.linear});
    }

    redCooldown = updateChar(red, redCooldown);
    pinkCooldown = updateChar(pink, pinkCooldown);
    yellowCooldown = updateChar(yellow, yellowCooldown);
    greenCooldown = updateChar(green, greenCooldown);
}

function updateChar(spr:FlxSprite, cooldown:Int):Int {
    if (spr == null) return cooldown;

    var newCooldown = cooldown - 1;
    if (newCooldown <= 0) {
        if (spr.animation != null && spr.animation.curAnim != null) {
            spr.animation.stop();
            spr.animation.curAnim.curFrame = 0;
        }
        if (spr.animation != null) {
            spr.animation.play('idle', true);
        }
        spr.alpha = 1;
        return FlxG.random.int(4, 16);
    }
    return newCooldown;
}