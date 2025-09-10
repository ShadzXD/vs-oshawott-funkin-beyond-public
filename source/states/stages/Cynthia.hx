package states.stages;

import openfl.display.BlendMode;

/*
* Code for Cynthia's house.
*/
class Cynthia extends BaseStage
{
	final path = 'backgrounds/cynthiaBG/';
	override function create()
	{
		var bg:BGSprite = new BGSprite(path + 'bg', -600, -200, 1, 1);
		bg.setGraphicSize(Std.int(bg.width * 0.8));
		add(bg);

	}

	override function createPost()
	{
		var lightR:FlxSprite = new FlxSprite(1850, 0).loadGraphic(Paths.image(path + 'lightRight'));
		lightR.setGraphicSize(Std.int(lightR.width * 1.4));
		lightR.alpha = 0.8;
		lightR.blend = BlendMode.LIGHTEN; 
		lightR.updateHitbox();
		add(lightR);

		var lightL:FlxSprite = new FlxSprite(-500, 200).loadGraphic(Paths.image(path + 'lightLeft'));
		lightL.setGraphicSize(Std.int(lightR.width * 1.4));
		lightL.alpha = 1;
		lightL.blend = BlendMode.LIGHTEN; 
		lightL.updateHitbox();
		add(lightL);
	}

}