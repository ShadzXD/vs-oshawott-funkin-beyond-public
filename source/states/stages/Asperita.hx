package states.stages;

import shaders.AdjustColorShader;
import objects.StrumNote;
class Asperita extends BaseStage
{
    var characterShaders:Bool = true;

	var bg:BGSprite;
    var stageBack:BGSprite;
    var brightLightSmall:BGSprite;
    var stageFront:BGSprite;
    var server:BGSprite;
    var light:BGSprite;
    var orangeLight:BGSprite;
    var lightgreen:BGSprite;
    var lightred:BGSprite;
    var lightAbove:BGSprite;
    var viewPoint:BGSprite;
    var DS:BGSprite;
	//var rain:Rain;
    var colorShaderBF = new AdjustColorShader();
    var colorShaderDad = new AdjustColorShader();
    var colorShaderGF = new AdjustColorShader();
    var scoreTextBaseGame:FlxText;
    var addBaseGameUI:Bool = true;
	override function create()
	{
     
        stageBack = new BGSprite('backgrounds/backstage/backDark', 729, -170, 1, 1);
		stageBack.scale.set(1, 1);
		stageBack.alpha = 1;

        brightLightSmall = new BGSprite('backgrounds/backstage/brightLightSmall', 967, -103, 1.2, 1.2);
		brightLightSmall.scale.set(1, 1);
		brightLightSmall.alpha = 1;

        var audience = new FlxSprite(560, 290);
        audience.frames = Paths.getSparrowAtlas('backgrounds/backstage/crowd');
        audience.animation.addByPrefix('idle', 'Symbol 2 instance 1', 12, true);
        audience.scrollFactor.set(0.8, 0.8);
        audience.scale.set(1, 1);
        audience.animation.play('idle');
        //audience.updateHitbox();

        stageFront = new BGSprite('backgrounds/backstage/bg', -603, -187, 1, 1);
		stageFront.scale.set(1, 1);
		stageFront.alpha = 1;

        server = new BGSprite('backgrounds/backstage/server', -361, 205, 1, 1);
		server.scale.set(1, 1);
        //server.updateHitbox();
		server.alpha = 1;

        light = new BGSprite('backgrounds/backstage/lights', -601, -147, 1.2, 1.2);
		light.scale.set(1, 1);
        //light.updateHitbox();
		light.alpha = 1;

        orangeLight = new BGSprite('backgrounds/backstage/orangeLight', 189, -195, 1, 1);
		orangeLight.scale.set(1, 1);
        //orangeLight.updateHitbox();
		orangeLight.alpha = 1;

        lightgreen = new BGSprite('backgrounds/backstage/lightgreen', -171, 242, 1, 1);
		lightgreen.scale.set(1, 1);
        //lightgreen.updateHitbox();
		lightgreen.alpha = 1;

        lightred = new BGSprite('backgrounds/backstage/lightred', -101, 560, 1, 1);
		lightred.scale.set(1, 1);
        //lightred.updateHitbox();
		lightred.alpha = 1;

        lightAbove = new BGSprite('backgrounds/backstage/lightAbove', 804, -117, 1, 1);
		lightAbove.scale.set(1, 1);
        //lightAbove.updateHitbox();
		lightAbove.alpha = 1;

        viewPoint = new BGSprite('backgrounds/viewpoint/view', 0, -300, 1, 1);
        viewPoint.scale.set(1.5, 1.5);
        viewPoint.alpha = 0;

        insert(0, stageBack);
        insert(10, brightLightSmall);
        //insert(5, audience);
        insert(20, stageFront);
        insert(30, server);
        insert(4000, light);
        insert(80, orangeLight);
        insert(40, lightgreen);
        insert(40, lightred);
        insert(4500, lightAbove); 
        add(viewPoint);
	}

    override function createPost() {
        DS = new BGSprite('backgrounds/dsUI', -150, -250, 1, 1);
        DS.scale.set(1.3, 1.3);
        DS.alpha = 0;
        add(DS);
        DS.cameras = [camGame];

        super.createPost();

        if(!ClientPrefs.data.lowQuality) {
            game.boyfriend.shader = colorShaderBF;
            game.dad.shader = colorShaderDad;
            game.gf.shader = colorShaderGF;

            colorShaderBF.brightness.value = [-23];
            colorShaderBF.hue.value = [12];
            colorShaderBF.contrast.value = [7];
		    colorShaderBF.saturation.value = [0];

            colorShaderGF.brightness.value = [-30];
            colorShaderGF.hue.value = [-9];
            colorShaderGF.contrast.value = [-4];
		    colorShaderGF.saturation.value = [0];

            colorShaderDad.brightness.value = [-33];
            colorShaderDad.hue.value = [-32];
            colorShaderDad.contrast.value = [-23];
		    colorShaderDad.saturation.value = [0];
        }

        game.strumLineNotes.forEachAlive(function(note:StrumNote) {
			note.antialiasing = true;
		});
	
    }
    override function stepHit()
	{
        super.stepHit();

		if (curStep == 304)
        {
            defaultCamZoom = 0.6;

            boyfriend.x += 200;
            boyfriend.y -= 70;

            dad.x += 150;
            dad.y -= 110;

            stageBack.alpha = 0;
            brightLightSmall.alpha = 0;
            stageFront.alpha = 0;
            server.alpha = 0;
            light.alpha = 0;
            orangeLight.alpha = 0;
            lightgreen.alpha = 0;
            lightred.alpha = 0;
            lightAbove.alpha = 0;
            viewPoint.alpha = 1;
            DS.alpha = 1;

            game.boyfriend.shader = null;
            game.dad.shader = null;
            game.gf.shader = null;

            //combo class switch
            game.comboClass.hudType = 'OSHA'; 
            game.comboClass.loadStuff();

            //hud class switch
            //i dont know how to code
            game.switchUIType();
            game.set_health(1);

            game.changeNoteSkin('NOTE_assets');

        }
	}
}