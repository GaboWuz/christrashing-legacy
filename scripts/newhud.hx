import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;

var customHealthBar:FlxBar;
var customTimeBar:FlxBar;
var isStiqui:Bool = false;

var bgHealth:FlxSprite;
var bgTime:FlxSprite;
var iconGag:FlxSprite;

function onCreatePost() {
    isStiqui = (songName == 'stiqui');
    if (isStiqui) return;

    if (!ClientPrefs.downScroll)
        playHUD.healthBar.y -= 38.5;
    else
        playHUD.scoreTxt.y += 57.5;

    ClientPrefs.scoreZoom = false;

    bgHealth = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/heal'));
    bgHealth.cameras = [camHUD];
    bgHealth.screenCenter(FlxAxes.X);
    bgHealth.y = playHUD.healthBar.y - 60;

    var isBlueBar = (songName == 'NewTrash' || songName == 'interesting');
    var colorLeft1 = isBlueBar ? 0xFF518BFF : 0xFFD7466D;
    var colorLeft2 = isBlueBar ? 0xFF436AF8 : 0xFFC4386D;
    
    customHealthBar = new FlxBar(0, 0, FlxBarFillDirection.RIGHT_TO_LEFT, 460, 70);
    customHealthBar.cameras = [camHUD];
    customHealthBar.createGradientBar([colorLeft1, colorLeft2], [0xFFFFDE95, 0xFFFFDE95], 1, 90);
    customHealthBar.updateBar();
    customHealthBar.screenCenter(FlxAxes.X);
    customHealthBar.y = playHUD.healthBar.y - 45;

    customTimeBar = new FlxBar(7, ClientPrefs.downScroll ? 673 : 13, FlxBarFillDirection.LEFT_TO_RIGHT, 367, 40);
    customTimeBar.cameras = [camHUD];
    customTimeBar.createGradientBar([0xFFFFF1A4, 0xFFFFF6B8], [0xFFFFFFFF, 0xFFFFFFFF], 1, 90, true, 0xFF000000, 3);
    customTimeBar.updateBar();

    var iconPath = ClientPrefs.downScroll ? 'ui/stupidgagbis-downscroll' : 'ui/stupidgagbis';
    iconGag = new FlxSprite(-18.5, ClientPrefs.downScroll ? 110 : 0).loadGraphic(Paths.image(iconPath));
    iconGag.cameras = [camHUD];
    iconGag.setGraphicSize(Std.int(iconGag.height * 0.9));
    iconGag.updateHitbox();

    playHUD.healthBar.visible = playHUD.healthBar.bg.visible = playHUD.timeBar.visible = playHUD.timeTxt.visible = false;
    playHUD.scoreTxt.scale.set(0.85, 0.85);

    var healthIndex = playHUD.members.indexOf(playHUD.healthBar);
    playHUD.insert(healthIndex, customHealthBar);
    playHUD.insert(healthIndex + 1, bgHealth);
    
    var timeIndex = playHUD.members.indexOf(playHUD.timeBar);
    playHUD.insert(timeIndex, iconGag);
    playHUD.insert(timeIndex + 1, customTimeBar);

    iconP1.x = 920;
    iconP2.x = 200;
}

function opponentNoteHit() {
    if (!isStiqui && health > 0.1) {
        health -= 0.015;
    }
}

function onUpdatePost(elapsed:Float) {
    if (isStiqui) return;

    if (customHealthBar != null && playHUD.healthBar != null) {
        customHealthBar.percent = playHUD.healthBar.percent;
    }
    if (customTimeBar != null && playHUD.timeBar != null) {
        customTimeBar.percent = playHUD.timeBar.percent;
    }
    
    iconP1.x = 920;
    iconP2.x = 200;
}