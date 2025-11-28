package backend;
import lime.utils.Assets;
import haxe.Json;
typedef MetaDataInfo =
{
	var composer:String;
	var artist:String;
	var charter:String;
	@:optional var stickers:Array<String>;
}

class SongMetadata
{
	public var songComposer:String;
	public var songCharter:String;
	public var songArtist:String;
	public var songCoder:String;
	public var stickersToBeUnlocked:Array<String>;

	public static var usesJson:Bool = false;
	public static var metadataPath:String;
	public function new(songName:String)
	{
		if(songMetaDataCheck(songName) == false) return;

		var unformatted:String =  File.getContent(metadataPath);
		var songJSON:MetaDataInfo = tjson.TJSON.parse(unformatted);
		//trace(metadataPath);
		//trace(unformatted);
		songComposer = songJSON.composer;
		songCharter = songJSON.charter;
		songArtist = songJSON.artist;

		stickersToBeUnlocked = songJSON.stickers;
		
		
		trace(songComposer);
		trace(songCharter);
		trace(songArtist);
		trace(stickersToBeUnlocked);
		
		trace('song has metadata');

	}
	/** 
	* Checks if theres metadata available for the selected song.
	* @param songName 
	* @return Bool
	*/
	public static function songMetaDataCheck(songName:String):Bool
	{
		var	formattedSongString:String = Paths.formatToSongPath(songName);
		metadataPath = Paths.json(formattedSongString +'/metadata');
		if(Assets.exists(metadataPath)) return true;
		else  return false;
	}
}

