import flixel.text.FlxTextBorderStyle;
var sideText:FlxText;

function onCreate()
{
    if(!ClientPrefs.data.middleScroll)
    {
        sideText = new FlxText(100, !ClientPrefs.data.downScroll ? 180 : 500, 0 , "You're on this side!", 32);
        sideText.setFormat(Paths.font('PokemonGB.ttf'), 32, FlxColor.WHITE, 'centered', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        sideText.cameras = [camHUD];
        sideText.alpha = 0;
        game.add(sideText);
    }
  
}

function onSongStart()
{
    if(!ClientPrefs.data.middleScroll)
    FlxTween.tween(sideText, {alpha: 1}, 0.5, {ease: FlxEase.linear});
}

function onStepHit()
{
    switch(curStep)
    {
        case 25:
            if(!ClientPrefs.data.middleScroll)
            FlxTween.tween(sideText, {alpha: 0}, 0.5, {ease: FlxEase.linear,
				onComplete:function(twn:FlxTween)
				{
					sideText.kill();
					sideText.destroy();
				}
			});
    }
}