-- Event notes hooks
function onEvent(name, val1, val2)
	if name == 'Zoom Camera' then
		setProperty('defaultCamZoom', val1);
	end
end