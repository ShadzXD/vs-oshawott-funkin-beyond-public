function opponentNoteHit(n)
{
    game.health -= 0.013;
}
//really shittily swaps stuff from this point onwards
//i could probably do this in source butttttttttttttttt
function onCreate()
{
    hudClass.healthBar.leftToRight = true;
    hudClass.iconP1.flipX = true;
    hudClass.iconP2.flipX = true;
    hudClass.healthBar.setColors(FlxColor.LIME, FlxColor.RED);
}
function onUpdatePost(e)
{
    hudClass.iconP1.x -= 100;
    hudClass.iconP2.x += 110;
}