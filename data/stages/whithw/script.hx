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
	rim.color = 0xFFFFEEB3;
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
	var dadRim = makeRimForSpr(dad, 185);
	if (dadRim != null)
		dadRim.threshold = 0.2;
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