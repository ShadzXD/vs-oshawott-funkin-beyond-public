package objects;
import flixel.group.FlxSpriteGroup;

class MidSongCreditText extends FlxSpriteGroup
{
    public function new(_x:Int, _y:Int,?songName:String,?composer:String)
    {
        super(_x, _y);

        var songCard:FlxText = new FlxText(0, 300, songName);
		songCard.setFormat(Paths.font("PokemonGB.ttf"), 42, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		songCard.borderSize = 2;
		songCard.screenCenter(X);
		add(songCard);
	   
		var composerCard:FlxText = new FlxText(0, songCard.y + 50);
		composerCard.setFormat(Paths.font("PokemonGB.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		composerCard.borderSize = 2;
		composerCard.text = "--" + composer + "--";
        composerCard.screenCenter(X);
		add(composerCard);
    }
}