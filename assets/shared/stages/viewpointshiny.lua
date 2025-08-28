function onCreate()
makeLuaSprite('viewnight', 'backgrounds/viewpoint/viewnight', 200, -100);
setScrollFactor('viewnight', 1, 1);
scaleObject('viewnight', 1, 1)
addLuaSprite('viewnight', false);

makeLuaSprite('DSPink', 'backgrounds/viewpoint/DSPink', -150, -250);
scaleObject('DSPink', 1.3, 1.3);
setObjectCamera('DSPink', 'Game')
addLuaSprite('DSPink', true);
end

function onCreatePost()
	doTweenColor('dad', 'dad', '#8385c2', 0.001, 'linear')
	doTweenColor('bf', 'boyfriend', '#8385c2', 0.001, 'linear')
	doTweenColor('gf', 'gf', '#e39554', 0.001, 'linear')
    triggerEvent('Camera Follow Pos', 1100,420)

end