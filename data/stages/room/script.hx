import flixel.addons.display.FlxBackdrop;
function onCreatePost(){
  var roo = new FlxBackdrop(Paths.image('backgrounds/room/listras'));
	roo.x = -520;
	roo.y = -200;
	roo.setGraphicSize(Std.int(roo.width * 2));
	roo.updateHitbox();
	roo.velocity.x = 90;
	add(roo);

  boyfriendGroup.zIndex = 22;
  dadGroup.zIndex = 22;
}