function onCreate()
    makeLuaSprite('Shelf', 'backgrounds/shelf/Shelf', -1080, -910);
    setScrollFactor('Shelf', 1, 1);
    scaleObject('Shelf', 1.5, 1.5)
    addLuaSprite('Shelf', false);

    makeLuaSprite('Card', 'backgrounds/shelf/Card', 3013, -314);
    setScrollFactor('Card', 1, 1);
    scaleObject('Card', 1.5, 1.5)
    addLuaSprite('Card', false);

    makeLuaSprite('Pokepark', 'backgrounds/shelf/Pokepark', 970, -520);
    setScrollFactor('Pokepark', 1, 1);
    scaleObject('Pokepark', 1.5, 1.5)
    addLuaSprite('Pokepark', false);

    makeLuaSprite('Portrait', 'backgrounds/shelf/Portrait', 0, -470);
    setScrollFactor('Portrait', 1, 1);
    scaleObject('Portrait', 1.5, 1.5)
    addLuaSprite('Portrait', false);

     makeAnimatedLuaSprite('Wii', 'backgrounds/shelf/Wii', -700, 150)
        addAnimationByPrefix('Wii', 'dance', 'Idle', 12, true)
 	setScrollFactor('Wii', 1, 1);
	scaleObject('Wii', 2, 2);
        addLuaSprite('Wii', false);

 makeLuaSprite('gf_plush', 'backgrounds/shelf/gf_plush', 1167, 200);
    setScrollFactor('gf_plush', 1, 1);
    scaleObject('gf_plush', 1, 1)
    addLuaSprite('gf_plush', false);
        

    makeAnimatedLuaSprite('oshawott','backgrounds/shelf/oshawott',0, 605)addAnimationByPrefix('oshawott','dance','oshawott',24,true)
    objectPlayAnimation('oshawott','dance',false)
    setScrollFactor('oshawott', 1, 1);
    scaleObject('oshawott',0.4,0.4)
    setObjectCamera("oshawott", "hud")
    setProperty('oshawott.alpha', 1)
    addLuaSprite('oshawott', false);

    makeAnimatedLuaSprite('bgf','backgrounds/shelf/bf',950, 520)addAnimationByPrefix('bgf','dance','bf',24,true)
    objectPlayAnimation('bgf','dance',false)
    setScrollFactor('bgf', 1, 1);
    scaleObject('bgf',0.37,0.37)
    setObjectCamera("bgf", "hud")
    setProperty('bgf.alpha', 1)
    addLuaSprite('bgf', false);
end

function onSectionHit()
	addAnimationByPrefix('bgf', 'dance', 'bf', 24, true)
	objectPlayAnimation('bgf','dance',false)
	addAnimationByPrefix('oshawott', 'dance', 'oshawott', 24, true)
	objectPlayAnimation('oshawott','dance',false)
function onBeatHit()
	addAnimationByPrefix('Wii', 'dance', 'idle', 24, true)
	objectPlayAnimation('Wii','dance',false)
end
end