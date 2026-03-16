package states.stages;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxRuntimeShader;
import openfl.filters.ShaderFilter;
import substates.GameOverSubstate;
import shaders.DropShadowShader;
import objects.Character;
class Tepig extends BaseStage
{
	var victiniJumpscare:Bool = false;
	var victini:BGSprite;
	var bloom:FlxRuntimeShader;
	var daTween1:FlxTween;
	var daTween2:FlxTween;
	var daTween3:FlxTween;
	var bfShader:DropShadowShader;
	var dadShader:DropShadowShader;
	override function create()
	{
	
		var sky:BGSprite = new BGSprite('backgrounds/tepig/sky', -800, -600, 0.2, 0.2);
		add(sky);
		
		var cloudsbacker:FlxBackdrop = new FlxBackdrop(Paths.image('backgrounds/tepig/Clouds3'), X);
		cloudsbacker.y = -200;
		cloudsbacker.scrollFactor.set(0.35, 0.35);
		cloudsbacker.velocity.x = 7;
		add(cloudsbacker);

		var backermountain:BGSprite = new BGSprite('backgrounds/tepig/BackerMountain', -1000, -300, 0.35, 0.35);
		add(backermountain);

		var cloudsback:FlxBackdrop = new FlxBackdrop(Paths.image('backgrounds/tepig/Clouds2'), X);
		cloudsback.y = 0;
		cloudsback.scrollFactor.set(0.4, 0.4);
		//cloudsback.velocity.x = 15;
		add(cloudsback);

		var backMountainClouds:FlxSprite = new FlxSprite(-100, -800).loadGraphic(Paths.image('backgrounds/tepig/BackMountainClouds'));
		backMountainClouds.scrollFactor.set(0.5, 0.5);
		backMountainClouds.velocity.x = 5;
		add(backMountainClouds);
		
		var backmountain:BGSprite = new BGSprite('backgrounds/tepig/backMountain', -600, -350, 0.5, 0.5);
		add(backmountain);

		victini = new BGSprite('backgrounds/tepig/Victini', -65,250, 0.7, 0.7);
		add(victini);

		var frontmountain:BGSprite = new BGSprite('backgrounds/tepig/BigMountain', -550, -750, 0.7, 0.7);
		add(frontmountain);

		var frontMountainClouds:FlxSprite = new FlxSprite(-100, -650).loadGraphic(Paths.image('backgrounds/tepig/FrontMounttainClous'));
		frontMountainClouds.scrollFactor.set(0.7, 0.7);
		frontMountainClouds.scale.set(1.3,1.3);
		add(frontMountainClouds);
		
		var cloudsplatform:FlxSprite = new FlxSprite(-600, 200).loadGraphic(Paths.image('backgrounds/tepig/Clouds1'));
		cloudsplatform.scrollFactor.set(0.9, 0.9);
		add(cloudsplatform);

		var platform:BGSprite = new BGSprite('backgrounds/tepig/platform', -600, 300);
		add(platform);

		daTween1 = FlxTween.tween(cloudsplatform, {y:300}, 10, {type: FlxTween.PINGPONG, ease:  FlxEase.smootherStepInOut});
		daTween2 = FlxTween.tween(frontMountainClouds, {y:-700}, 20, {type: FlxTween.PINGPONG, ease:  FlxEase.smootherStepInOut});

		var _song = PlayState.SONG;
		if(_song.gameOverSound == null || _song.gameOverSound.trim().length < 1) GameOverSubstate.deathSoundName = 'fnf_loss_sfx-pico-explode';
		//if(_song.gameOverLoop == null || _song.gameOverLoop.trim().length < 1) GameOverSubstate.loopSoundName = 'gameOver-pico';
		//if(_song.gameOverEnd == null || _song.gameOverEnd.trim().length < 1) GameOverSubstate.endSoundName = 'gameOverEnd-pico';
		if(_song.gameOverChar == null || _song.gameOverChar.trim().length < 1) GameOverSubstate.characterName = 'pico-explosion-dead';
	}
	
	override function createPost()
	{
		if(ClientPrefs.data.shaders)createShaders();

		var cloudsFG:FlxSprite = new FlxSprite(-500, 500).loadGraphic(Paths.image('backgrounds/tepig/Clouds1'));
		cloudsFG.scrollFactor.set(1.1,1.1);
		cloudsFG.alpha = 0.5;
		cloudsFG.scale.set(1.1,1.1);
		add(cloudsFG);
		daTween3 = FlxTween.tween(cloudsFG, {y:600}, 10, {type: FlxTween.PINGPONG, ease:  FlxEase.smootherStepInOut, startDelay: 6});
	}
	function createShaders() //Create Shaders
	{
		bloom = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("bloom")));

		FlxG.camera.setFilters([new ShaderFilter(bloom)]);

		bfShader = new DropShadowShader();
		bfShader.setAdjustColor(-10, 0, 0, 0);
    	bfShader.color = 0xFFF4D993;
		bfShader.angle = 60;
		bfShader.attachedSprite = boyfriend;
		boyfriend.shader = bfShader;
		boyfriend.animation.callback = function(name:String, frameNumber:Int, frameIndex:Int) bfShader.updateFrameInfo(boyfriend.frame);

		dadShader = new DropShadowShader();
		dadShader.setAdjustColor(-10, 0, 0, 0);
    	dadShader.color = 0xFFF4D993;
		dadShader.angle = 15;
		dadShader.attachedSprite = dad;
		dad.shader = dadShader;
		dad.animation.callback = function(name:String, frameNumber:Int, frameIndex:Int)
		dadShader.updateFrameInfo(dad.frame);
		
	}
	override function beatHit()
	{
		if (FlxG.random.bool(0.5) && !victiniJumpscare)
		{
			victiniJumpscare = true;
			trace('jumpscare');
			 FlxTween.tween(victini, {y:130}, 0.4, {ease:  FlxEase.quadOut});
		}
	}
	private function createDropShadow(char:Character)
	{
		if(char.isAnimateAtlas || !ClientPrefs.data.shaders) return;

		trace('Character passed' + char);
		var shader:DropShadowShader = new DropShadowShader();
		shader.setAdjustColor(-10, 0, 0, 0);
    	shader.color = 0xFFF4D993;
		shader.angle = 85;
		shader.attachedSprite = char;
		char.shader = shader;
		char.animation.callback = function(name:String, frameNumber:Int, frameIndex:Int)
		shader.updateFrameInfo(char.frame);
	}
	override function closeSubState()
	{
		if(paused)
		{
			daTween1.active = true;
			daTween2.active = true;
			daTween3.active = true;
		}
	}
	
	override function openSubState(SubState:flixel.FlxSubState)
	{
		if(paused)
		{
			daTween1.active = false;
			daTween2.active = false;
			daTween3.active = false;
		}
	}
	override function stepHit()
	{
		switch(curStep)
		{
			case 960: createDropShadow(gf);
			case 1552: createDropShadow(boyfriend);
			case 2104: createDropShadow(boyfriend);
		}
	}
}