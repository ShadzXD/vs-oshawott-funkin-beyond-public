function onCreate()
	makeLuaText('st', '', 1000, screenWidth / 2, screenHeight * 0.69)
	setTextSize('st', 38)
	setTextAlignment('st', 'center')
	addLuaText('st')
	setObjectCamera('st', 'other')
	setTextBorder('st', 3, '000000');
	setProperty('st.alpha', 0);

end

function onUpdate(elapsed)
	screenCenter('st', 'x')
end

function onEvent(name, value1, value2)
	if name == "Subtitles" then
		cancelTimer('sub');
		cancelTween('ispoke');
		setTextString('st', value1)
		setProperty('st.alpha', 1);
		runTimer('sub', value2);
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'sub' then
		doTweenAlpha('ispoke', 'st', 0, 0.5, 'linear');
	end
end