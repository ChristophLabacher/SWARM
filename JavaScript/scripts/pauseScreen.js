////////////////////////////////////////////////////////////////////
////	PAUSE
////////////////////////////////////////////////////////////////////

// During the pause show and animate the icons
function pauseScreen()	{

	if(pause)	{
		worldtick = false;
		swarmtick = true;

		pauseIcons.update();
		pauseIcons.draw();
		
		if (wasPause == false)	{
			setClass('pauseScreen', 'active');
		}
		
		wasPause = true;
	};
	
	if (!pause && wasPause)	{
		deleteClasses('pauseScreen', 'active');
		wasPause = false;
	}
}