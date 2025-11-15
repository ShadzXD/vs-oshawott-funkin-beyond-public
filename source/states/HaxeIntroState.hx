package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
#if sys
import Sys;
#end
class HaxeIntroState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var blackScreen:FlxSprite;
	var introGOOO:FlxSprite;
	var haxeTEXT:FlxText;
	var nose:FlxSprite;
	var boom:FlxSprite;
	var numClick:Int = 0; // Float can be a decimal number while Int should be a regular real number (1, 2 and not 1.5)

	override function create()
	{
		FlxG.mouse.visible = true;

		Init.setup();
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blackScreen);

		introGOOO = new FlxSprite(0, 0);
		introGOOO.frames = Paths.getSparrowAtlas('menus/pre-title/OshawottFlixel');
		introGOOO.screenCenter();
		introGOOO.updateHitbox();
		add(introGOOO);

		nose = new FlxSprite(0, 0);
		nose.loadGraphic(Paths.image('menus/pre-title/nose'));
		nose.screenCenter();
		nose.updateHitbox();
		add(nose);
		
		new FlxTimer().start(0.6, startNOW, 1);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(nose)) {
			if (numClick <= 2) FlxG.sound.play(Paths.sound('Boop'), 0.7);
			numClick = numClick + 1;

			if (numClick == 3) {
				FlxG.sound.play(Paths.sound('boom'), 0.7);
				boom = new FlxSprite(450, 100);
				boom.scale.set(3, 3);
				boom.frames = Paths.getSparrowAtlas('menus/pre-title/Boom');
				boom.antialiasing = false;
				boom.updateHitbox();
				boom.animation.addByPrefix('Boom', 'Boom', 20, false);
				boom.animation.play('Boom');
				add(boom);


				new FlxTimer().start(1.3, function(_) { 
					Sys.exit(1); 
				});
			}
        }
		if (controls.ACCEPT) goToWii();
		super.update(elapsed);
	}

	private function startNOW(_):Void
	{

			introGOOO.animation.addByPrefix('hiii', 'HaxeIntro', 24, false);
			introGOOO.animation.play('hiii');
			FlxG.sound.play(Paths.sound('haxe_intro'), 0.7);

			haxeTEXT = new FlxText(50, 500, FlxG.width - 100, "HaxeFlixel").setFormat(Paths.font("vcr.ttf"), 32, 0xffffff, "center");
			haxeTEXT.screenCenter(X);
			add(haxeTEXT);
			
			new FlxTimer().start(1.1, byebye, 1);
			new FlxTimer().start(4.7, function(_) {goToWii();} , 1);
	
	}

	function goToWii()
	{
		leftState  = true;
		FlxG.switchState(new WiiLOLState());
	}

	private function byebye(_):Void
		{
			var topbg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
			topbg.alpha = 0;
			add(topbg);
			FlxTween.tween(topbg, {alpha: 1}, 2.5);
		}
}
