package states;

import backend.WeekData;
import backend.Highscore;
import backend.Song;
//import substates.StickerSubState;

import flixel.group.FlxGroup;

import options.GameplayChangersSubstate;
import substates.ResetScoreSubState;
import flixel.util.FlxStringUtil;
import flixel.addons.transition.FlxTransitionableState;

class StoryMenuState extends MusicBeatState
{
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();

	var scoreText:FlxText;

	var curDifficulty:Int = 1;

	private static var lastDifficultyName:String = '';


	var portraitGroup:FlxSpriteGroup = new FlxSpriteGroup();

	var weekItems:FlxTypedGroup<FlxSprite> = new FlxTypedGroup();
	var pokedex:FlxSprite;
	var curSelected:Int = 0;
	var cursorSpr:FlxSprite;

	//var stickerSubState:substates.StickerSubState;
	public var precacheList:Map<String, String> = new Map<String, String>();
	var week1music:FlxSound;
	var week2music:FlxSound;
	var week3music:FlxSound;
	var loadedWeeks:Array<WeekData> = [];
	var isChangingSelections:Bool = false;
	var stickerSubState:StickerSubState;
	public function new(?stickers:StickerSubState = null)
  	{
    	super();

    	if (stickers?.members != null)
    	{
      		stickerSubState = stickers;
    	}
 	}
	var blackBar:FlxSprite;
	override function create()
	{
		Paths.clearUnusedMemory();
		persistentUpdate = persistentDraw = true;
		if (stickerSubState != null)
		{
			openSubState(stickerSubState);
			stickerSubState.degenStickers();
			FlxG.sound.playMusic(Paths.music('mainmenu'));
		}
		else
		Paths.clearStoredMemory();
		WeekData.reloadWeekFiles(true);

		PlayState.isStoryMode = true;
		PlayState.storyWeek = curSelected;
		FlxG.sound.music.stop();

        add(portraitGroup);

		blackBar = new FlxSprite().makeGraphic(700, 50, FlxColor.BLACK);
		blackBar.alpha = 0.6;
		add(blackBar);

		scoreText = new FlxText(10, 7, 0, "bugged rn sorry", 36);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32);
		add(scoreText);
		
        pokedex = new FlxSprite().loadGraphic(Paths.image('menus/storymode/pokedex'));
		pokedex.screenCenter();
        pokedex.x += 330;
		add(pokedex);

		var num:Int = 0;

		for (i in 0...WeekData.weeksList.length)
		{
			
			var weekFile:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			trace(weekFile.hideStoryMode);
			if(!weekFile.hideStoryMode)
			{
				loadedWeeks.push(weekFile);

				var portrait:FlxSprite = new FlxSprite(0, i * 720);
				portrait.frames = Paths.getSparrowAtlas('menus/storymode/' + WeekData.weeksList[i]);
				portrait.animation.addByPrefix('anim',  WeekData.weeksList[i] + ' portrait instância', 24, true);
				portrait.animation.play('anim');
				portrait.ID = i;
				portrait.antialiasing = ClientPrefs.data.antialiasing;
				portraitGroup.add(portrait);

				var selectionItem:FlxSprite = new FlxSprite(775, (210 * i) + 75);
				selectionItem.frames = Paths.getSparrowAtlas('menus/storymode/selection_'+WeekData.weeksList[i]);
				selectionItem.animation.addByPrefix('basic', 'basic'+WeekData.weeksList[i], 24, true);
				selectionItem.animation.addByPrefix('selected', 'select'+WeekData.weeksList[i], 24, false);
				selectionItem.animation.play('basic');
				selectionItem.antialiasing = ClientPrefs.data.antialiasing;
				weekItems.add(selectionItem);
				selectionItem.ID = i;
			}
		
		}
		add(weekItems);
		//music = new FlxSound();
		WeekData.setDirectoryFromWeek(loadedWeeks[0]);

		cursorSpr = new FlxSprite(670);
		cursorSpr.frames = Paths.getSparrowAtlas('menus/storymode/cursor');
		cursorSpr.animation.addByPrefix('idle', 'cursor instância', 24, false);
		cursorSpr.animation.addByPrefix('up', 'cursor_MoveDown instância', 20, false);
		cursorSpr.animation.addByPrefix('down', 'cursor_MoveUp instância', 20, false);
		cursorSpr.animation.play('idle');
		add(cursorSpr);  

		

		Difficulty.resetList();
		if(lastDifficultyName == '')
		{
			lastDifficultyName = Difficulty.getDefault();
		}
		curDifficulty = Math.round(Math.max(0, Difficulty.defaultList.indexOf(lastDifficultyName)));
		changeSelection(0);

		super.create();
	}

	override function closeSubState() {
		persistentUpdate = true;
		//changeWeek();
		super.closeSubState();
	}

	override function update(elapsed:Float)
	{
		intendedScore = Highscore.getWeekScore(loadedWeeks[curSelected].fileName, curDifficulty);

		lerpScore = Math.floor(FlxMath.lerp(intendedScore, lerpScore, Math.exp(-elapsed * 30)));
		if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;

		scoreText.text = "WEEK SCORE:" + FlxStringUtil.formatMoney(lerpScore, false, true);
		// FlxG.watch.addQuick('font', scoreText.font);
		if (!movedBack && !selectedWeek)
		{
			var upP = controls.UI_UP_P;
			var downP = controls.UI_DOWN_P;
			if (upP)
			{
				changeSelection(-1);
				cursorSpr.animation.play('up');
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if (downP)
			{
				cursorSpr.animation.play('down');
				changeSelection(1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if(FlxG.keys.justPressed.CONTROL)
			{
				persistentUpdate = false;
				openSubState(new GameplayChangersSubstate());
			}
			else if(controls.RESET)
			{
				persistentUpdate = false;
				openSubState(new ResetScoreSubState('', curDifficulty, '', curSelected));
				//FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			else if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			lastSavedTime = FlxG.sound.music.time;
			FlxG.sound.playMusic(Paths.music('mainmenu', true));
			FlxG.sound.music.time = lastSavedTime;
			movedBack = true;
			MusicBeatState.switchState(new MainMenuState());
		}

		super.update(elapsed);

	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	
	function selectWeek()
	{
		trace(WeekData.getWeekFileName());
		if (!weekIsLocked(loadedWeeks[curSelected].fileName))
		{
			// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = loadedWeeks[curSelected].songs;
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}

			// Nevermind that's stupid lmao
			try
			{
				PlayState.storyPlaylist = songArray;
				PlayState.isStoryMode = true;
				selectedWeek = true;
	
				var diffic = Difficulty.getFilePath(curDifficulty);
				if(diffic == null) diffic = '';
	
				PlayState.storyDifficulty = curDifficulty;
	
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
				PlayState.campaignScore = 0;
				PlayState.campaignMisses = 0;

				for (item in weekItems)
				{
					if(item.ID == curSelected)
					{
						item.animation.play('selected');
						item.centerOffsets();
					} 
					FlxTween.tween(item, {alpha: 0}, 0.5, {ease: FlxEase.quadIn, startDelay: 0.5});
				}
				FlxTween.tween(portraitGroup, {x: -1000}, 0.4, {ease: FlxEase.quadIn, startDelay: 0.5});
				FlxTween.tween(pokedex, {x: 1300}, 0.5, {ease: FlxEase.quadIn, startDelay: 0.5});
				FlxTween.tween(FlxG.camera, {zoom: 5}, 0.7, {ease: FlxEase.quadIn,  startDelay: 0.5}); // zoomy zoomy when you hit enter enter
				FlxG.sound.music.fadeOut(1);
				FlxTween.tween(cursorSpr, {alpha: 0}, 0.5);

			}
			catch(e:Dynamic)
			{
				trace('ERROR! $e');
				return;
			}
			
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				
				stopspamming = true;
			}

			new FlxTimer().start(1.3, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
				FreeplayState.destroyFreeplayVocals();
			});
			
	
		}
		else FlxG.sound.play(Paths.sound('cancelMenu'));
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}
	var lastSavedTime:Float;
	var musicOn:Int = 0;
	var tweenMusic:FlxTween;
	function changeSelection(what:Int)
	{
		cursorSpr.centerOffsets();

		curSelected = FlxMath.wrap(curSelected + what, 0, loadedWeeks.length - 1);
	
		var leWeek:WeekData = loadedWeeks[curSelected];
		WeekData.setDirectoryFromWeek(leWeek);
		PlayState.storyWeek = curSelected;
		trace(PlayState.storyWeek);
		var daChoice:String = WeekData.weeksList[curSelected];
		FlxTween.cancelTweensOf(portraitGroup);
		FlxTween.cancelTweensOf(cursorSpr);
		switch (daChoice)
		{
			case 'week1':
				FlxTween.tween(portraitGroup, {y: 0}, 0.3, {ease: FlxEase.quintInOut});
				FlxTween.tween(cursorSpr, {y: 112}, 0.3, {ease: FlxEase.quintInOut});
				musicOn = 1;
				
			case 'week2':
				FlxTween.tween(portraitGroup, {y: -720}, 0.3, {ease: FlxEase.quintInOut});
				FlxTween.tween(cursorSpr, {y: 340}, 0.3, {ease: FlxEase.quintInOut});
				musicOn = 2;	

			case 'week3':
				FlxTween.tween(portraitGroup, {y: -1440}, 0.3, {ease: FlxEase.quintInOut});
				FlxTween.tween(cursorSpr, {y: 550}, 0.3, {ease: FlxEase.quintInOut});
				musicOn = 3;
			
		}
		lastSavedTime = FlxG.sound.music.time;
		FlxG.sound.playMusic(Paths.music('menus/MenuWeek'+ musicOn, true));
		FlxG.sound.music.time = lastSavedTime;
		/*
		if(tweenMusic != null) 
		tweenMusic.cancel();
		tweenMusic = FlxTween.tween(music, {volume: 0}, 0.01, { 
			onComplete: function(twn:FlxTween)
			{
				tweenMusic = FlxTween.tween(music, {volume: 1}, 0.3, {
				onComplete: function(twn:FlxTween)
				{
					tweenMusic = null;
						
				}});
			}
		});
		*/
	}
}
