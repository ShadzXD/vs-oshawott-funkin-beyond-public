package backend;
import lime.utils.Assets;

using StringTools;
class SongInfo
{
    public static function ReturnComposerInfo(song:String):String {
        if (!Assets.exists(Paths.credits(song +'/info'))) return 'NOT FOUND';

            var pulledText:String = Assets.getText(Paths.credits(song+'/info'));
            var splitText:Array<String> = pulledText.split('\n');
            trace(splitText.length);
            return splitText[0];    
    }

}