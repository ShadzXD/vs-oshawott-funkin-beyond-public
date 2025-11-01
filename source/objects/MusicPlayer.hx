package objects;

import flixel.group.FlxGroup;
import flixel.ui.FlxBar;
import flixel.util.FlxStringUtil;

import states.FreeplayState;

/**
 * Music player used for Freeplay
 */
@:access(states.FreeplayState)
class MusicPlayer extends FlxGroup 
{
	public var instance:FreeplayState;
	public var controls:Controls;

	public var playing(get, never):Bool;

	public var playingMusic:Bool = false;
	public var curTime:Float;

	var wasPlaying:Bool;

	var holdPitchTime:Float = 0;
	var playbackRate(default, set):Float = 1;

	public function new(instance:FreeplayState)
	{
		super();

		this.instance = instance;
		this.controls = instance.controls;

		var xPos:Float = FlxG.width * 0.7;

		switchPlayMusic();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!playingMusic)
		{
			return;
		}

		var songName:String = instance.songs[FreeplayState.curSelected].songName;
		if (playing && !wasPlaying)
			FreeplayState.instance.scoreText.text = 'PLAYING!' + timeTxt;
		else
			FreeplayState.instance.scoreText.text = 'PAUSED! ' + timeTxt;

		//if(FlxG.keys.justPressed.K) trace('Time: ${FreeplayState.vocals.time}, Playing: ${FreeplayState.vocals.playing}');

		if (controls.UI_LEFT_P)
		{
			if (playing)
				wasPlaying = true;

			pauseOrResume();

			curTime = FlxG.sound.music.time - 1000;
			instance.holdTime = 0;

			if (curTime < 0)
				curTime = 0;

			FlxG.sound.music.time = curTime;
			setVocalsTime(curTime);
		}
		if (controls.UI_RIGHT_P)
		{
			if (playing)
				wasPlaying = true;

			pauseOrResume();

			curTime = FlxG.sound.music.time + 1000;
			instance.holdTime = 0;

			if (curTime > FlxG.sound.music.length)
				curTime = FlxG.sound.music.length;

			FlxG.sound.music.time = curTime;
			setVocalsTime(curTime);
		}

		if(controls.UI_LEFT || controls.UI_RIGHT)
		{
			instance.holdTime += elapsed;
			if(instance.holdTime > 0.5)
			{
				curTime += 40000 * elapsed * (controls.UI_LEFT ? -1 : 1);
			}

			var difference:Float = Math.abs(curTime - FlxG.sound.music.time);
			if(curTime + difference > FlxG.sound.music.length) curTime = FlxG.sound.music.length;
			else if(curTime - difference < 0) curTime = 0;

			FlxG.sound.music.time = curTime;
			setVocalsTime(curTime);
		}

		if(controls.UI_LEFT_R || controls.UI_RIGHT_R)
		{
			FlxG.sound.music.time = curTime;
			setVocalsTime(curTime);

			if (wasPlaying)
			{
				pauseOrResume(true);
				wasPlaying = false;
			}
		}
		if (controls.UI_UP_P)
		{
			holdPitchTime = 0;
			playbackRate += 0.05;
			setPlaybackRate();
		}
		else if (controls.UI_DOWN_P)
		{
			holdPitchTime = 0;
			playbackRate -= 0.05;
			setPlaybackRate();
		}
		if (controls.UI_DOWN || controls.UI_UP)
		{
			holdPitchTime += elapsed;
			if (holdPitchTime > 0.6)
			{
				playbackRate += 0.05 * (controls.UI_UP ? 1 : -1);
				setPlaybackRate();
			}
		}
	
		if (controls.RESET)
		{
			playbackRate = 1;
			setPlaybackRate();

			FlxG.sound.music.time = 0;
			setVocalsTime(0);
		}

		if (playing)
		{
			if(FreeplayState.vocals != null)
				FreeplayState.vocals.volume = (FreeplayState.vocals.length > FlxG.sound.music.time) ? 0.8 : 0;
			if(FreeplayState.opponentVocals != null)
				FreeplayState.opponentVocals.volume = (FreeplayState.opponentVocals.length > FlxG.sound.music.time) ? 0.8 : 0;

			if((FreeplayState.vocals != null && FreeplayState.vocals.length > FlxG.sound.music.time && Math.abs(FlxG.sound.music.time - FreeplayState.vocals.time) >= 25) ||
			(FreeplayState.opponentVocals != null && FreeplayState.opponentVocals.length > FlxG.sound.music.time && Math.abs(FlxG.sound.music.time - FreeplayState.opponentVocals.time) >= 25))
			{
				pauseOrResume();
				setVocalsTime(FlxG.sound.music.time);
				pauseOrResume(true);
			}
		}

		updateTimeTxt();
	}

	function setVocalsTime(time:Float)
	{
		if (FreeplayState.vocals != null && FreeplayState.vocals.length > time)
			FreeplayState.vocals.time = time;
		if (FreeplayState.opponentVocals != null && FreeplayState.opponentVocals.length > time)
			FreeplayState.opponentVocals.time = time;
	}

	public function pauseOrResume(resume:Bool = false) 
	{
		if (resume)
		{
			if(!FlxG.sound.music.playing)
				FlxG.sound.music.resume();

			if (FreeplayState.vocals != null && FreeplayState.vocals.length > FlxG.sound.music.time && !FreeplayState.vocals.playing)
				FreeplayState.vocals.resume();
			if (FreeplayState.opponentVocals != null && FreeplayState.opponentVocals.length > FlxG.sound.music.time && !FreeplayState.opponentVocals.playing)
				FreeplayState.opponentVocals.resume();
		}
		else 
		{
			FlxG.sound.music.pause();

			if (FreeplayState.vocals != null)
				FreeplayState.vocals.pause();
			if (FreeplayState.opponentVocals != null)
				FreeplayState.opponentVocals.pause();
		}
	}

	public function switchPlayMusic()
	{
		FlxG.autoPause = (!playingMusic && ClientPrefs.data.autoPause);
		active = visible = playingMusic;

		holdPitchTime = 0;
		instance.holdTime = 0;
		playbackRate = 1;

		if (playingMusic)
		{
	

			updateTimeTxt();
		}
	}
	var timeTxt:String;
	function updateTimeTxt():Void
	{
		timeTxt = ' (' +  FlxStringUtil.formatTime(FlxG.sound.music.time / 1000, false) + ' / ' + FlxStringUtil.formatTime(FlxG.sound.music.length / 1000, false) + ')';
	}

	function setPlaybackRate() 
	{
		FlxG.sound.music.pitch = playbackRate;
		if (FreeplayState.vocals != null)
			FreeplayState.vocals.pitch = playbackRate;
		if (FreeplayState.opponentVocals != null)
			FreeplayState.opponentVocals.pitch = playbackRate;
	}

	function get_playing():Bool 
	{
		return FlxG.sound.music.playing;
	}

	function set_playbackRate(value:Float):Float 
	{
		var value = FlxMath.roundDecimal(value, 2);
		if (value > 3) value = 3;
		else if (value <= 0.25) value = 0.25;
		return playbackRate = value;
	}
}