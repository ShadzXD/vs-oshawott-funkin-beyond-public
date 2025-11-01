local hp = 0;
local drainMax = 2;
local stepCur = 0;
local myStep = 0;
function onEvent(name, value1, value2)
	if name == 'Health Drain' then
		stepCur = value1;
		drainMax = value2;
		myStep = curStep;
	end
end
function onUpdatePost()
	hp = getProperty('health');
	if curStep > myStep and hp > 0 + drainMax then
		myStep = myStep + stepCur;
		setProperty('health', hp - 0.046); -- You change how much it drains here
	end
end