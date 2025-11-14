package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxColor;
import sys.io.File;
import haxe.Json;

class CreditState extends MusicBeatState 
{
    // Variables
    var name: FlxText;
    var quote: FlxText;
    var bg: FlxSprite;
    var gradient: FlxSprite;
    var creditui: FlxSprite;
    var behindbar: FlxSprite;
    var namecard: FlxSprite;    
    var menubg: FlxSprite;
    var changingSprite: FlxSprite;
    var descBar: FlxSprite;
    var descText: FlxText;  
    var linkOpen: Array<String> = [];
    var currentIndex: Int = 0;
    var allowInputs: Bool = true;
    var CreditData: Array<CreditData>;

    override public function create(): Void {
        Paths.clearStoredMemory();
        Paths.clearUnusedMemory();
        FlxG.sound.playMusic(Paths.music('menus/creditsMenu'));

        var jsonData:String = Paths.getTextFromFile("data/credits.json");

        CreditData = haxe.Json.parse(jsonData);

        // Visual Shit
        gradient = new FlxSprite(0, 0);
        gradient.loadGraphic(Paths.image('menus/credits/gradient'));
        add(gradient);

        var check:FlxBackdrop = new FlxBackdrop(Paths.image('menus/credits/tile'), XY, FlxG.random.int(0, 0), FlxG.random.int(0, 0));
		check.scrollFactor.set(0.3, 0.3);     
		check.velocity.set(50, 0);
		add(check);

        creditui = new FlxSprite(0, 0);
        creditui.loadGraphic(Paths.image('menus/credits/UI'));
        add(creditui);

        // Changing Sprite 
        changingSprite = new FlxSprite(410, 180);
        changingSprite.loadGraphic(Paths.image(''));
        add(changingSprite);

        // Name
        name = new FlxText(250, 375, 500, "");
        name.setFormat(Paths.font("vcr.ttf"), 46, FlxColor.WHITE, CENTER);
        add(name);

        // Description Text
        descText = new FlxText(990, 120, 250, "");
        descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
        add(descText);

        // Quote text
        quote = new FlxText(275,525, 500, "");
        quote.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER);
        add(quote);

        super.create();
    }

    private function setCreditContent(index: Int): Void {
        if (index >= 0 && index < CreditData.length) {
            var data: CreditData = CreditData[index];
            if (data != null) {
                changingSprite.loadGraphic(Paths.image("menus/credits/icons/" + data.path));
                name.text = data.name;
                quote.text = data.quote;
                descText.text = data.description;
                linkOpen.push(data.link);
            }
        }
    }

    override public function update(elapsed: Float): Void {
        super.update(elapsed);
        setCreditContent(currentIndex);
        if (name == null) {
            currentIndex = (currentIndex + 1) % CreditData.length;
            setCreditContent(currentIndex);
        }
        if (controls.BACK && allowInputs) {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            MusicBeatState.switchState(new MainMenuState());
            FlxG.sound.playMusic(Paths.music('mainmenu'));
        }

        if (controls.UI_RIGHT_P) {
            currentIndex = (currentIndex + 1) % CreditData.length;
            setCreditContent(currentIndex);
        }

        if (controls.UI_LEFT_P) {
            currentIndex = (currentIndex - 1 + CreditData.length) % CreditData.length;
            setCreditContent(currentIndex);
        }

        if (controls.ACCEPT && allowInputs) {
            if (currentIndex >= 0 && currentIndex < CreditData.length) {
                var data: CreditData = CreditData[currentIndex];
                if (data != null && data.link != null && data.link != "") {
                    CoolUtil.browserLoad(data.link);
                }
            }
        }
    }
}

typedef CreditData = {
    path: String,
    description: String,
    name: String,
    link: String,
    quote: String
}
