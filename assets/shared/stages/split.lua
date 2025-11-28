function onCreate()
makeLuaSprite('stage', 'backgrounds/drunkin/bg', -550, -230);
addLuaSprite('stage', false);

makeAnimatedLuaSprite("line", "backgrounds/drunkin/lines", 650, 30)
addAnimationByPrefix("line", "idle", "Line", 12, true)
playAnim("line", "idle", true)
addLuaSprite("line", true)
end
function onCreatePost()
setProperty('scoreTxt.font','vcr-og.ttf')
setProperty('timeTxt.font','vcr-og.ttf')
end