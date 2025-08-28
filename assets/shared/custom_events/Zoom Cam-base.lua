local debugMessages = false
luaDebugMode = false

local defaultZoom = 1
function onCreate()
	defaultZoom = getProperty("defaultCamZoom")
end

function onEvent(n, v1, v2)
	if n == "Zoom Cam-base" then
		local zoom = 1
		local dur = 1
		local speed = 4
		local ease = "CLASSIC"

		if v1 == "" then
			zoom = defaultZoom
		else
			zoom = v1
		end
		dur = stringTrim(stringSplit(v2, ",")[1])
		ease = stringTrim(stringSplit(v2, ",")[2])

		dur = dur:gsub(' ', '')
		ease = ease:gsub(' ', '')
		dur = tonumber(dur)
		if dur > 0 then
			speed = crochet/(1000*(4/dur))
		else
			ease = "INSTANT" -- just set the ease to instant and don't bother
		end

		cancelTween("camZoom")
		if ease == "INSTANT" then
			setProperty("camGame.zoom", zoom)
			setProperty("defaultCamZoom", zoom)
		else
			doTweenZoom('camZoom', 'camGame', zoom, speed, ease)
			setProperty("defaultCamZoom", zoom)
		end

		if debugMessages then
			debugPrint("ease: " .. ease, "00FF00")
			debugPrint("speed: crochet/(1000*" .. (4/dur) .. ")", "FF00FF")
			debugPrint("dur: " .. dur, "00FFFF")
			debugPrint("zoom: " .. zoom, "FFFF00")
			debugPrint("ZOOM EVENT:")
			debugPrint("--------------")
		end

	elseif n == "" then
		if v1 == "toggledebug" then
			debugMessages = not debugMessages
			luaDebugMode = not luaDebugMode
		end
	end
end