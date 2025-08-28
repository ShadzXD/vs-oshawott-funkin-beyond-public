function onCreate()
	makeLuaSprite('spooky back trees', 'backgrounds/stumped/spooky back trees', -800, -300);
	setScrollFactor('spooky back trees', 0.9, 0.9);
	scaleObject('spooky back trees', 1, 1);

        makeLuaSprite('spooky grass', 'backgrounds/stumped/spooky grass', -600, -300);
	setScrollFactor('spooky grass', 1, 1);
	
		makeLuaSprite('spooky stump', 'backgrounds/stumped/spooky stump', -750, -335);
		setScrollFactor('spooky stump', 1, 1);
		scaleObject('spooky stump', 1, 1);
		
		makeLuaSprite('top spooky trees', 'backgrounds/stumped/top spooky trees', -750, -550);
		setScrollFactor('top spooky trees', 1.2, 1.2);
		scaleObject('top spooky trees', 1.2, 1.2);

		makeLuaSprite('spooky leafs', 'backgrounds/stumped/spooky leafs', -600, -430);
		setScrollFactor('spooky leafs', 1.1, 1.1);
		scaleObject('spooky leafs', 1.1, 1.1);

                makeLuaSprite('spooky sky', 'backgrounds/stumped/spooky sky', -800, -600);
		setScrollFactor('spooky sky', 1, 1);
		scaleObject('spooky sky', 1.2, 1.2);

                makeLuaSprite('spooky effect', 'backgrounds/stumped/spooky effect', -600, -300);
		setScrollFactor('spooky effect', 1, 1);
		scaleObject('spooky effect', 1, 1);
                
                makeAnimatedLuaSprite('rotom dex', 'backgrounds/stumped/rotom dex', 550, 300);
                addAnimationByPrefix('rotom dex','dance','idle', 24, true);
		setScrollFactor('rotom dex', 1, 1);
		scaleObject('rotom dex', 1, 1);

        addLuaSprite('spooky sky', false);
        addLuaSprite('spooky back trees', false);
	addLuaSprite('spooky grass', false);
	addLuaSprite('spooky stump', false);
        addLuaSprite('rotom dex', false);
	addLuaSprite('top spooky trees', true);
        addLuaSprite('spooky leafs', true);
	addLuaSprite('spooky effect', true);

end

function onSectionHit()
	addAnimationByPrefix('rotom dex', 'dance', 'idle', 23, true)
	objectPlayAnimation('rotom dex','dance',false)
end