var gfPokemoned:Bool = false;
function onCountdownTick(tick:Countdown, counter:Int)
{
	switch(tick)
	{
		case Countdown.START:
            triggerEvent('Play Animation', 'intro', 'gf', 1);
            trace('hello');
	}
}
function onUpdate(e)
{
    if(gf.isAnimationFinished() && !gfPokemoned)
    {
        trace('finished');
        gfPokemoned = true;
        trace(gf.getAnimationName());
        gf.skipDance = true;
        //have to put a timer here due to how the anim is set up
        // since frenchie had her dancing left automatically, this sort of thing breaks on this engine
        // if this wasnt here, the dancing would break
        new FlxTimer().start(0.1, function(tmr:FlxTimer)
		{
			triggerEvent('Change Character', 'gf', 'gf-sitting-sewadle', 0.001);
            //gf.skipDance = true;
            gf.playAnim('danceLeft');
            
		});
    }
}