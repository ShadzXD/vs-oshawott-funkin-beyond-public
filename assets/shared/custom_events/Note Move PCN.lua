local beatToggle = false
local noteMovement = false

local tweenDuration = 0.3
local movementAmount = 13.5

function onBeatHit()
    if noteMovement then
        if curBeat % 1 == 0 then
            if noteMovement == 'on 1' then
                if beatToggle then
                    noteTweenY('note4Up', 4, defaultPlayerStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note5Down', 5, defaultPlayerStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note6Up', 6, defaultPlayerStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note7Down', 7, defaultPlayerStrumY0 - movementAmount, tweenDuration, 'elasticOut')

                    noteTweenY('note0Up', 0, defaultOpponentStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note1Down', 1, defaultOpponentStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note2Up', 2, defaultOpponentStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note3Down', 3, defaultOpponentStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    beatToggle = false
                else
                    noteTweenY('note4Down', 4, defaultPlayerStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note5Up', 5, defaultPlayerStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note6Down', 6, defaultPlayerStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note7Up', 7, defaultPlayerStrumY0 + movementAmount, tweenDuration, 'elasticOut')

                    noteTweenY('note0Down', 0, defaultOpponentStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note1Up', 1, defaultOpponentStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note2Down', 2, defaultOpponentStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note3Up', 3, defaultOpponentStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    beatToggle = true
                end
            end
        end
        if curBeat % 2 == 0 then
            if noteMovement == 'on 2' then
                if beatToggle then
                    noteTweenY('note4Up', 4, defaultPlayerStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note5Down', 5, defaultPlayerStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note6Up', 6, defaultPlayerStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note7Down', 7, defaultPlayerStrumY0 - movementAmount, tweenDuration, 'elasticOut')

                    noteTweenY('note0Up', 0, defaultOpponentStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note1Down', 1, defaultOpponentStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note2Up', 2, defaultOpponentStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note3Down', 3, defaultOpponentStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    beatToggle = false
                else
                    noteTweenY('note4Down', 4, defaultPlayerStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note5Up', 5, defaultPlayerStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note6Down', 6, defaultPlayerStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note7Up', 7, defaultPlayerStrumY0 + movementAmount, tweenDuration, 'elasticOut')

                    noteTweenY('note0Down', 0, defaultOpponentStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note1Up', 1, defaultOpponentStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note2Down', 2, defaultOpponentStrumY0 - movementAmount, tweenDuration, 'elasticOut')
                    noteTweenY('note3Up', 3, defaultOpponentStrumY0 + movementAmount, tweenDuration, 'elasticOut')
                    beatToggle = true
                end
            end
        end
    end
    if noteMovement == 'off' then
        for i = 0, 7 do
            noteTweenY('notesBack' .. i, i, defaultPlayerStrumY0, 0.2, 'elasticOut')
        end
    end
end

function onEvent(name, value1, value2)
    if name == 'Note Move PCN' then
        if value1 == '1' then
            noteMovement = 'on 1'
        end
        if value1 == '2' then
            noteMovement = 'on 2'
        end
        if value1 == '0' then
            noteMovement = 'off'
        end
    end
end
