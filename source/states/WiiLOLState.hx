package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxTimer;
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

		ClientPrefs.loadPrefs();

		//transIn = FlxTransitionableState.defaultTransIn;
        //transOut = FlxTransitionableState.defaultTransOut;

		background = new FlxSprite().loadGraphic(Paths.image('menus/pre-title/Oshawott-warning'));
		background.screenCenter();
		background.updateHitbox();
		add(background);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT) FlxG.switchState(new TitleState());
		

		super.update(elapsed);
	}
}
