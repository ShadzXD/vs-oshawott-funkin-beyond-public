local finishLength = 512 -- temporary
function onCreate()
    addHaxeLibrary('Note')
    addHaxeLibrary('EventNote','Note')
    addHaxeLibrary('SwagSong', 'Song')
    addHaxeLibrary('SwagSection', 'Section')
    addHaxeLibrary('Math')
    addHaxeLibrary('StrumNote')
    addHaxeLibrary('Std')
    addHaxeLibrary('Conductor')
    addHaxeLibrary('ClientPrefs')
    addHaxeLibrary('MusicBeatState')
    addHaxeLibrary('FlxMath', 'flixel.math')
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
end

function onSongStart()
    finishLength = songLength - 1000
end
function onUpdatePost(elapsed)
    if getSongPosition() > finishLength then
        reLOAD()
    end
end

function reLOAD()
    -- go back to zero 
    setPropertyFromClass('Conductor', 'songPosition', 0)
    -- fixes sound and instrumental
    setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
	setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))

    --reload everything [lag spike incoming]
    runHaxeCode([[
        game.sectionHit();
        game.stepHit();
        game.beatHit();
        game.lastBeatHit = -1;
        game.lastStepHit = -1;

        game.unspawnNotes = [];
        game.eventNotes = [];
        while(game.notes.length > 0) {
			var daNote = game.notes.members[0];
			daNote.active = false;
			daNote.visible = false;

			daNote.kill();
			game.notes.remove(daNote, true);
			daNote.destroy();
		}

        var keyCount = 4;
        var startingKeyCount = keyCount;
        for (event in PlayState.SONG.events)
        {
            for (i in 0...event[1].length)
			{
				var newEventNote = [event[0], event[1][i][0], event[1][i][1], event[1][i][2] ];
				var subEvent = {
					strumTime: newEventNote[0] + ClientPrefs.noteOffset,
					event: newEventNote[1],
					value1: newEventNote[2],
					value2: newEventNote[3]
				};
				game.eventNotes.push(subEvent);
			}
        }

        for (section in PlayState.SONG.notes) //reload dat shit
		{
			for (songNotes in section.sectionNotes)
			{
				var daStrumTime = songNotes[0];
                if (daStrumTime >= Conductor.songPosition) //only load notes after current song pos (not needed i just had this set up for something else before, shouldnt break anything)
                {
                    var actualNoteData = Std.int(songNotes[1] % keyCount);
                    var daNoteData = Std.int(songNotes[1] % startingKeyCount);

                    var gottaHitNote = section.mustHitSection;
    
                    if (songNotes[1] > keyCount-1)
                    {
                        gottaHitNote = !section.mustHitSection;
                    }
    
                    var oldNote = null;
                    if (game.unspawnNotes.length > 0)
                        oldNote = game.unspawnNotes[Std.int(game.unspawnNotes.length - 1)];
                    else
                        oldNote = null;
    
                    var swagNote = new Note(daStrumTime, daNoteData, oldNote);
                    swagNote.mustPress = gottaHitNote;
                    swagNote.sustainLength = songNotes[2];
                    if (section.gfSection && songNotes[1]<keyCount)
                        swagNote.gfNote = true;
                    swagNote.noteType = songNotes[3];

                    swagNote.eventLength = actualNoteData; //stealing these variables lol
                    swagNote.eventName = ''+keyCount;
                    swagNote.eventVal1 = ''+daNoteData;
    
                    swagNote.scrollFactor.set();
    
                    var susLength = swagNote.sustainLength;
    
                    susLength = susLength / Conductor.stepCrochet;
                    game.unspawnNotes.push(swagNote);
    
                    var floorSus = Math.floor(susLength);
                    if(floorSus > 0) {
                        for (susNote in 0...floorSus+1)
                        {
                            oldNote = game.unspawnNotes[Std.int(game.unspawnNotes.length - 1)];
    
                            var sustainNote = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + (Conductor.stepCrochet / FlxMath.roundDecimal(game.songSpeed, 2)), daNoteData, oldNote, true);
                            sustainNote.mustPress = gottaHitNote;
                            if (section.gfSection && songNotes[1]<keyCount)
                                sustainNote.gfNote = true;

                            sustainNote.noteType = swagNote.noteType;
                            sustainNote.scrollFactor.set();
                            sustainNote.eventLength = actualNoteData; //stealing this variables lol
                            sustainNote.eventName = ''+keyCount;
                            sustainNote.eventVal1 = ''+daNoteData;
                            //swagNote.tail.push(sustainNote);
                            //sustainNote.parent = swagNote;
                            game.unspawnNotes.push(sustainNote);
                        }
                    }
                }
			}
		}

		game.unspawnNotes.sort(game.sortByShit);
    ]])
end