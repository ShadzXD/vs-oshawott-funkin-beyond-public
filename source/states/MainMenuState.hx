package states;

import backend.WeekData;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import sys.io.File;
import flixel.util.FlxSave;
import flixel.util.FlxColor;
import states.editors.MasterEditorMenu;
import flixel.FlxObject;
import flixel.addons.display.FlxBackdrop;
import sys.io.File;
import flixel.group.FlxGroup;
import backend.Song;
import substates.StickerSubState;
class MainMenuState extends MusicBeatState 
{
    // Buttons
    var storymode: FlxSprite;
    var freeplay: FlxSprite;
    var credits: FlxSprite;
    var gallery: FlxSprite;
    var options: FlxSprite;
    var initialY:Float;

    // Misc
    var background: FlxSprite;
    var pokeball: FlxSprite;
    var pokeballlines: FlxSprite;

    var selectedItem:Int = 1;
	var stickerSubState:StickerSubState;

   // System/Discord RPT
   public static var psychEngineVersion:String = '1.0.4';
   var came:Bool = false; //yeah, my pants... heh.
   public function new(?stickers:StickerSubState = null, cameFromTitle:Bool = false)
	{
	  if (stickers != null)
	  {
		stickerSubState = stickers;
	  }
      came = cameFromTitle;
	  super();
	}
    //todo: i fucking hate this stupid stupid stupid stupid stupid  main menu, recode it.
    override public function create():Void {

        //System Stuff (again)
        Paths.clearStoredMemory();
        Paths.clearUnusedMemory();

        if(came) FlxG.sound.playMusic(Paths.music('mainmenu'), 1);

        //transIn = FlxTransitionableState.defaultTransIn; ???????? what do these even do
       // transOut = FlxTransitionableState.defaultTransOut;

        // Visuals and Buttons    
        background = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/main/background'));
        background.alpha = 0.6;
        background.antialiasing = false;
		add(background);
        
        pokeballlines = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/main/pokeballlines'));
        pokeballlines.antialiasing = false;
		add(pokeballlines);

        pokeball = new FlxSprite(0, 1280).loadGraphic(Paths.image('menus/main/pokeball'));
        FlxTween.tween(pokeball, { y: 0}, 1.4, {ease: FlxEase.quartInOut});
        pokeball.antialiasing = false;
		add(pokeball);

        // Calculate the initial Y-coordinate for the buttons
        initialY = FlxG.height - 450;

        // Create and position the FlxSprites
        options = new FlxSprite(-320, initialY - -100); 
        options.loadGraphic(Paths.image('menus/main/options'));
        options.antialiasing = false;
        options.scale.set(0.3, 0.3);
        add(options);
    
        gallery = new FlxSprite(-320, initialY - 0); 
        gallery.loadGraphic(Paths.image('menus/main/gallery'));
        gallery.scale.set(0.3, 0.3);
        gallery.antialiasing = false;
        add(gallery);
    
        credits = new FlxSprite(-320, initialY - 100);
        credits.loadGraphic(Paths.image('menus/main/credits'));
        credits.scale.set(0.3, 0.3);
        credits.antialiasing = false;
        add(credits);
    
        freeplay = new FlxSprite(-320, initialY - 200); 
        freeplay.loadGraphic(Paths.image('menus/main/free'));
        freeplay.scale.set(0.3, 0.3);
        freeplay.antialiasing = false;
        add(freeplay);
    
        storymode = new FlxSprite(-320, initialY - 300); 
        storymode.loadGraphic(Paths.image('menus/main/story'));
        storymode.scale.set(0.3, 0.3);
        storymode.antialiasing = false;
        add(storymode);

        updateSelection(0);

        super.create();
    }

    var allowInputs: Bool = true;

    override public function update(elapsed: Float):Void {
        super.update(elapsed);

       // if (FlxG.keys.justPressed.O) {
           // MusicBeatState.switchState(new OverworldState()); disabling this for now
       // }

        if (allowInputs) {
            if (controls.UI_UP_P)
                updateSelection(-1);
            if (controls.UI_DOWN_P)
                updateSelection(1);

            if (controls.justPressed('debug_1'))
		    {
                MusicBeatState.switchState(new MasterEditorMenu());
            }

            if (controls.BACK)
            {
                allowInputs = false;
                FlxG.sound.play(Paths.sound('cancelMenu'));
                MusicBeatState.switchState(new TitleState());
            }
            
            // Check for ACCEPT key press (it was enter before, which was dumb)
            if (controls.ACCEPT) {
                FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
                // Perform an action based on the selectedItem value
                switch (selectedItem) {
                case 1:
                    if (FlxG.save.data.playedAsperita != null)
                        {
                            MusicBeatState.switchState(new StoryMenuState());
                            storymode.loadGraphic(Paths.image('menus/main/story-confirm'));
                        }
                        else
                        {
                            PlayState.isStoryMode = true;
                            WeekData.reloadWeekFiles(true);
                            PlayState.storyPlaylist = ['Asperita'];
                            PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(), PlayState.storyPlaylist[0].toLowerCase());
                            PlayState.campaignScore = 0;
                            PlayState.campaignMisses = 0;
                            LoadingState.loadAndSwitchState(new PlayState(), true);
                        }
                case 2:
                    MusicBeatState.switchState(new FreeplayState());
                    freeplay.loadGraphic(Paths.image('menus/main/free-confirm'));
                case 3:
                    MusicBeatState.switchState(new CreditsState());
                    credits.loadGraphic(Paths.image('menus/main/credits-confirm'));
                case 4:
                    MusicBeatState.switchState(new GalleryState());
                    gallery.loadGraphic(Paths.image('menus/main/gallery-confirm'));
                case 5:
                    MusicBeatState.switchState(new options.OptionsState());  
                    options.loadGraphic(Paths.image('menus/main/options-confirm'));      
                }
            }
        }
     }

        public function updateSelection(?move:Int = 0): Void {
        selectedItem += move;
        if (move != 0) FlxG.sound.play(Paths.sound('scrollMenu'));
        if (selectedItem > 5) selectedItem = 1; 
        if (selectedItem < 1) selectedItem = 5;

        storymode.alpha = 0.7;
        freeplay.alpha = 0.7;
        credits.alpha = 0.7;
        gallery.alpha = 0.7;
        options.alpha = 0.7;

        switch (selectedItem) {
            case 1:
                storymode.alpha = 1.0;
            case 2:
                freeplay.alpha = 1.0;
            case 3:
                credits.alpha = 1.0;
            case 4:
                gallery.alpha = 1.0;  
            case 5:
                options.alpha = 1.0;                               
        }
    }
}
