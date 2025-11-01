extraZoom = 0
function onEvent(eventName, value1, value2)
    if eventName == 'Extra Cam Zoom' then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') - extraZoom + tonumber(value1))
        extraZoom = tonumber(value1)
    end
end