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

var customBg:FlxSprite;
var cinematicTop:FlxSprite;
var cinematicBottom:FlxSprite;
var darkFade:FlxSprite; 

var cenaone:FlxSprite;
var cenatwo:FlxSprite;
var cenathree:FlxSprite;
var cenafour:FlxSprite;

var bfcenaone:FlxSprite;
var bfcenatwo:FlxSprite;

var beef:FlxSprite;
var ideek:FlxSprite;

var thingone:FlxSprite;
var bftwothing:FlxSprite;
var thingthree:FlxSprite;

var bftwothing:FlxSprite;

function createClones(images:Array<String>, targetArray:Array<FlxSprite>) {
    for (i in 0...images.length) {
        for (j in 0...4) {
            var sprite = new FlxSprite(0, 0);
            sprite.loadGraphic(Paths.image('ui/events/' + images[i]));
            sprite.cameras = [camHUD]; 
            sprite.scale.set(0.6, 0.6);
            sprite.updateHitbox();
            
            var totalIndex = (i * 4) + j;
            sprite.x = -30 + (totalIndex * 80);
            sprite.screenCenter(FlxAxes.Y);
            
            if (images[i] == 'bftwo' || images[i] == 'bfthree' || images[i] == 'bffour') sprite.x -= 40;
            if (images[i] == 'bffour') sprite.y += 90; 
            
            sprite.visible = false;
            add(sprite);
            targetArray.push(sprite);
        }
    }
}

function createMainIcons(images:Array<String>, targetArray:Array<FlxSprite>) {
    for (i in 0...images.length) {
        var icon = new FlxSprite(0, 0);
        icon.loadGraphic(Paths.image('ui/events/' + images[i]));
        icon.cameras = [camHUD]; 
        icon.scale.set(0.8, 0.8);
        icon.updateHitbox();
        
        icon.x = -10 + (i * 330);
        icon.screenCenter(FlxAxes.Y);
        
        if (images[i] == 'bftwo' || images[i] == 'bfthree' || images[i] == 'bffour') icon.x -= 40;
        if (images[i] == 'bffour') icon.y += 90; 
        
        icon.visible = false;
        add(icon);
        targetArray.push(icon);
    }
}

function hideSprites(sprites:Array<FlxSprite>) {
    for (s in sprites) s.visible = false;
}

function onLoad() {
    darkFade = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFF000000);
    darkFade.cameras = [camHUD];
    darkFade.alpha = 0; 
    add(darkFade);

    customBg = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFFFFDE6B);
    customBg.cameras = [camHUD];
    customBg.visible = false;
    add(customBg);

    cinematicTop = new FlxSprite(0, -100).makeGraphic(1280, 270, 0xFF000000);
    cinematicTop.cameras = [camHUD];
    cinematicTop.visible = false;
    add(cinematicTop);

    cinematicBottom = new FlxSprite(0, 550).makeGraphic(1280, 190, 0xFF000000);
    cinematicBottom.cameras = [camHUD];
    cinematicBottom.visible = false;
    add(cinematicBottom);

    cenaone = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/events/cenarios/one'));
    cenaone.cameras = [camHUD]; 
    cenaone.updateHitbox();
    cenaone.alpha = 0.001;
    add(cenaone);

    cenatwo = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/events/cenarios/two'));
    cenatwo.cameras = [camHUD]; 
    cenatwo.updateHitbox();
    cenatwo.alpha = 0.001;
    add(cenatwo);

    bfcenaone = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/events/cenarios/onebf'));
    bfcenaone.cameras = [camHUD]; 
    bfcenaone.updateHitbox();
    bfcenaone.alpha = 0.001;
    add(bfcenaone);

    bfcenatwo = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/events/cenarios/twobf'));
    bfcenatwo.cameras = [camHUD]; 
    bfcenatwo.updateHitbox();
    bfcenatwo.alpha = 0.001;
    add(bfcenatwo);
    
    cenathree = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/events/cenarios/three'));
    cenathree.cameras = [camHUD]; 
    cenathree.updateHitbox();
    cenathree.alpha = 0.001;
    add(cenathree);
  
    cenafour = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/events/cenarios/four'));
    cenafour.cameras = [camHUD]; 
    cenafour.updateHitbox();
    cenafour.alpha = 0.001;
    add(cenafour);

    beef = new FlxSprite(0, 190).loadGraphic(Paths.image('ui/events/loopingbf'));
    beef.cameras = [camHUD]; 
    beef.updateHitbox();
    beef.x = (FlxG.width - beef.width) / 2;
    beef.visible = false;
    add(beef);

    ideek = new FlxSprite(0, 130).loadGraphic(Paths.image('ui/events/loopingdk'));
    ideek.cameras = [camHUD]; 
    ideek.updateHitbox();
    ideek.x = (FlxG.width - ideek.width) / 2;
    ideek.visible = false;
    add(ideek);

    thingone = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/events/cenarios/onething'));
    thingone.cameras = [camHUD]; 
    thingone.updateHitbox();
    thingone.alpha = 0.001;
    add(thingone);
 
    bftwothing = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/events/cenarios/twothingbf'));
    bftwothing.cameras = [camHUD]; 
    bftwothing.updateHitbox();
    bftwothing.alpha = 0.001;
    add(bftwothing);

    thingthree = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/events/cenarios/threething'));
    thingthree.cameras = [camHUD]; 
    thingthree.updateHitbox();
    thingthree.alpha = 0.001;
    add(thingthree);

    createClones(eventImages, eventSprites);
    createClones(BFeventImages, BFeventSprites);
    
    for (i in 0...4) {
        var lane = new FlxSprite(-20 + (i * 330), 0).makeGraphic(300, 720, 0xFFFFF1CE);
        lane.cameras = [camHUD];
        lane.visible = false;
        add(lane);
        laneSprites.push(lane);
    }

    createMainIcons(eventImages, mainIcons);
    createMainIcons(BFeventImages, BFmainIcons);
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

    var goofyThing = (curStep >= 896 && curStep < 1023 || curStep >= 1151 && curStep < 1279);

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

    var bfThing = (curStep >= 1151 && curStep < 1279);

    if (goofyThing) {
      currentlolIndex = (currentlolIndex + 1) % 4;

      if (currentlolIndex == 0) {
        if (bfThing) {
          bfcenaone.alpha = 1;
          bfcenatwo.alpha = 0.001;
          bftwothing.alpha = 0.001;
        } else {
          cenaone.alpha = 1;
          thingone.alpha = 1;
          cenatwo.alpha = 0.001;
        }
        cenathree.alpha = 0.001;
        thingthree.alpha = 0.001;
        cenafour.alpha = 0.001;
      }
  
      if (currentlolIndex == 1) {
        if (bfThing) {
          bfcenaone.alpha = 0.001;
          bfcenatwo.alpha = 1;
          bftwothing.alpha = 1;
        } else {
          cenaone.alpha = 0.001;
          thingone.alpha = 0.001;
          cenatwo.alpha = 1;
        }
        cenathree.alpha = 0.001;
        thingthree.alpha = 0.001;
        cenafour.alpha = 0.001;
      }
  
      if (currentlolIndex == 2) {
        if (bfThing) {
          bfcenaone.alpha = 0.001;
          bfcenatwo.alpha = 0.001;
          bftwothing.alpha = 0.001;
        } else {
          cenaone.alpha = 0.001;
          thingone.alpha = 0.001;
          cenatwo.alpha = 0.001;
        }
        cenathree.alpha = 1;
        thingthree.alpha = 1;
        cenafour.alpha = 0.001;
      }
  
      if (currentlolIndex == 3) {
        if (bfThing) {
          bfcenaone.alpha = 0.001;
          bfcenatwo.alpha = 0.001;
          bftwothing.alpha = 0.001;
        } else {
          cenaone.alpha = 0.001;
          thingone.alpha = 0.001;
          cenatwo.alpha = 0.001;
        };
        cenathree.alpha = 0.001;
        thingthree.alpha = 0.001;
        cenafour.alpha = 1;
      }
    }
}

function onStepHit() {
    if (curStep == 760) {
        FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.8, {ease: FlxEase.sineInOut});
        FlxTween.tween(darkFade, {alpha: 1}, 0.8, {ease: FlxEase.sineInOut});
    }

    if (curStep == 768) {
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
        cenaone.alpha = 1;
        thingone.alpha = 1;
        ideek.visible = true;
        
        currentLaneIndex = 0; 
        hideSprites(eventSprites);
        hideSprites(laneSprites);
        hideSprites(mainIcons);
    }

    if (curStep == 1023) {
        ideek.visible = false;
        bfcenaone.alpha = 0.001;
        bfcenatwo.alpha = 0.001;
        bftwothing.alpha = 0.001;
      
        cenaone.alpha = 0.001;
        thingone.alpha = 0.001;
        cenatwo.alpha = 0.001;
        
        cenathree.alpha = 0.001;
        thingthree.alpha = 0.001;
        cenafour.alpha = 0.001;
    }

    if (curStep == 1151) {
        bfcenaone.alpha = 1;
        beef.visible = true;
        
        hideSprites(laneSprites);
        hideSprites(BFmainIcons);
        hideSprites(BFeventSprites);
    }

    if (curStep == 1215) {
        // se você quiser que esse porra volte Gabo
        // oke star :eyes:
      
        modManager.setValue("stealth", 0, 1);
        modManager.setValue("dark", 0, 1);
        modManager.setValue("opponentSwap", 0, 0);
    }

    if (curStep == 1279) {
        customBg.visible = false;
        cinematicTop.visible = false;
        cinematicBottom.visible = false;
        beef.visible = false;
      
        
        bfcenaone.alpha = 0.001;
        bfcenatwo.alpha = 0.001;
        bftwothing.alpha = 0.001;
        cenathree.alpha = 0.001;
        thingthree.alpha = 0.001;
        cenafour.alpha = 0.001;
        
        hideSprites(laneSprites);
        hideSprites(BFmainIcons);
        hideSprites(BFeventSprites);
        
        camHUD.flash(0xFFFFFFFF, 1.0);
    }
}