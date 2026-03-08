
import objects.VideoSprite;
var bg:FlxSprite;
var videoCutscene:VideoSprite;
function onCreate()
{
    bg = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
	bg.scale.set(FlxG.width, FlxG.height);
	bg.updateHitbox();
	bg.scrollFactor.set();
	add(bg);
    game.camHUD.alpha = 0;
    startVideo('genwunners-intro', true, false, false);
    game.videoCutscene.finishCallback = ass;

}
function ass()
{
    FlxTween.tween(bg, {alpha: 0}, 1, {ease: FlxEase.linear});
    trace('ended');
}