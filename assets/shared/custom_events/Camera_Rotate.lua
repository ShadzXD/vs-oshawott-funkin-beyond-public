local rotCam = false
local rotCamInd = 0
local rotCamSpd = 0
local rotCamRange = 0

function onEvent(name, value1, value2)
	if name == "Camera Rotate" or name == "Camera_Rotate" then
		rotCamSpd = value1
		rotCamRange = value2
		if rotCam and rotCamSpd == 0 then
			debugPrint('jj')
			rotCam = false
		else
			rotCam = true
		end
	end
end
		

function onUpdate()
	if rotCam then
		rotCamInd = rotCamInd + 1
		setProperty('camGame.angle',  math.sin(rotCamInd / 100 * rotCamSpd) * rotCamRange)
		--setProperty('camHUD.angle',  math.sin(rotCamInd / 100 * rotCamSpd) * -rotCamRange) Rotate the HUD in the opposite direction of the Game Cam
	else
		rotCamRange = 0
		rotCamInd = 0
	end
end