function onCreatePost(){
	playHUD.healthBar.visible = playHUD.healthBar.bg.visible = playHUD.timeBar.visible = playHUD.timeTxt.visible = false;
  iconP1.x = 920;
  iconP2.x = 200;
}

function onUpdatePost(elapsed:Float) {
  iconP1.x = 920;
  iconP2.x = 200;
}