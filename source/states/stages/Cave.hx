package states.stages;
import flixel.addons.display.FlxRuntimeShader;
import openfl.filters.ShaderFilter;

class Cave extends BaseStage
{
	var carbinksleft:BGSprite;
	var carbinks12:BGSprite;
	var nosePass1:BGSprite;
	var frenBinks:BGSprite;
	var aBop:BGSprite;
	var lBop:BGSprite;
	var iBop:BGSprite;
	var gBop:BGSprite;
	var mBop:BGSprite;
	var jirachi:BGSprite;
	//var bloom:FlxRuntimeShader;
	var dropshadow:FlxRuntimeShader;
	var path:String = 'backgrounds/cave/';
	override function create()
	{
		//bloom = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("bloom"))); //boss told me no bloom support!
		dropshadow = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("dropShadow")));
        dropshadow.setFloat("_alpha", 0.5);
		dropshadow.setFloat("_disx", 0);
		dropshadow.setFloat("_disy", 15);
		dropshadow.setBool("inner", true);
		dropshadow.setBool("inverted", true);
		
		var backerBG:BGSprite = new BGSprite(path + 'EvenFurtherBackground', -800, -800, 0.4, 0.4);
		add(backerBG);

		var backBG:BGSprite = new BGSprite(path + 'FurtherBackground', -800, -600, 0.6, 0.6);
		add(backerBG);

		jirachi = new BGSprite(path + 'Jirachi', 410, -350, 0.55, 0.55, ['Jirachi']);
		jirachi.updateHitbox();
		add(jirachi);
		
		var crystal:BGSprite = new BGSprite(path + 'CenterCrystal', 100, -900, 0.6, 0.6);
		add(crystal);


		var backround:BGSprite = new BGSprite(path + 'Background', -1300, -500, 0.6, 0.6);
		add(backround);

		var platformPre:BGSprite = new BGSprite(path + 'Foreground', -1300, 200, 0.95, 0.95);
		add(platformPre);

		frenBinks = new BGSprite(path + 'frenbinks', -850, 400, 0.95, 0.95, ['frenbinks']);
		frenBinks.updateHitbox();
		add(frenBinks);

		var spikes:BGSprite = new BGSprite(path + 'TopSpikes', -1200, -900, 0.95, 0.95);
		add(spikes);

		carbinksleft = new BGSprite(path + 'carbinks1', -100, 230, 0.95, 0.95, ['carbinks1']);
		carbinksleft.updateHitbox();
		add(carbinksleft);

		lBop = new BGSprite(path + 'L', 200, 200, 0.95, 0.95, ['L']);
		lBop.updateHitbox();
		add(lBop);

		iBop = new BGSprite(path + 'I', 320, 290, 0.95, 0.95, ['I']);
		iBop.updateHitbox();
		add(iBop);

		gBop = new BGSprite(path + 'G', 1200, 300, 0.95, 0.95, ['G']);
		gBop.updateHitbox();
		add(gBop);

		mBop = new BGSprite(path + 'M', gBop.x + 150, 400, 0.95, 0.95, ['M']);
		mBop.updateHitbox();
		add(mBop);

		aBop = new BGSprite(path + 'A', 2300, 0, 0.95, 0.95, ['A']);
		aBop.updateHitbox();
		add(aBop);

		carbinks12 = new BGSprite(path + 'carbinks2', 2000, 0, 0.95, 0.95, ['carbinks2']);
		carbinks12.updateHitbox();
		add(carbinks12);

		nosePass1 = new BGSprite(path + 'Nosepass', 2250, 500, 1,1, ['Nosepass']);
		nosePass1.updateHitbox();
		add(nosePass1);

		var platform:BGSprite = new BGSprite(path + 'Platform', -100, 550, 1 ,1);
		add(platform);
	}
	
	override function createPost()
	{
		//FlxG.camera.setFilters([new ShaderFilter(bloom)]);


		dad.shader = dropshadow;
		boyfriend.shader = dropshadow;

		var overlay:BGSprite = new BGSprite(path + 'overlay', -1200, -800, 1 ,1);
		add(overlay);
		
	}

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "Change Character":
			dad.shader = dropshadow;
			boyfriend.shader = dropshadow;
			gf.shader = dropshadow;
		}
	}
	override function countdownTick(count:Countdown, num:Int) everyoneDance();
	override function beatHit() everyoneDance();
	
	function everyoneDance()
	{
		nosePass1.dance(false);
		frenBinks.dance(false);
		carbinksleft.dance(false);
		carbinks12.dance(false);

		aBop.dance(false);
		lBop.dance(false);
		iBop.dance(false);
		mBop.dance(false);
		gBop.dance(false);
		jirachi.dance(false);

	}
	
}
		/*
	
					⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⢠⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
				⣤⣄⡀⠀⠀⠀⠙⣿⡯⠛⠛⠛⠲⠤⢿⣆⣙⠻⡶⢤⣀⣠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⢿⣯⠙⠛⠳⠦⠤⠼⣿⠛⠓⠲⠴⣶⠾⣿⠽⣧⣿⣤⡈⠻⣿⠦⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠘⣯⢣⡀⠈⠓⢦⣄⡈⠃⠀⠀⠀⠙⢧⡈⠻⣶⣭⣄⠙⢶⣌⠑⣾⣝⡳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠈⣷⣝⠦⣀⠀⠀⠉⢙⣲⡶⠴⠶⠶⠿⠷⣤⡈⠛⠿⡶⢍⣠⡿⣿⠗⠿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⣿⣟⠷⣌⡓⠦⠀⢯⡉⠉⠉⠉⠙⠒⠶⢴⣿⡟⠶⠦⠀⠘⠿⢿⣄⢀⣻⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠹⣟⢦⣀⣹⡧⠤⠍⠻⢦⣀⠀⠀⠀⠀⠸⣇⠙⣆⠀⡗⠓⣦⣄⣀⣿⡌⣧⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠘⠳⢿⣟⡒⠤⠤⠤⢄⠉⠳⣦⣤⠄⠀⣉⡤⠼⠞⠛⠋⠉⠉⠉⠙⠛⣿⡎⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⢀⣴⠏⠙⠛⣲⣶⠶⢶⡏⠁⢀⡴⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣿⣷⠀⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠉⠛⠛⢻⣿⡁⠀⠀⠸⠶⠞⠉⠀⠀⠀⠀⢀⣀⣠⣴⡶⠚⠋⢹⣿⢹⣿⡇⠘⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠈⣿⣇⠀⠀⢀⣀⣀⣠⡤⠶⠖⢛⣯⣵⠾⠿⠛⠓⠀⠀⢻⢘⣿⡇⠀⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠉⣉⣉⣀⣀⣄⡀⠀⠛⠋⢀⣴⣾⣿⠆⠀⠀⠈⢯⣿⠃⠀⠈⠻⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣼⡌⠉⢩⣽⣽⠽⢹⠀⠀⠀⠈⠈⠛⠁⠀⠀⠀⣠⡾⠃⠀⠀⠀⠀⠈⢳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣯⣧⠀⠁⠈⠉⠀⣼⣤⡤⠶⣶⠒⠒⠒⢚⣉⣭⠟⠁⠀⠀⠀⣀⣤⣤⠀⠹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣧⣀⡤⠖⣫⣽⠶⣷⠚⠉⠉⢿⠉⢉⡾⠁⠀⢀⡴⠞⠉⣁⣀⣤⠤⠤⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⠤⠖⠛⢹⠀⠀⢻⡀⠀⠀⢸⡶⠋⢀⡠⢞⣣⠴⠚⠋⠁⠀⠀⠀⠀⠈⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣧⠀⠀⠈⣧⠀⠀⢧⣀⡴⠋⠀⠀⢉⡴⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣇⠀⠀⠈⠂⢀⡼⠋⠀⠀⢀⡴⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⡿⣆⠀⠀⣰⠟⠁⠀⢀⡴⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⣶⠶⠖⠚⠉⠉⠙⠓⠶⣤⡀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⡟⠀⠙⣦⡾⠁⠀⢀⡴⠋⠀⠀⠀⠀⠀⠀⠀⢀⡤⠶⠋⠉⣠⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢶⡄⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⠟⠀⠀⣰⠟⠀⣠⡶⠋⠀⠀⠀⠀⠀⠀⢀⣤⠞⠉⠀⠀⠀⡼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣆⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡿⠃⠀⢀⡴⠃⢀⡀⠁⠀⠀⠀⠀⠀⢀⡤⠒⢿⡀⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣇
			⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⡁⠀⠀⣾⡁⣠⠞⠁⠀⠀⠀⠀⣀⡴⠋⠁⠀⠀⠻⠀⠀⢠⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣇⠀⢰⡏⠉⠁⠀⠀⠀⣀⡴⠚⠁⠀⢀⣴⠀⠀⠀⠀⢠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
			⠀⠀⠀⠀⠀⠀⠀⢀⣤⠾⣿⠀⠀⠁⠀⠀⢀⣤⢾⡅⠀⠀⣠⡴⠋⠁⠀⠀⠀⢀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
			⠀⠀⠀⠀⠀⠀⣠⠟⠁⠀⢸⡧⠤⠶⣺⣿⡉⠀⢸⣅⣴⠟⠁⠀⠀⠀⠀⠀⠀⣸⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
			⠀⠀⠀⠀⠀⢠⡟⠀⢀⣴⠛⡇⢸⡼⣿⣿⣿⣤⠾⡏⠁⠀⠀⠀⠀⠀⠀⠀⡼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
			⠀⠀⠀⠀⠀⢸⠀⣠⠞⢁⣴⡇⠘⣧⣽⡇⡟⠀⠀⠈⠃⠀⠀⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿
			⠀⠀⠀⠀⠀⠸⠾⠃⠀⠾⠀⠻⠋⠉⠘⠿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠐⠟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃
		hi 
		for beginner programmers.
		Whenever code is commented out like this, its removed from the programm as its being built (Tokenization.)
		So add dumb shit whenever you want, just make sure its commented out!
		- shadz
		*/