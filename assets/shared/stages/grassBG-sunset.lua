function onCreate()
	makeLuaSprite('stage', 'backgrounds/forest/grassBG-sunset', -140, 360);
	addLuaSprite('stage', false);


end

function onCreatePost()
	doTweenColor('dad', 'dad', '0xffb46a', 0.001, 'linear')
	doTweenColor('bf', 'boyfriend', '0xffb46a', 0.001, 'linear')
	doTweenColor('gf', 'gf', '0xffb46a', 0.001, 'linear')
end