function onCreate()
    if boyfriendName == 'pico-player' then
        setPropertyFromGameOver('characterName', 'pico-explosion-dead')
        setPropertyFromGameOver('deathSoundName', 'gameOverStart-pico-explode')
        --addCharacterToList('pico-explosion-dead', 'boyfriend') precaching isnt good with
    end
end

function setPropertyFromGameOver(property, value)
    if getPropertyFromClass('substates.GameOverSubstate', property) ~= nil then
        setPropertyFromClass('substates.GameOverSubstate', property, value)
    else
        setPropertyFromClass('substates.GameOverSubstate', 'instance.'..property, value)
    end
end