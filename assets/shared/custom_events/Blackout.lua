local hasSpawned = false
function onEvent(name, value1, value2)
	if name == 'Blackout' and value1 == 'a' and hasSpawned == false then
		makeLuaSprite('whitebg', '', -500, -500)
		setScrollFactor('whitebg', 0, 0)
		makeGraphic('whitebg', screenWidth * 2, screenHeight * 2, '000000')
		addLuaSprite('whitebg', true)
		setProperty('whitebg.alpha', 0)
		setObjectCamera('whitebg', 'gameHud')
		doTweenAlpha('applebadxd69', 'whitebg', 1, value2, 'linear')
		hasSpawned = true
	end
	if name == 'Blackout' and value1 == 'a' and hasSpawned == true then
		doTweenAlpha('applebadxd69', 'whitebg', 1, value2, 'linear')
	end
	if name == 'Blackout' and value1 == 'b' then
		doTweenAlpha('applebadxd', 'whitebg', 0, value2, 'linear')

	end
end