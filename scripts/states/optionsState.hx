import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import funkin.objects.Alphabet;
import funkin.states.MainMenuState;
import funkin.states.PlayState;
import funkin.states.options.NoteSettingsSubState;
import funkin.states.options.ControlsSubState;
import funkin.states.options.GraphicsSettingsSubState;
import funkin.states.options.VisualsUISubState;
import funkin.states.options.GameplaySettingsSubState;
import funkin.states.options.MiscSubState;
import funkin.states.options.NoteOffsetState;
import funkin.states.options.OptionsState;
import flixel.util.FlxTimer;

if (FlxG.onMobile) {
import mobile.controls.MobileDPadMode;
import mobile.controls.MobileActionMode;
}

var options:Array<String> = [
	'Notes',
	'Controls',
	'Delay',
	'Graphics',
	'Visuals',
	'Gameplay',
	"Misc"
];
var curSelected:Int = 0;
var grpOptions:FlxTypedGroup<Dynamic>;
var blockInput:Bool = false; 

function onLoad() {
    persistentUpdate = true;
    FlxG.mouse.visible = true; 
    
    brancothings = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/config/background/brancothings'));
    brancothings.screenCenter();
    brancothings.scrollFactor.set(1, 1);
    add(brancothings);
    
    backdrop = new FlxBackdrop(Paths.image('menus/config/background/backdrop'), FlxAxes.XY);
    backdrop.velocity.set(-40, -40);
    add(backdrop);
    
	background = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/config/background/background'));
    background.screenCenter();
    background.scrollFactor.set(1, 1);
    add(background);
    
    guyConfig = new FlxSprite(670, 80);
	guyConfig.frames = Paths.getSparrowAtlas('menus/config/guyconfig');
	guyConfig.animation.addByPrefix('idle', "idle", 29, true);
	guyConfig.animation.play('idle', true);
	add(guyConfig);
    
    coisas = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/config/background/coisas'));
    coisas.screenCenter();
    coisas.scrollFactor.set(1, 1);
    add(coisas);
    
    eh = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/config/background/eh'));
    eh.screenCenter();
    eh.scrollFactor.set(1, 1);
    add(eh);
    
    grpOptions = new FlxTypedGroup();
	add(grpOptions);
	
	for (i in 0...options.length)
	{
		var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
		optionText.screenCenter();
		optionText.x = 10; 
		optionText.y += (100 * (i - (options.length / 2))) + 50;		
		grpOptions.add(optionText);
	}
    
    changeSelection();
    
    if (FlxG.onMobile) addVirtualPad(MobileDPadMode.NONE, MobileActionMode.B);
}

function onUpdate(elapsed:Float) {
	if (blockInput) return;
	
	if (Controls.instance.UI_UP_P) changeSelection(-1);
	if (Controls.instance.UI_DOWN_P) changeSelection(1);
	
	if (FlxG.mouse.wheel != 0) {
		changeSelection(-FlxG.mouse.wheel); 
	}
	
	for (i in 0...grpOptions.members.length) {
		var item = grpOptions.members[i];
		
		if (FlxG.mouse.overlaps(item)) {
			if (curSelected != i) {
				curSelected = i;
				changeSelection(0);
			}
			
			if (FlxG.mouse.justPressed) {
				openSelectedSubstate(options[curSelected]);
			}
		}
	}
	
	if (Controls.instance.BACK || FlxG.mouse.justPressedRight)
	{
		FlxG.sound.play(Paths.sound('cancelMenu'));
		if (OptionsState.onPlayState)
		{
			FlxG.switchState(new PlayState());
			FlxG.sound.music.volume = 0;
		}
		else FlxG.switchState(new MainMenuState());
	}
	
	if (Controls.instance.ACCEPT)
	{
		openSelectedSubstate(options[curSelected]);
	}
}

function changeSelection(?diff:Int = 0) {
	curSelected = FlxMath.wrap(curSelected + diff, 0, options.length - 1);
	
	for (idx => item in grpOptions.members)
	{
		item.targetY = idx - curSelected;
		
		item.alpha = 0.6;
		if (item.targetY == 0) item.alpha = 1;
	}
	
	if (diff != 0) FlxG.sound.play(Paths.sound('scrollMenu'));
}

function openSelectedSubstate(label:String) {
    blockInput = true;
	switch (label)
	{
		case 'Notes':
			openSubState(new NoteSettingsSubState());
		case 'Controls':
			openSubState(new ControlsSubState());
		case 'Graphics':
			openSubState(new GraphicsSettingsSubState());
		case 'Visuals':
			openSubState(new VisualsUISubState());
		case 'Gameplay':
			openSubState(new GameplaySettingsSubState());
		case 'Misc':
			openSubState(new MiscSubState());
		case 'Delay':
			FlxG.switchState(new NoteOffsetState());
	}
}

function onCloseSubState() {
	persistentUpdate = true;
	FlxG.mouse.visible = true;
	ClientPrefs.flush();
	
	blockInput = true;
	new FlxTimer().start(0.1, function(tmr:FlxTimer) {
		blockInput = false;
		if (FlxG.onMobile) Controls.instance.isInSubstate = false;
	});
}