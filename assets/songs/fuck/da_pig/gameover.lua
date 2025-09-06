function onGameOverStart()
	if boyfriendName == 'pico-player' then
		setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver-pico')
		setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd-pico')

		setPropertyFromClass('GameOverSubstate', 'characterName', 'pico-explosion-dead')
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'gameOverStart-pico-explode')
	
end
end