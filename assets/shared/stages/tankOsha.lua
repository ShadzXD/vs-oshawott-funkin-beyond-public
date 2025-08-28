local path = 'backgrounds/tankOsha/'
local x = -733
local y = -700
function onCreate()
	makeLuaSprite('sky', path .. 'oshawugh_sky', x, y)

	makeAnimatedLuaSprite('clouds','backgrounds/tankOsha/oshawugh_clouds', x, y)
	addAnimationByPrefix('clouds', 'clouds', 'clouds loop')
	setScrollFactor('clouds', 0.5, 0.5)

	makeLuaSprite('mountains', path .. 'oshawugh_mountain', x, y)
	setProperty('mountains.alpha', 0.5)
	setScrollFactor('mountains', 0.7, 0.7)

	makeLuaSprite('backHills', path .. 'oshawugh_back_hills', x, y)
	setScrollFactor('backHills', 0.8, 0.8)

	makeAnimatedLuaSprite('oshawottLookout', path .. 'oshawott_lookout', x + 100, y + 100)
	addAnimationByPrefix('oshawottLookout', 'lookout', 'lookoutawott', 24, false)
	setScrollFactor('oshawottLookout', 0.8, 0.8)

	makeAnimatedLuaSprite('bgBumpers', path .. 'oshawugh_bg_bumpers', x + 500, y + 700)
	addAnimationByPrefix('bgBumpers', 'idle', 'backbumpers', 24, false)
	setScrollFactor('bgBumpers', 0.8, 0.8)

	makeLuaSprite('frontHills', path .. 'oshawugh_front_hills', x, y)

	makeAnimatedLuaSprite('foreground', path .. 'oshawugh_foreground', x + 100, y + 1200)
	addAnimationByPrefix('foreground', 'bop', 'foreground bumpers', 24, false)
	setScrollFactor('foreground', 1.2, 1.2)

	makeLuaSprite('overlay', path .. 'oshawugh_overlay', x, y)
	setBlendMode('overlay', 'MULTIPLY')

	addLuaSprite('overlay', true)
	addLuaSprite('sky')
	addLuaSprite('clouds')
	addLuaSprite('mountains')
	addLuaSprite('backHills')
	addLuaSprite('oshawottLookout')
	addLuaSprite('bgBumpers')
	addLuaSprite('frontHills')
	addLuaSprite('foreground', true)
end

function onCountdownTick()
	playAnim('oshawottLookout', 'lookout', true)
	playAnim('bgBumpers', 'idle', true)
	playAnim('foreground', 'bop', true)
end

function onBeatHit()
	playAnim('oshawottLookout', 'lookout', true)
	playAnim('bgBumpers', 'idle', true)
	playAnim('foreground', 'bop', true)
end

function onCreatePost()
    setProperty('camZooming', true)
end

function onMoveCamera(character)
    if character == 'boyfriend' then
        setProperty('defaultCamZoom', 0.65)
    elseif character == 'dad' then
        setProperty('defaultCamZoom', 0.5)
    end
end
