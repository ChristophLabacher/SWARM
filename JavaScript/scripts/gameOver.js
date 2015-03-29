////////////////////////////////////////////////////////////////////
////	Game Over
////////////////////////////////////////////////////////////////////

// At the end of the level make the swam and the world slow down and stop
function gameOver()	{

	if(swarm.fireflies.length < 1)	{
		isGameOver = true;
	}

	if(isGameOver)	{
		gameOverCounter++;
	}

	if(gameOverCounter >= 50)	{
		$("#blackoutScreen").addClass("active");
	};

	if(gameOverCounter > 50 && gameOverCounter < 150)	{
		for(var i = 0; i < soundspots.length; i++)	{
			soundspots[i].sound.volume *= 0.95;
		}		
	}
	
	if(gameOverCounter >= 80)	{

		reset();
		setup();
		
		setTimeout(function(){
			$("#blackoutScreen").removeClass("active");
		}, 300)
	}
}