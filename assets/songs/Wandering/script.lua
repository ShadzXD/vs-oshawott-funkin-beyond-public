local allowCountdown = false

function onStartCountdown()
if not allowCountdown and isStoryMode then -- Block the first countdown
startVideo('Cutscene1'); -- your Video's name | video (must be 1280x720) paste into "videos" folder 
allowCountdown = true;
return Function_Stop;	
end
return Function_Continue;
end