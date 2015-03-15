////////////////////////////////////////////////////////////////////
////	END OF THE LEVEL
////////////////////////////////////////////////////////////////////

// At the end of the level make the swam and the world slow down and stop
function pauseScreen()	{

	pause = false;

	if(pause)	{
		worldtick = false;
		swarmtick = false;

		setClass('pauseScreen', 'active');
		pauseIcons.update();
		pauseIcons.draw();
	};
}