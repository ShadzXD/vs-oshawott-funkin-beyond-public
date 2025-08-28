function onUpdate(elapsed)    
    songPos = getSongPosition()

    local currentBeat = (songPos/5000)*(curBpm/60)

    doTweenY('opponentmove', 'dad', 200 - -30*math.sin((currentBeat+12*12)*math.pi), 0.0001)


end