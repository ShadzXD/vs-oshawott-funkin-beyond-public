package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.addons.transition.FlxTransitionableState;
import flixel.text.FlxText;
import flixel.system.FlxSound;
import openfl.display.BitmapData;
import openfl.utils.Assets;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;

class WiiLOLState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var background:FlxSprite;

	override function create()
	{
		background = new FlxSprite().loadGraphic(Paths.image('menus/pre-title/Oshawott-warning'));
		background.screenCenter();
		background.updateHitbox();
		add(background);

		super.create();
	}
	final FADE_OUT_TIMER:Float = 0.2;
	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			FlxG.camera.fade(FlxColor.WHITE, FADE_OUT_TIMER);
			new FlxTimer().start(FADE_OUT_TIMER, function(tmr:FlxTimer)
			{
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				FlxG.switchState(new TitleState());
			});
		} 
		

		super.update(elapsed);
	}
}
