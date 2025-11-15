package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;

import flixel.math.FlxMath;
import flixel.addons.display.FlxBackdrop;

import flixel.addons.display.FlxRuntimeShader;
import sys.io.File;
import openfl.filters.ShaderFilter;
import haxe.Json;

/**
 * @author SquidBowl/Tinkatonk
 */

class GalleryState extends MusicBeatState
{
    // DATA STUFF

    var itemGroup:FlxTypedGroup<GalleryImage>;
    var imagePaths:Array<String>;
    var imageDescriptions:Array<String>;
    var imageTitle:Array<String>;
    var linkOpen:Array<String>;
    var descriptionText:FlxText;
    var tvShader:FlxRuntimeShader;

    var currentIndex:Int = 0;
    var allowInputs:Bool = true;

    // UI STUFF
    var imageSprite:FlxSprite;
    var background:FlxSprite;
    var titleText:FlxText;
    var bars:FlxSprite;
    var bg:FlxSprite; 
    var backspace:FlxSprite;
    var galleryByText:FlxText;
    var shader: FlxRuntimeShader;
    
    // Customize the image path here
    var imagePath:String = "menus/gallery/";

    override public function create():Void
    {   
        shader = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("water")));
        shader.setFloat("iTime", 0);

        FlxG.sound.playMusic(Paths.music('menus/creditsMenu'));

        var background: FlxSprite = new FlxSprite(0, 0);
        background.makeGraphic(1280, 720, 0xFF0020B1);
        background.shader = shader;
        add(background);

        var jsonData:String = Paths.getTextFromFile("data/gallery.json");
        var imageData:Array<ImageData> = haxe.Json.parse(jsonData);

        imagePaths = [];
        imageDescriptions = [];
        imageTitle = [];
        linkOpen = [];
        
        for (data in imageData) {
            imagePaths.push(data.path);
            imageDescriptions.push(data.description);
            imageTitle.push(data.title);
            linkOpen.push(data.link);
        }
    
        itemGroup = new FlxTypedGroup<GalleryImage>();
    
        for (i in 0...imagePaths.length) {
            var newItem = new GalleryImage();
            newItem.loadGraphic(Paths.image(imagePath + imagePaths[i]));
            newItem.screenCenter();
            newItem.ID = i;
            itemGroup.add(newItem);
        }
    
        add(itemGroup);
    
        descriptionText = new FlxText(50, -100, FlxG.width - 100, imageDescriptions[currentIndex]);
        descriptionText.setFormat("vcr.ttf", 25, 0xffffff, "center");
        descriptionText.screenCenter();
        descriptionText.y += 275;
        descriptionText.setFormat(Paths.font("vcr.ttf"), 32);
        add(descriptionText);
    
        titleText = new FlxText(50, 50, FlxG.width - 100, imageTitle[currentIndex]);
        titleText.screenCenter(X);
        titleText.setFormat(null, 40, 0xffffff, "center");
        titleText.setFormat(Paths.font("vcr.ttf"), 32);
        add(titleText);
    
        backspace = new FlxSprite(0, 612);
        backspace.frames = Paths.getSparrowAtlas('menus/gallery/ui/backspace');
        backspace.animation.addByPrefix('backspace to exit white0', "backspace to exit white0", 24);
        backspace.animation.play('backspace to exit white0');
        backspace.updateHitbox();
        add(backspace);
    
        galleryByText = new FlxText(FlxG.width - 200, FlxG.height - 30, 200, "Gallery by SquidBowl");
        galleryByText.setFormat("vcr.ttf", 18, 0xffffff, "center");
        galleryByText.screenCenter(X);
        add(galleryByText);

        persistentUpdate = true;
        changeSelection();
    
        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        shader.setFloat("iTime", shader.getFloat("iTime") + elapsed);

        if ((controls.UI_LEFT_P || controls.UI_RIGHT_P) && allowInputs) {
            changeSelection(controls.UI_LEFT_P ? -1 : 1);
            FlxG.sound.play(Paths.sound("scrollMenu"));
        }
    
        if (controls.BACK && allowInputs)
        {
            allowInputs = false;
            FlxG.sound.play(Paths.sound('cancelMenu'));
            MusicBeatState.switchState(new MainMenuState());
            backspace.animation.addByPrefix('backspace to exit', "backspace to exit", 12);
            backspace.animation.play('backspace to exit');
            FlxG.sound.playMusic(Paths.music('mainmenu'));
        }
        /*
        if (controls.ACCEPT && allowInputs)
            CoolUtil.browserLoad(linkOpen[currentIndex]);
        */
    }
    
    private function changeSelection(i:Int = 0)
    {
        currentIndex = FlxMath.wrap(currentIndex + i, 0, imageTitle.length - 1);
    
        descriptionText.text = imageDescriptions[currentIndex];
        titleText.text = imageTitle[currentIndex]; 

        var change = 0;
        for (item in itemGroup) {
            item.posX = change++ - currentIndex;
            item.alpha = (item.ID == currentIndex) ? 1 : 0.6;
        }
    }
}

class GalleryImage extends FlxSprite {
    public var lerpSpeed:Float = 6;
    public var posX:Float = 0;
    
    override function update(elapsed:Float) {
        super.update(elapsed);
        x = FlxMath.lerp(x, (FlxG.width - width) / 2 + posX * 760, boundTo(elapsed * lerpSpeed, 0, 1));
    }
}

function boundTo(value:Float, min:Float, max:Float):Float {
    var newValue:Float = value;
    if(newValue < min) newValue = min;
    else if(newValue > max) newValue = max;
    return newValue;
}

typedef ImageData = {
    path:String,
    description:String,
    title:String,
    link:String
}
