local easing = ""
function onEvent(name,value1,value2)
	if value2 == "" then easing = "linear" else
		easing = value2
	end
	if name == 'Hide Hud' then
		if value1 == '1' then
			doTweenAlpha('GUItween', 'camHUD', 0, 0.5, easing);
		end
	
		if value1 == '2' then
			doTweenAlpha('GUItween', 'camHUD', 1, 0.5, easing);
		end
	end
	end	