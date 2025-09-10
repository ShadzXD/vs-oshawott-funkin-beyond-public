package states.stages;
import flixel.addons.display.FlxRuntimeShader;
import objects.Note;
import states.stages.objects.*;
import openfl.display.BlendMode;

class AquaClash extends BaseStage
{
	var stage:BGSprite;
	var crow:BGSprite;
	var dropshadow:FlxRuntimeShader;
	var dropshadow2:FlxRuntimeShader;
	var dropshadow3:FlxRuntimeShader;

	var bfBG:BGSprite;
	var darnellBG:MallCrowd;
	var allowdarnellDance:Bool = true;
	var osharinaDanceSuffix = 'left';
	override function create()
	{
		if(ClientPrefs.data.shaders)
		{
			dropshadow = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("dropShadow"))); //bf bopper!
			dropshadow.setFloat("_alpha", 0.99);
			dropshadow.setFloat("_disx", -13);
			dropshadow.setFloat("_disy", 12);
			dropshadow.setBool("inner", true);
			dropshadow.setBool("inverted", true);

			dropshadow2 = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("dropShadow"))); //for the dad!
			dropshadow2.setFloat("_alpha", 0.99);
			dropshadow2.setFloat("_disx", -5);
			dropshadow2.setFloat("_disy", 12);
			dropshadow2.setBool("inner", true);
			dropshadow2.setBool("inverted", true);

			dropshadow3 = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("dropShadow"))); //for oshawott and darnell!
			dropshadow3.setFloat("_alpha", 0.999);
			dropshadow3.setFloat("_disx", -6);
			dropshadow3.setFloat("_disy", 20);
			dropshadow3.setBool("inner", true);
			dropshadow3.setBool("inverted", true);
		}

		var bg:BGSprite = new BGSprite('backgrounds/aquaclash/bg', -700, -600, 0.9, 0.9);
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.antialiasing = false;
		add(bg);

		stage = new BGSprite('backgrounds/aquaclash/stage', -600, -200);
		stage.setGraphicSize(Std.int(stage.width * 1.1));
		add(stage);

		bfBG = new BGSprite('backgrounds/aquaclash/bf-background', 1340, 270, 1, 1, ['BF idle dance']);
		bfBG.updateHitbox();
		add(bfBG);

		//lazy work around for darnell laughing
		darnellBG = new MallCrowd(-40, 200,'backgrounds/aquaclash/dewnell',  'idle', 'haha');
		darnellBG.updateHitbox();
		add(darnellBG);
	}
	
	override function createPost()
	{
		crow = new BGSprite('backgrounds/aquaclash/aquaclash_crowd', -240, 900, 1.4,1.4, ['aquaclash crowd']);
		crow.updateHitbox();
		crow.setGraphicSize(Std.int(crow.width * 1.5));
		add(crow);
	
		if(ClientPrefs.data.shaders)
		{
			bfBG.shader = dropshadow;
			boyfriend.shader = dropshadow3;
			dad.shader = dropshadow2;
			darnellBG.shader = dropshadow3;
			gf.shader = dropshadow3;
		}

		var overlay:BGSprite = new BGSprite('backgrounds/aquaclash/overlay', -600, -200);
		overlay.setGraphicSize(Std.int(overlay.width * 1.1));
		overlay.alpha = 0.75;
		//overlay.blend = BlendMode.LIGHTEN; 
		add(overlay);

	}
	override function countdownTick(count:Countdown, num:Int) everyoneDance();
	override function beatHit() everyoneDance();
	
	function everyoneDance()
	{
		darnellBG.dance(false);
		bfBG.dance(false);
		crow.dance(true);
		gf.playAnim('idle-' + osharinaDanceSuffix);
	}

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "Change Character":
			if(ClientPrefs.data.shaders)
			{
				dad.shader = dropshadow2;
				boyfriend.shader = dropshadow;
				gf.shader = dropshadow;
			}
		}
	}

	override function noteMissCommon(direction:Int, note:Note = null)
	{
		if(game.lastCombo > 5)darnellLaugh();
	}

	override function stepHit() {
		if(game.camFollow.x > 1000) osharinaDanceSuffix = 'right';
		else if(game.camFollow.x < 600)osharinaDanceSuffix = 'left';

		if(curStep == 1064) darnellLaugh();
	}

	function darnellLaugh()
	{
		darnellBG.animation.play('hey', true);
		darnellBG.heyTimer = 0.5;
	}
}