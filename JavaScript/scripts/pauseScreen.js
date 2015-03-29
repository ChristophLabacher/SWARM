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
			$("#pauseScreen").addClass("active")
		}
		
		wasPause = true;
	};
	
	if (!pause && wasPause)	{
		$("#pauseScreen").removeClass("active");
		wasPause = false;
	}
}