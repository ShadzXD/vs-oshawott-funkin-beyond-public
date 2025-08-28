function onCreate()
makeLuaSprite('viewpoint', 'backgrounds/viewpoint/view', 200, -100);
setScrollFactor('viewpoint', 1, 1);
scaleObject('viewpoint', 1, 1)
addLuaSprite('viewpoint', false);

makeLuaSprite('DS', 'dsUI', -150, -250);
scaleObject('DS', 1.3, 1.3);
setObjectCamera('DS', 'Game')
addLuaSprite('DS', true);
end
function onUpdate(elapsed)
triggerEvent('Camera Follow Pos', 1100,420)
end