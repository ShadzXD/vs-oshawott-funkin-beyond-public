package states;
import flixel.addons.display.FlxBackdrop;

class WarningState extends MusicBeatState
{
    final text:String = 
    'This mod has been in the works for over three years and we unfortunately had to can what we had of the mod! There is still lots of quality stuff that the team is very proud of and I hope you all enjoy what we managed to make. Please note this is a CANCELED build so there are missing sprites, songs and other quirks and things! Be warned! We made it as cleaned up as we could for you to enjoy. Apologies to everyone who was looking forward to this mod. We may come back in the future but for now...\nLETS GO BEYOND!\n - owenthemc';
    var backspace:FlxSprite;
    var canExit:Bool = false;
    override public function create():Void
    {
        super.create();

		FlxG.sound.playMusic(Paths.music('breakfast'), 0);
		FlxG.sound.music.fadeIn(20, 0, 0.6);				

		var backdrop:FlxSprite = new FlxBackdrop(Paths.image("icons/oshawott"), XY, 10, -10);
		backdrop.velocity.set(20);
        backdrop.y -= 10;
        backdrop.alpha = 0.3;
     	add(backdrop);

        var warningText:FlxText = new FlxText(0,30,0, "Hello everyone!", 70);
        warningText.setFormat(Paths.font('Adamsky SF Regular.ttf'), 70, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
        warningText.screenCenter(X);
        warningText.updateHitbox();
        warningText.alpha = 0;
        add(warningText);
        FlxTween.tween(warningText, {alpha: 1}, 0.5, {ease: FlxEase.linear, startDelay: 2});

        var actualText:FlxText = new FlxText(0,110, 1000, text, 40);
        actualText.setFormat(Paths.font('Adamsky SF Regular.ttf'), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
        actualText.screenCenter(X);
        actualText.updateHitbox();
        actualText.alpha = 0;
        add(actualText);
        FlxTween.tween(actualText, {alpha: 1}, 0.7, {ease: FlxEase.linear, startDelay: 5});

        backspace = new FlxSprite(FlxG.width - 300, FlxG.height - 130);
        backspace.frames = Paths.getSparrowAtlas('menus/gallery/ui/backspace');
        backspace.animation.addByPrefix('backspace to exit white0', "backspace to exit white0", 24);
        backspace.animation.play('backspace to exit white0');
        backspace.updateHitbox();
        backspace.alpha = 0;
        add(backspace);
        FlxTween.tween(backspace, {alpha: 1}, 0.5, {ease: FlxEase.linear, startDelay: 10,
            onComplete: function(twn:FlxTween)
            {
                canExit = true;
            }
        });
        FlxTransitionableState.skipNextTransIn = true;
        FlxTransitionableState.skipNextTransOut = true;
    }
    override function update(elapsed:Float)
    {
        super.update(elapsed);
        if((controls.ACCEPT || controls.BACK) && canExit)
        {
            FlxG.camera.fade(FlxColor.BLACK, 1);
            backspace.animation.play('backspace to exit white0');
		    FlxG.sound.music.fadeOut(1, 0);				

            FlxG.save.data.seenDemoWarning = true;
            FlxG.save.flush();

            new FlxTimer().start(1.5, function(tmr:FlxTimer)
            {
                FlxG.switchState(new HaxeIntroState());
            });
    
        }

    }

}

