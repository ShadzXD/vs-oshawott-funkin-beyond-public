function onCreate()
	makeLuaSprite('grassBG', 'backgrounds/forest/grassBG', -190, 360);
	addLuaSprite('grassBG', false);

        makeLuaSprite('overlay', 'backgrounds/forest/overlay', -190, 360);
	addLuaSprite('overlay', true);
	
	if songName == 'shellshock' or songName == 'Shellshock shiny' then 
		precacheImage('backgrounds/battle/Bg')
		precacheImage('backgrounds/battle/Ground')
	end

	if songName == 'Ocean Aggrivation' or songName == 'Ocean Aggrivation Shiny' then
		setProperty('skipCountdown',true)
	end
end
function onTweenCompleted(tag) --tags for note tweens
	if tag == "r41" then 
		noteTweenAlpha("x12", 0, 0, 0.1, "linear");
		noteTweenAlpha("x22", 1, 0, 0.1, "linear");
		noteTweenAlpha("x32", 2, 0, 0.1, "linear");
		noteTweenAlpha("x42", 3, 0, 0.1, "linear");
	end
	if tag == "x12" then
		noteTweenX("x13", 0, 2000, 0.1, "quartInOut");
		noteTweenX("x23", 1, 2000, 0.1, "quartInOut");
		noteTweenX("x33", 2, 2000, 0.1, "quartInOut");
		noteTweenX("x43", 3, 2000, 0.1, "quartInOut");
	end
	if tag == "x13" then
		noteTweenAlpha("x14", 0, 1, 0.1, "linear");
		noteTweenAlpha("x24", 1, 1, 0.1, "linear");
		noteTweenAlpha("x34", 2, 1, 0.1, "linear");
		noteTweenAlpha("x44", 3, 1, 0.1, "linear");
	end
	if tag == "x14" then
		noteTweenX("x15", 0, 740, 0.6, "quartInOut");
		noteTweenX("x25", 1, 852, 0.6, "quartInOut");
		noteTweenX("x35", 2, 963, 0.6, "quartInOut");
		noteTweenX("x45", 3, 1075, 0.6, "quartInOut");
		noteTweenAngle("r18", 0, 360, 0.6, "quartInOut");
		noteTweenAngle("r28", 1, 360, 0.6, "quartInOut");
		noteTweenAngle("r38", 2, 360, 0.6, "quartInOut");
		noteTweenAngle("r48", 3, 360, 0.6, "quartInOut");
	end
	
	
	if tag == "backr4" then
		noteTweenAlpha("x121", 0, 0, 0.1, "linear");
		noteTweenAlpha("x221", 1, 0, 0.1, "linear");
		noteTweenAlpha("x321", 2, 0, 0.1, "linear");
		noteTweenAlpha("x421", 3, 0, 0.1, "linear");
		triggerEvent('Camera Follow Pos','','');
	end
	if tag == "x121" then
		noteTweenX("x131", 0, -500, 0.1, "quartInOut");
		noteTweenX("x231", 1, -500, 0.1, "quartInOut");
		noteTweenX("x331", 2, -500, 0.1, "quartInOut");
		noteTweenX("x431", 3, -500, 0.1, "quartInOut");
	end
	if tag == "x131" then
		noteTweenAlpha("x141", 0, 1, 0.1, "linear");
		noteTweenAlpha("x241", 1, 1, 0.1, "linear");
		noteTweenAlpha("x341", 2, 1, 0.1, "linear");
		noteTweenAlpha("x441", 3, 1, 0.1, "linear");
	end
	if tag == "x441" then
		noteTweenX("x511", 0, 92, 0.6, "quartInOut");
		noteTweenAngle("r511", 0, 360, 0.6, "quartInOut");
		noteTweenX("x611", 1, 203, 0.6, "quartInOut");
		noteTweenAngle("r61", 1, 360, 0.6, "quartInOut");
		noteTweenX("x71", 2, 314, 0.6, "quartInOut");
		noteTweenAngle("r71", 2, 360, 0.6, "quartInOut");
		noteTweenX("x81", 3, 425, 0.6, "quartInOut");
		noteTweenAngle("r81", 3, 360, 0.6, "quartInOut");
	end
end
