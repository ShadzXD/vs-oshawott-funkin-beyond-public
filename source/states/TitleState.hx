package states;

import backend.WeekData;
import backend.Highscore;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.input.gamepad.FlxGamepad;

import states.StoryMenuState;
import states.MainMenuState;
import backend.Song;
//import overworld.OverworldState;

class TitleState extends MusicBeatState
{
	public static var initialized:Bool = false;

	private final debugStageTesting:Bool = false; //USED FOR QUICK TESTING STAGES, SKIPS MOST MENUS.
	private final testingSongname:String = 'watering'; //INPUT SONG NAME USED FOR TESTING, HERE
	private final debugOverworldTesting:Bool = false; //USED FOR QUICK TESTING THE OVERWORLD.

	override public function create():Void
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		super.create();

		if (initialized) startIntro();
		else
		{
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				startIntro();
			});
		}
		
	}
	

	
	var loopLOGO:FlxSprite;
	var introLOGO:FlxSprite;
	var pleaseText:FlxText;

	function startIntro()
	{
		if (!initialized)
		{
			if(FlxG.sound.music == null) {
				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			}
		}

		Conductor.bpm = 140;
		
		var scrollingBG:FlxSprite = new FlxBackdrop(Paths.image("menus/thefunny"), X, -10, -10);
		scrollingBG.velocity.set(-110);
		scrollingBG.scale.set(1.12, 1.12);
     	add(scrollingBG);

		loopLOGO = new FlxSprite(318, 188);
		loopLOGO.frames = Paths.getSparrowAtlas('menus/title/OshawottLogoNew-basic');
		loopLOGO.animation.addByPrefix('bump', 'Bop', 24, false);
		loopLOGO.updateHitbox();
		loopLOGO.visible = false;
		
		if(!initialized)
		{
			introLOGO = new FlxSprite(337, 194);
			introLOGO.frames = Paths.getSparrowAtlas('menus/title/OshawottLogoNew-transition');
			introLOGO.animation.addByPrefix('start', 'Appearing', 24, false);
			introLOGO.animation.play('start');
			introLOGO.updateHitbox();
 			introLOGO.animation.finishCallback = (animationName:String)->{skipIntro();};
		}

		pleaseText = new FlxText(50, 580, FlxG.width - 100, "Please Press Confirm");
        pleaseText.setFormat(Paths.font("Adamsky SF Regular.ttf"), 40, 0xffffff, CENTER);
	    pleaseText.screenCenter(X);
		pleaseText.updateHitbox();
		pleaseText.size = 45;
        add(pleaseText);
		pleaseText.visible = false;
	
		add(loopLOGO);
		if(!initialized)add(introLOGO);
	
		FlxTween.tween(pleaseText, {y: pleaseText.y + 10}, 0.8, {ease: FlxEase.quadInOut, type: PINGPONG}); // too make it look more cooler

		if (initialized)
			skipIntro();
		else
			initialized = true;

		Paths.clearUnusedMemory();
	}

	var transitioning:Bool = false;
	private static var playJingle:Bool = false;
	
	var newTitle:Bool = false;
	var titleTimer:Float = 0;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER || controls.ACCEPT;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}
		
		if (newTitle) {
			titleTimer += FlxMath.bound(elapsed, 0, 1);
			if (titleTimer > 2) titleTimer -= 2;
		}

		if (initialized && !transitioning && skippedIntro)
		{
			if (newTitle && !pressedEnter)
			{
				var timer:Float = titleTimer;
				if (timer >= 1)
					timer = (-timer) + 2;
				
				timer = FlxEase.quadInOut(timer);
				
			
			}
			
			if(pressedEnter)
			{
				FlxG.sound.music.fadeOut(0.9, 0);
				FlxTween.tween(FlxG.camera, {zoom: 4}, 3, {ease: FlxEase.quartInOut}); // zoomy zoomy when you hit enter enter
				FlxG.camera.flash(ClientPrefs.data.flashing ? FlxColor.WHITE : 0x4CFFFFFF, 1);
				FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

				transitioning = true;
				// FlxG.sound.music.stop();

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					
					if (debugStageTesting){
						PlayState.storyPlaylist = [testingSongname];
						PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(),
						PlayState.storyPlaylist[0].toLowerCase());
						PlayState.campaignScore = 0;
						PlayState.campaignMisses = 0;
						MusicBeatState.switchState(new PlayState());
					} else if (debugOverworldTesting){
						//MusicBeatState.switchState(new OverworldState());

					} else {
						FlxG.sound.music.stop();
						MusicBeatState.switchState(new MainMenuState(true));
					}
					closedState = true;
				});
			}
		
		}

		if (initialized && pressedEnter && !skippedIntro)
		{
			skipIntro();
		}
		super.update(elapsed);
	}

	private var sickBeats:Int = 0; //Basically curBeat but won't be skipped if you hold the tab or resize the screen
	public static var closedState:Bool = false;
	override function beatHit()
	{
		super.beatHit();
		loopLOGO.animation.play('bump');
		if(!closedState) {
			sickBeats++;
			switch (sickBeats)
			{
				case 1:
					FlxG.sound.music.stop();
					FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
					FlxG.sound.music.fadeIn(4, 0, 0.7);				
		
			}
		}
	}

	override function stepHit()
	{
		super.stepHit();		
	}

	var skippedIntro:Bool = false;
	function skipIntro():Void
	{
		if (!skippedIntro)
		{
		
			if(introLOGO != null)remove(introLOGO);
			pleaseText.visible = true;
			loopLOGO.visible = true;
			FlxG.camera.flash(ClientPrefs.data.flashing ? FlxColor.WHITE : FlxColor.TRANSPARENT, 0.6);

			skippedIntro = true;
		}
	}
}
