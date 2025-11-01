function onEvent(name, value1, value2)
	if name == 'void' then
		 makeLuaSprite('v', 'voidlol', 0, 0);
	     screenCenter('v', 'xy')
	     addLuaSprite('v', 'false' );
		 scaleObject('v', 10, 10)
		 setObjectCamera('v', 'hud');
		 setProperty('v.alpha', false);
		
		duration = tonumber(value1);
		if duration < 0 then
			duration = 0;
		end
		
		targetAlpha = tonumber(value2);
		if duration == 0 then
			setProperty('v.alpha', targetAlpha);
		else
			doTweenAlpha('v','v',targetAlpha , duration, 'linear')
		end
		
	  
	
	end
end