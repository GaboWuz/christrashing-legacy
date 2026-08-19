import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

var eventImages:Array<String> = ['idkum', 'idkdois', 'idktres', 'idkquatro'];
var BFeventImages:Array<String> = ['bfone', 'bftwo', 'bfthree', 'bffour'];

var eventSprites:Array<FlxSprite> = [];
var BFeventSprites:Array<FlxSprite> = [];
var laneSprites:Array<FlxSprite> = [];
var mainIcons:Array<FlxSprite> = [];
var BFmainIcons:Array<FlxSprite> = [];

var currentSpriteIndex:Int = 0;
var currentBFIndex:Int = 0;
var currentLaneIndex:Int = 0;
var currentlolIndex:Int = 0;

var camEvent:FlxCamera; 

var customBg:FlxSprite;
var cinematicTop:FlxSprite;
var cinematicBottom:FlxSprite;
var darkFade:FlxSprite;

var cenas:Array<FlxSprite> = [];
var bfCenas:Array<FlxSprite> = [];
var things:Array<FlxSprite> = [];
var bfThings:Array<FlxSprite> = [];

var beef:FlxSprite;
var ideek:FlxSprite;

function createSprite(path:String, x:Float, y:Float, ?isAlpha:Bool = false):FlxSprite {
    var sprite = new FlxSprite(x, y);
    if (path != "") sprite.loadGraphic(Paths.image(path));
    sprite.cameras = [camEvent]; 
    if (isAlpha) sprite.alpha = 0.001;
    sprite.updateHitbox();
    add(sprite);
    return sprite;
}

function createClones(images:Array<String>, targetArray:Array<FlxSprite>) {
    for (i in 0...images.length) {
        for (j in 0...4) {
            var sprite = createSprite('ui/events/' + images[i], 0, 0);
            sprite.scale.set(0.6, 0.6);
            sprite.updateHitbox();
            
            var totalIndex = (i * 4) + j;
            sprite.x = -30 + (totalIndex * 80);
            sprite.screenCenter(FlxAxes.Y);
            
            if (images[i] == 'bftwo' || images[i] == 'bfthree' || images[i] == 'bffour') sprite.x -= 40;
            if (images[i] == 'bffour') sprite.y += 90; 
            
            sprite.visible = false;
            targetArray.push(sprite);
        }
    }
}

function createMainIcons(images:Array<String>, targetArray:Array<FlxSprite>) {
    for (i in 0...images.length) {
        var icon = createSprite('ui/events/' + images[i], 0, 0);
        icon.scale.set(0.8, 0.8);
        icon.updateHitbox();
        
        icon.x = -10 + (i * 330);
        icon.screenCenter(FlxAxes.Y);
        
        if (images[i] == 'bftwo' || images[i] == 'bfthree' || images[i] == 'bffour') icon.x -= 40;
        if (images[i] == 'bffour') icon.y += 90; 
        
        icon.visible = false;
        targetArray.push(icon);
    }
}

function hideSprites(sprites:Array<FlxSprite>) {
    for (s in sprites) if (s != null) s.visible = false;
}

function onLoad() {
    camEvent = new FlxCamera();
    camEvent.bgColor = 0x00000000; 
    
    FlxG.cameras.add(camEvent, false);
    
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camHUD, false);
    
    if (PlayState.instance.camOther != null) {
        FlxG.cameras.remove(PlayState.instance.camOther, false);
        FlxG.cameras.add(PlayState.instance.camOther, false);
    }

    darkFade = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFF000000);
    darkFade.cameras = [camEvent];
    darkFade.alpha = 0; 
    add(darkFade);

    customBg = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFFFFDE6B);
    customBg.cameras = [camEvent];
    customBg.visible = false;
    add(customBg);

    cinematicTop = new FlxSprite(0, -100).makeGraphic(1280, 270, 0xFF000000);
    cinematicTop.cameras = [camEvent];
    cinematicTop.visible = false;
    add(cinematicTop);

    cinematicBottom = new FlxSprite(0, 550).makeGraphic(1280, 190, 0xFF000000);
    cinematicBottom.cameras = [camEvent];
    cinematicBottom.visible = false;
    add(cinematicBottom);

    cenas[0] = createSprite('ui/events/cenarios/one', 0, 0, true);
    cenas[1] = createSprite('ui/events/cenarios/two', 0, 0, true);
    cenas[2] = createSprite('ui/events/cenarios/three', 0, 0, true);
    cenas[3] = createSprite('ui/events/cenarios/four', 0, 0, true);

    bfCenas[0] = createSprite('ui/events/cenarios/onebf', 0, 0, true);
    bfCenas[1] = createSprite('ui/events/cenarios/twobf', 0, 0, true);
    bfCenas[2] = cenas[2]; 
    bfCenas[3] = cenas[3];

    things[0] = createSprite('ui/events/cenarios/onething', 0, 0, true);
    things[1] = null; 
    things[2] = createSprite('ui/events/cenarios/threething', 0, 0, true);
    things[3] = null;

    bfThings[0] = null;
    bfThings[1] = createSprite('ui/events/cenarios/twothingbf', 0, 0, true);
    bfThings[2] = things[2]; 
    bfThings[3] = null;

    beef = createSprite('ui/events/loopingbf', 0, 190);
    beef.x = (FlxG.width - beef.width) / 2;
    beef.visible = false;

    ideek = createSprite('ui/events/loopingdk', 0, 130);
    ideek.x = (FlxG.width - ideek.width) / 2;
    ideek.visible = false;

    createClones(eventImages, eventSprites);
    createClones(BFeventImages, BFeventSprites);
    
    for (i in 0...4) {
        var lane = new FlxSprite(-20 + (i * 330), 0).makeGraphic(300, 720, 0xFFFFF1CE);
        lane.cameras = [camEvent];
        lane.visible = false;
        add(lane);
        laneSprites.push(lane);
    }

    createMainIcons(eventImages, mainIcons);
    createMainIcons(BFeventImages, BFmainIcons);
}

function setSceneVisibility(index:Int, isBf:Bool) {
    for (i in 0...4) {
        if (cenas[i] != null) cenas[i].alpha = 0.001;
        if (bfCenas[i] != null) bfCenas[i].alpha = 0.001;
        if (things[i] != null) things[i].alpha = 0.001;
        if (bfThings[i] != null) bfThings[i].alpha = 0.001;
    }
    
    if (index >= 0 && index <= 3) {
        if (isBf) {
            if (bfCenas[index] != null) bfCenas[index].alpha = 1;
            if (bfThings[index] != null) bfThings[index].alpha = 1;
        } else {
            if (cenas[index] != null) cenas[index].alpha = 1;
            if (things[index] != null) things[index].alpha = 1;
        }
    }
}

function onBeatHit() {
    if (curStep >= 768 && curStep < 1151) {
        cinematicTop.y = -80; 
        FlxTween.tween(cinematicTop, {y: -100}, 0.3, {ease: FlxEase.quadOut});
        
        cinematicBottom.y = 530; 
        FlxTween.tween(cinematicBottom, {y: 550}, 0.3, {ease: FlxEase.quadOut});
    }

    if (curStep >= 767 && curStep < 896 && currentSpriteIndex < eventSprites.length) {
        var clone = eventSprites[currentSpriteIndex];
        clone.visible = true;
        clone.scale.set(0.7, 0.7);
        FlxTween.tween(clone.scale, {x: 0.6, y: 0.6}, 0.5, {ease: FlxEase.elasticOut});
        currentSpriteIndex++;
    }

    if (curStep >= 1023 && curStep < 1151 && currentBFIndex < BFeventSprites.length) {
        var cloneBF = BFeventSprites[currentBFIndex];
        cloneBF.visible = true;
        cloneBF.scale.set(0.7, 0.7);
        FlxTween.tween(cloneBF.scale, {x: 0.6, y: 0.6}, 0.5, {ease: FlxEase.elasticOut});
        currentBFIndex++;
    }

    var isIDKTurn = (curStep >= 831 && curStep < 896);
    var isBFTurn = (curStep >= 1087 && curStep < 1151);

    if (isIDKTurn || isBFTurn) {
        for (i in 0...4) {
            laneSprites[i].visible = (i == currentLaneIndex);
            
            mainIcons[i].visible = false;
            BFmainIcons[i].visible = false;

            if (i == currentLaneIndex) {
                var activeIcon = isIDKTurn ? mainIcons[i] : BFmainIcons[i];
                activeIcon.visible = true;
                activeIcon.scale.set(0.9, 0.9);
                FlxTween.tween(activeIcon.scale, {x: 0.8, y: 0.8}, 0.5, {ease: FlxEase.elasticOut});
            }
        }
        currentLaneIndex = (currentLaneIndex + 1) % 4;
    }

    var goofyThing = (curStep >= 896 && curStep < 1023 || curStep >= 1151 && curStep < 1279);
    var bfThing = (curStep >= 1151 && curStep < 1279);

    if (goofyThing) {
      currentlolIndex = (currentlolIndex + 1) % 4;
      setSceneVisibility(currentlolIndex, bfThing);
    }
}

function onStepHit() {
    if (curStep == 760) {
        FlxTween.tween(FlxG.camera, {zoom: camEvent.zoom + 0.3}, 0.8, {ease: FlxEase.sineInOut}); 
        FlxTween.tween(darkFade, {alpha: 1}, 0.8, {ease: FlxEase.sineInOut});
        
        FlxTween.num(0, 1, 0.8, {ease: FlxEase.sineInOut}, function(val:Float) {
            modManager.setValue("stealth", val, 1);
            modManager.setValue("dark", val, 1);
            modManager.setValue("opponentSwap", val * 0.5, 0);
        });
    }

    if (curStep == 768) {
        FlxTween.cancelTweensOf(FlxG.camera);
        FlxG.camera.zoom = 1.0; 
        camHUD.flash(0xFF000000, 1.0); 
        FlxTween.cancelTweensOf(darkFade);
        darkFade.alpha = 0;
        
        modManager.setValue("stealth", 1, 1);
        modManager.setValue("dark", 1, 1);
        modManager.setValue("opponentSwap", 0.5, 0);
        
        customBg.visible = true;
        cinematicTop.visible = true;
        cinematicBottom.visible = true;
    }

    if (curStep == 896) {
        setSceneVisibility(0, false);
        ideek.visible = true;
        
        currentLaneIndex = 0; 
        hideSprites(eventSprites);
        hideSprites(laneSprites);
        hideSprites(mainIcons);
    }

    if (curStep == 1016) {
        FlxTween.tween(camEvent, {zoom: camEvent.zoom + 0.25}, 0.6, {ease: FlxEase.sineIn});
    }

    if (curStep == 1023) {
        FlxTween.cancelTweensOf(camEvent);
        camEvent.zoom = 1.0; 
        camHUD.flash(0xFFFFFFFF, 0.8); 
        
        ideek.visible = false;
        setSceneVisibility(-1, false); 
    }

    if (curStep == 1151) {
        setSceneVisibility(0, true);
        beef.visible = true;
        
        hideSprites(laneSprites);
        hideSprites(BFmainIcons);
        hideSprites(BFeventSprites);
    }

    if (curStep == 1280) {
        camHUD.flash(0xFFFFFFFF, 1.0);
        customBg.visible = false;
        cinematicTop.visible = false;
        cinematicBottom.visible = false;
        beef.visible = false;
        
        modManager.setValue("stealth", 0, 1);
        modManager.setValue("dark", 0, 1);
        modManager.setValue("opponentSwap", 0, 0);
        
        setSceneVisibility(-1, false);
        
        hideSprites(laneSprites);
        hideSprites(BFmainIcons);
        hideSprites(BFeventSprites);
    }
}