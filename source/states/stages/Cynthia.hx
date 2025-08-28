package states.stages;


class Cynthia extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming
	static var path:String = 'backgrounds/cynthiaBG/';
	override function create()
	{
		var bg:BGSprite = new BGSprite(path + 'bg', -600, -200, 1, 1);
				bg.setGraphicSize(Std.int(bg.width * 0.8));

		add(bg);

	}

}