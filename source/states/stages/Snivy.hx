package states.stages;

import shaders.DropShadowShader;
class Snivy extends BaseStage
{
	//this code is gonna make me kill myself
	static var fileLocation:String = 'backgrounds/snivybg/';
	var bfShader:DropShadowShader;
	var dadShader:DropShadowShader;

	var pansear:BGSprite;
	var swadloon:BGSprite;
	var pansage:BGSprite;
	var swoobat:BGSprite;
	var panpour:BGSprite;
	var celebi:BGSprite;
	var noibatbody:BGSprite;
	var noibathead:BGSprite;
	var liligant:BGSprite;
	var whimsicott1:BGSprite;
	var whimsicott2:BGSprite;
	var whimsicott3:BGSprite;
	var cottone:BGSprite;
	var petil:BGSprite;
	var sewaddle1:BGSprite;
	var sewaddle2:BGSprite;
	var sewaddle3:BGSprite;

	var frontboppers:FlxTypedGroup<BGSprite>;

	override function create()
	{
		var sky:BGSprite = new BGSprite(fileLocation + 'Sky', -600, -800, 0.3,0.3);
		add(sky);
		
		var backTrees:BGSprite = new BGSprite(fileLocation + 'VeryfarTrees', -600, -800, 0.5,0.5);
		add(backTrees);

		whimsicott3 = new BGSprite(fileLocation + 'Whimsicott3' , 30, -150, 0.65, 0.65, ['Whimsicott3 instância']);
		whimsicott3.updateHitbox();
		add(whimsicott3);

		whimsicott2 = new BGSprite(fileLocation + 'Whimsicott2' , -200, -150, 0.65, 0.65, ['Whimsicott2 instância']);
		whimsicott2.updateHitbox();
		add(whimsicott2);

		var backerBushes:BGSprite = new BGSprite(fileLocation + 'BackBACKBushes', -500, -180, 0.7,0.7);
		add(backerBushes);
   
		whimsicott1 = new BGSprite(fileLocation + 'Whimsicott1' , 0, 60, 0.85, 0.85, ['Whimsicott1 instância']);
		whimsicott1.updateHitbox();
		add(whimsicott1);

		var backBushes:BGSprite = new BGSprite(fileLocation + 'BackBushes', -600, -60, 0.9,0.9);
		add(backBushes);

		var treeLeavesBack:BGSprite = new BGSprite(fileLocation + 'TreeLeavesBack', -450, -700, 0.95, 0.95);
		add(treeLeavesBack);

		swoobat = new BGSprite(fileLocation + 'Swoobat' , 1674, -170, 1, 1, ['Swoobat instância']);
		swoobat.updateHitbox();
		add(swoobat);

		noibathead = new BGSprite(fileLocation + 'Noibat-Head' , 2220, -170, 1, 1, ['Noibat-Head instância']);
		noibathead.updateHitbox();
		add(noibathead);

		liligant = new BGSprite(fileLocation + 'Liligant' , 1030, -100, 0.95, 0.96, ['Liligant instância']);
		liligant.updateHitbox();
		add(liligant);	

		var treeTrunks:BGSprite = new BGSprite(fileLocation + 'TreeTrunks', -450, -800, 1, 1);
		add(treeTrunks);

		panpour = new BGSprite(fileLocation + 'Panpour' , 510, 10, 1, 1, ['Panpour instância']);
		panpour.updateHitbox();
		add(panpour);

		noibatbody = new BGSprite(fileLocation + 'Noibat-Body' , noibathead.x - 5, noibathead.y + 160, 1, 1, ['Noibat-Body instância']);
		noibatbody.updateHitbox();
		add(noibatbody);	

		var treeLeaves:BGSprite = new BGSprite(fileLocation + 'TreeLeavesFront', treeTrunks.x, treeTrunks.y + 150, 1, 1);
		add(treeLeaves);

		var floor:BGSprite = new BGSprite(fileLocation + 'Floor', -600, 350, 1, 1);
		add(floor);

		pansage = new BGSprite(fileLocation + 'Pansage' , 540, -380, 1, 1, ['Pansage instância']);
		pansage.updateHitbox();
		add(pansage);

		sewaddle1 = new BGSprite(fileLocation + 'Sewaddle1' , 1540, 160, 1, 1, ['Sewaddle1 instância']);
		sewaddle1.updateHitbox();
		add(sewaddle1);

	 	sewaddle2 = new BGSprite(fileLocation + 'Sewaddle2' , 1700, 130, 1, 1, ['Sewaddle2 instância']);
		sewaddle2.updateHitbox();
		add(sewaddle2);

		sewaddle3 = new BGSprite(fileLocation + 'Sewaddle3' , 1800, 220, 1, 1, ['Sewaddle3 instância']);
		sewaddle3.updateHitbox();
		add(sewaddle3);

		var bushes:BGSprite = new BGSprite(fileLocation + 'Bushes', -400, 80, 1, 1);
		add(bushes);

        frontboppers = new FlxTypedGroup<BGSprite>();
        add(frontboppers);
		
		celebi = new BGSprite(fileLocation + 'Celebi' , 970, -300, 1, 1, ['Celebi instância']);
		celebi.updateHitbox();
		frontboppers.add(celebi);

		swadloon = new BGSprite(fileLocation + 'Swadloon' , 1604, 350, 1, 1, ['Swadloon instância']);
		swadloon.updateHitbox();
		frontboppers.add(swadloon);
	}
	
	override function createPost()
	{
		var frontbushes:BGSprite = new BGSprite(fileLocation + 'FrontBushes', -310, 380, 1.15,  1.15);
		add(frontbushes);
	
		cottone = new BGSprite(fileLocation + 'Cottonee' , 0, 550, 1.15, 1.15, ['Cottonee instância']);
		cottone.updateHitbox();
		add(cottone);
		petil = new BGSprite(fileLocation + 'Petilil' , 2104, 550, 1.15, 1.15, ['Petilil instância']);
		petil.updateHitbox();
		add(petil);
		pansear = new BGSprite(fileLocation + 'Pansear' , 704, -250, 1, 1, ['Pansear instância']);
		pansear.updateHitbox();
		frontboppers.add(pansear);
		if(ClientPrefs.data.shaders){
		bfShader = new DropShadowShader();
		bfShader.setAdjustColor(-10, 0, 0, 0);
    	bfShader.color = 0xfffffd6c;
		bfShader.angle = 190;
		bfShader.attachedSprite = boyfriend;
		boyfriend.shader = bfShader;
		boyfriend.animation.callback = function(name:String, frameNumber:Int, frameIndex:Int){
			bfShader.updateFrameInfo(boyfriend.frame);
		}
	

		dadShader = new DropShadowShader();
		dadShader.setAdjustColor(-10, 0, 0, 0);
    	dadShader.color = 0xfffffd6c;
		dadShader.angle = 140;
		dadShader.attachedSprite = dad;
		dad.shader = dadShader;
		dad.animation.callback = function(name:String, frameNumber:Int, frameIndex:Int){
			dadShader.updateFrameInfo(dad.frame);
		}
		}

	}
	override function countdownTick(count:Countdown, num:Int) everyoneDance();
	override function beatHit() everyoneDance();
	
	function everyoneDance()
	{
		for(obj in frontboppers) obj.dance(false);
		pansage.dance(false);
		swoobat.dance(false);
		noibathead.dance(false);
		noibatbody.dance(false);
		liligant.dance(false);
		panpour.dance(false);
		cottone.dance(false);
		petil.dance(false);
		sewaddle3.dance(false);
		sewaddle2.dance(false);
		sewaddle1.dance(false);
		whimsicott1.dance(false);
		whimsicott2.dance(false);
		whimsicott3.dance(false);

	}
}