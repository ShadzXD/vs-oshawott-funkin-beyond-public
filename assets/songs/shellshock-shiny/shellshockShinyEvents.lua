function onCreate()
    addCharacterToList('bf-back-shiny', 'boyfriend')
    addCharacterToList('FrontOshawottshiny', 'dad')
end
function onStepHit()
    if curStep == 895 then
        makeLuaSprite('Bg', 'backgrounds/battle/Bg', -250, -85);
        addLuaSprite('Bg', false);
        scaleObject('Bg',1.7,1.7)

        makeLuaSprite('Ground', 'backgrounds/battle/Ground', -250, -85);
        addLuaSprite('Ground', false);
        scaleObject('Ground',1.7,1.7)

        setProperty('defaultCamZoom',0.4)
        triggerEvent('Camera Follow Pos',1500,850);
        triggerEvent('Change Character','BF','bf-back-shiny')
        triggerEvent('Change Character','dad','FrontOshawottshiny')
        setProperty('gf.visible', false)
        setProperty('overlay.visible', false)

        setCharacterX('boyfriend',500)
        setCharacterY('boyfriend',1000)
        setCharacterX('dad',1090)
        setCharacterY('dad',430)
        
        noteTweenX("x5", 4, 92, 1, "quartInOut");
        noteTweenAngle("r5", 4, 360, 1, "quartInOut");
        noteTweenX("x6", 5, 203, 1, "quartInOut");
        noteTweenAngle("r6", 5, 360, 1, "quartInOut");
        noteTweenX("x7", 6, 314, 1, "quartInOut");
        noteTweenAngle("r7", 6, 360, 1, "quartInOut");
        noteTweenX("x8", 7, 425, 1, "quartInOut");
        noteTweenAngle("r8", 7, 360, 1, "quartInOut");
        
        noteTweenX("x11", 0, -1000, 0.2, "quartInOut");
        noteTweenAngle("r11", 0, 360, 0.2, "quartInOut");
        noteTweenX("x21", 1, -1000, 0.2, "quartInOut");
        noteTweenAngle("r21", 1, 360, 0.2, "quartInOut");
        noteTweenX("x31", 2, -1000, 0.2, "quartInOut");
        noteTweenAngle("r31", 2, 360, 0.2, "quartInOut");
        noteTweenX("x41", 3, -1000, 0.2, "quartInOut");
        noteTweenAngle("r41", 3, 360, 0.2, "quartInOut"); --TF IS R41??????
        
        makeLuaSprite('flash', '', -500, -500);
        makeGraphic('flash',1280,720,'000000')
        addLuaSprite('flash', true);
        setLuaSpriteScrollFactor('flash',0,0)
        setProperty('flash.scale.x',5)
        setProperty('flash.scale.y',5)
        setProperty('flash.alpha',0)
        setProperty('flash.alpha',1)
        doTweenAlpha('flTw','flash',0,0.5,'linear')
    end
    if curStep == 1408 then
        setCharacterX('boyfriend',1300)
        setCharacterY('boyfriend',750)
        setCharacterX('dad',430)
        setCharacterY('dad',750)
        setProperty('dad.scale.x', 1)
        setProperty('dad.scale.y', 1)
        triggerEvent('Change Character','BF','shinybf')
        triggerEvent('Change Character','dad','oshawottshiny')
        setProperty('gf.visible', true)
        setProperty('overlay.visible', true)

        setProperty('defaultCamZoom',0.75)
        removeLuaSprite('Bg', true)
        removeLuaSprite('Ground', true)
        triggerEvent('Camera Follow Pos',1100,1200);
        
        noteTweenX("backx5", 4, 740, 1, "quartInOut");
        noteTweenAngle("backr5", 4, 360, 1, "quartInOut");
        noteTweenX("backx6", 5, 852,1, "quartInOut");
        noteTweenAngle("backr6", 5, 360, 1, "quartInOut");
        noteTweenX("backx7", 6, 963, 1, "quartInOut");
        noteTweenAngle("backr7", 6, 360, 1, "quartInOut");
        noteTweenX("backx8", 7, 1075, 1, "quartInOut");
        noteTweenAngle("backr8", 7, 360, 1, "quartInOut");
        
        noteTweenX("backx1", 0, 2000, 0.2, "quartInOut");
        noteTweenAngle("backr1", 0, 360, 0.2, "quartInOut");
        noteTweenX("backx2", 1, 2000, 0.2, "quartInOut");
        noteTweenAngle("backr2", 1, 360, 0.2, "quartInOut");
        noteTweenX("backx3", 2, 2000, 0.2, "quartInOut");
        noteTweenAngle("backr3", 2, 360, 0.2, "quartInOut");
        noteTweenX("backx4", 3, 2000, 0.2, "quartInOut");
        noteTweenAngle("backr4", 3, 360, 0.2, "quartInOut");
        
        makeLuaSprite('flash2', '', -500, -500);
        makeGraphic('flash2',1280,720,'000000')
        addLuaSprite('flash2', true);
        setLuaSpriteScrollFactor('flash2',0,0)
        setProperty('flash2.scale.x',5)
        setProperty('flash2.scale.y',5)
        setProperty('flash2.alpha',0)
        setProperty('flash2.alpha',1)
        doTweenAlpha('flTw2','flash2',0,2,'linear')
    end


end