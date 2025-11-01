function onCreate()
    makeLuaSprite('realblack','realblack',-2000,-500)
    addLuaSprite('realblack',true)
    setLuaSpriteScrollFactor('realblack', 0.5, 0.8);
    scaleObject('realblack', 30, 30);
    doTweenAlpha('realblack.alpha', 'realblack', 0, 0.001, 'linear');
end

function onEvent(name, value1, value2)
    if name == "TurnOffLights" then
        setObjectCamera("realblack", 'other')
        doTweenAlpha('realblack.alpha', 'realblack', value1, value2, 'linear');
    end
end