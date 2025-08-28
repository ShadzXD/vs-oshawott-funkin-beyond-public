--Created by RamenDominoes (Please credit if using this, thanks! <3)

HudAssets = {'healthBarBG','healthBar','scoreTxt','iconP1','iconP2','timeBar','timeBarBG','timeTxt'}
Index = 1

function onCreatePost()

    makeLuaSprite('UpperBarUnderLap', 'empty', -110, -350)
	makeGraphic('UpperBarUnderLap', 1500, 350, '000000')
	setObjectCamera('UpperBarUnderLap', 'HUD')
	addLuaSprite('UpperBarUnderLap', false)

    makeLuaSprite('LowerBarUnderLap', 'empty', -110, 720)
	makeGraphic('LowerBarUnderLap', 1500, 350, '000000')
	setObjectCamera('LowerBarUnderLap', 'HUD')
	addLuaSprite('LowerBarUnderLap', false)

    UpperBar = getProperty('UpperBarUnderLap.y')
	LowerBar = getProperty('LowerBarUnderLap.y')

    for Notes = 0,7 do 
        StrumY = getPropertyFromGroup('strumLineNotes', Notes, 'y')
    end
end


function onEvent(name, value1, value2)
	if name == 'Cinematics UnderLap' then
	
		Speed = tonumber(value1)
		Distance = tonumber(value2)

--ENTRANCES

		if Speed and Distance > 0 then

			doTweenY('UnderLap1', 'UpperBarUnderLap', UpperBar + Distance, Speed, 'QuadOut')
			doTweenY('UnderLap2', 'LowerBarUnderLap', LowerBar - Distance, Speed, 'QuadOut')

			for Tweens = 0,7 do 
				noteTweenY('MoveInUnderLap'..Tweens, Tweens, (StrumY + Distance) - 35, Speed, 'QuadOut')

				for Alphas = 1,8 do
					doTweenAlpha('AlphaUnderLap'..Alphas, HudAssets[Index], 0, Speed - 0.1)
					Index = Index + 1
						
					if Index > #HudAssets then
						Index = 1
					end
				end
			end
		end

		if downscroll and Speed and Distance > 0 then
		
			doTweenY('UnderLap1', 'UpperBarUnderLap', UpperBar + Distance, Speed, 'QuadOut')
			doTweenY('UnderLap2', 'LowerBarUnderLap', LowerBar - Distance, Speed, 'QuadOut')

				for Tweens = 0,7 do 
					noteTweenY('MoveInUnderLap'..Tweens, Tweens, (StrumY - Distance) + 35, Speed, 'QuadOut')
			
					for Alphas = 1,8 do
						doTweenAlpha('AlphaUnderLap'..Alphas, HudAssets[Index], 0, Speed - 0.1)
						Index = Index + 1
							
						if Index > #HudAssets then
							Index = 1
						
						end
					end
				end
			end

		if Distance <= 0 then
			
			doTweenY('UnderLap1', 'UpperBarUnderLap', UpperBar, Speed, 'QuadIn')
			doTweenY('UnderLap2', 'LowerBarUnderLap', LowerBar, Speed, 'QuadIn')

			for Tweens = 0,7 do 
				noteTweenY('MoveOutUnderLap'..Tweens, Tweens, StrumY , Speed, 'QuadIn')
			
				for Alphas = 1,8 do
					doTweenAlpha('AlphaUnderLap'..Alphas, HudAssets[Index], 1, Speed + 0.1)
					Index = Index + 1
							
					if Index > #HudAssets then
						Index = 1
						
					end
				end
			end
		end	
	end
end
