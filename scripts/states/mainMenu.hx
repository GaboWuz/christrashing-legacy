var menuItems:Array<String> = ['mainFreeplay', 'mainConfigs'];
var menuPositions:Array<Int> = [18, 847];
var menuSprites:Array<FlxSprite> = [];

var bg:FlxSprite;
var ground:FlxSprite;
var curtains:FlxSprite;
var idklool:FlxSprite;
var eyes:FlxSprite;
var thumbnail:FlxSprite;

function onLoad() {
    bg = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFFFBE991);
    bg.scrollFactor.set(0, 0);
    add(bg);

    ground = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/mainMenu/background/ground'));
    ground.screenCenter();
    ground.scrollFactor.set(1, 1);
    add(ground);
    
    curtains = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/mainMenu/background/curtains'));
    curtains.screenCenter();
    curtains.scrollFactor.set(0.9, 0.9);
    add(curtains);
    
    idklool = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/mainMenu/background/idklool'));
    idklool.screenCenter();
    idklool.scrollFactor.set(0.7, 0.7);
    add(idklool);
    
    eyes = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/mainMenu/background/olhos'));
    eyes.screenCenter();
    eyes.scrollFactor.set(0.5, 0.5);
    add(eyes);
    
    thumbnail = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/mainMenu/background/videogabos'));
    thumbnail.screenCenter();
    thumbnail.scrollFactor.set(0, 0);

    for (i in 0...menuItems.length) {
        var item = new FlxSprite(0, 0);
        item.frames = Paths.getSparrowAtlas('menus/mainMenu/' + menuItems[i]);
        item.animation.addByPrefix('normal', 'normal', 24, true);
        item.animation.addByPrefix('selected', 'select', 24, false);
        item.animation.play('normal');
        item.updateHitbox();
        
        item.screenCenter(FlxAxes.Y);
        item.x = menuPositions[i];
        item.scrollFactor.set(1, 1);
        
        if (i == 1)
            item.y += 30;
        
        add(item);
        menuSprites.push(item);
    }
    
    add(thumbnail);
}

function onUpdate(elapsed:Float) {
    FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, FlxG.mouse.x / FlxG.width * 30 - 15, 0.1);
    FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, FlxG.mouse.y / FlxG.height * 30 - 15, 0.1);

    for (i in 0...menuSprites.length) {
        var item = menuSprites[i];
        var isHovered = FlxG.mouse.overlaps(item);
        var targetAnim = isHovered ? 'selected' : 'normal';

        if (item.animation.curAnim == null || item.animation.curAnim.name != targetAnim) {
            item.animation.play(targetAnim);
            item.updateHitbox();
        }

        if (isHovered && FlxG.mouse.justPressed) {
            if (menuItems[i] == 'mainFreeplay') {
                FlxG.switchState(new funkin.states.FreeplayState());
            } else if (menuItems[i] == 'mainConfigs') {
                FlxG.switchState(new funkin.states.options.OptionsState());
            }
        }
    }
}