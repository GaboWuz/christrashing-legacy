import funkin.game.shaders.DropShadowShader;

typedef RimData = {
    var sprite:FlxSprite;
    var shader:DropShadowShader;
    var lastFrame:Dynamic; 
}

var rimDataList:Array<RimData> = [];

var heatShader;
var shaderTime:Float = 0;

function makeRimForSpr(spr:FlxSprite, angle:Float = 0):DropShadowShader
{
    if (spr == null || spr.frame == null)
        return null;

    var rim = new DropShadowShader();

    rim.setAdjustColor(0, 0, 0, 0);
    rim.color = 0xFFFFEEB3;
    rim.angle = angle;
    rim.antialiasAmt = 1;

    rim.attachedSprite = spr;
    spr.shader = rim;

    rimDataList.push({sprite: spr, shader: rim, lastFrame: spr.frame});

    return rim;
}

function onCreatePost()
{
    var dadRim = makeRimForSpr(dad, 185);
    if (dadRim != null) dadRim.threshold = 0.2;

    var boyfriendRim = makeRimForSpr(boyfriend, 185); 
    if (boyfriendRim != null) boyfriendRim.threshold = 0.2;

    heatShader = newShader('heatwave');
    if (heatShader != null) {
        heatShader.setFloat('time', 0);
        heatShader.setFloat('strength', 0.135);
        heatShader.setFloat('speed', 1.0);
        camGame.addShader(heatShader);

        if (mm != null) {
          mm.cameras = [camOther];
          mm.x = (FlxG.width - mm.width) / 2;
          mm.y = (FlxG.height - mm.height) / 2;
        }
    }
}

function onUpdate(elapsed:Float)
{
    if (heatShader != null) {
        shaderTime += elapsed;
        heatShader.setFloat('time', shaderTime);
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