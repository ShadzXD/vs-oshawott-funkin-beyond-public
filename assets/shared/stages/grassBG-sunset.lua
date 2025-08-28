function onCreate()
	makeLuaSprite('stage', 'backgrounds/forest/grassBG-sunset', -140, 360);
	addLuaSprite('stage', false);


end

function onCreatePost()
	doTweenColor('dad', 'dad', '#ffb152', 0.001, 'linear')
	doTweenColor('bf', 'boyfriend', '#ffb152', 0.001, 'linear')
	doTweenColor('gf', 'gf', '#ffb152', 0.001, 'linear')

end