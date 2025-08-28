function onCreate()
    if boyfriendName == 'osha_clash' then
        setPropertyFromGameOver('characterName', 'osha-dead')
        setPropertyFromGameOver('deathSoundName', 'fnf_loss_sfx-osha')
        addCharacterToList('osha-dead', 'boyfriend')
    end
end

function setPropertyFromGameOver(property, value)
    if getPropertyFromClass('substates.GameOverSubstate', property) ~= nil then
        setPropertyFromClass('substates.GameOverSubstate', property, value)
    else
        setPropertyFromClass('substates.GameOverSubstate', 'instance.'..property, value)
    end
end