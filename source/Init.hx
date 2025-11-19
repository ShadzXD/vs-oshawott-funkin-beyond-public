package;
import flixel.input.keyboard.FlxKey;
import backend.Highscore;
import states.StoryMenuState;
import flixel.addons.transition.FlxTransitionableState;
import backend.WeekData;
/**
 * State to load initial variables.
 */
class Init
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];
    public static function setup():Void
    {
        #if LUA_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		FlxG.fixedTimestep = false;
		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];

        FlxG.save.bind('funkin', CoolUtil.getSavePath());
        if(FlxG.save.data != null && FlxG.save.data.fullscreen)
		{
			FlxG.fullscreen = FlxG.save.data.fullscreen;
		}

		ClientPrefs.loadPrefs();
		Highscore.load();
		Language.reloadPhrases();
	
		if (FlxG.save.data.weekCompleted != null)
		{
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}
		if(FlxG.save.data.stickersUnlocked == null) FlxG.save.data.stickersUnlocked = ['bf', 'gf'];

		trace(FlxG.save.data.stickersUnlocked);

		//FlxG.mouse.visible = true;
    }
}