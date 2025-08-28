
	function onCreatePost()

		if stringStartsWith(version, '0.7') then
			stage = getPropertyFromClass('states.PlayState', 'curStage')
		else
			stage = getPropertyFromClass('PlayState', 'curStage')
		end
	
		--black bg
		makeLuaSprite('black', 'black', getPropertyFromClass('flixel.FlxG', 'width') * -0.5, getPropertyFromClass('flixel.FlxG', 'height') * -0.5)
		makeGraphic('black', getPropertyFromClass('flixel.FlxG', 'width') * 2, getPropertyFromClass('flixel.FlxG', 'height') * 2, '000000')
		
		setScrollFactor('black', 0)
		setProperty('black.scale.x', 5)
		setProperty('black.scale.y', 5)
	
		if getProperty('gf.visible') == false then
			setObjectOrder('black', getObjectOrder('gfGroup'))
		elseif getProperty('dad.visible') == true then
			setObjectOrder('black', getObjectOrder('dadGroup'))
		else
			setObjectOrder('black', getObjectOrder('boyfriendGroup'))
		end
	
		addLuaSprite('black', false)
		setProperty('black.alpha', 0)

	end

function onEvent(name,value1,value2)
      if name == "backgroundfade" then
		


			if getProperty('black.alpha') == 0 then
				doTweenAlpha('black','black',1,value2,'linear')
			else

				setProperty('black.alpha', 1)

			end
			if getProperty('black.alpha') == 1 then

				doTweenAlpha('black','black',0,value2,'linear')


			end
	end
end