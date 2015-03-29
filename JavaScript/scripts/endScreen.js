////////////////////////////////////////////////////////////////////
////	END OF THE LEVEL
////////////////////////////////////////////////////////////////////

// At the end of the level make the swam and the world slow down and stop
function endScreen()	{

	endofgame = false;

	// Make the swarm move out of the viewport, fade out target
	if(gameposition > 12800)	{
		swarmslowdown();
		target.fadeout = true;
	}

	// Make the world slow down and stop.
	if(gameposition > 13650)	{
		worldslowdown();
	}

	// Fade in the end screen
	if(gameposition > 13650 && gameposition < 13657)	{
		$("#endScreen").addClass("active");
	}

	// Activate the won medals
	if(gameposition > 13850)	{
		for(var i = 0; i <= (score/2)-1; i++)	{
			medals[i].activate();
		}
		endofgame = true;
	}

	if(endofgame)	{
		endofgameCounter++;
	};

	if(endofgameCounter == 300)	{
		$("#blackoutScreen").addClass("active");
	};

	if(endofgameCounter > 200 && endofgameCounter < 400)	{
		for(var i = 0; i < soundspots.length; i++)	{
			soundspots[i].sound.volume *= 0.95;
		}		
	}
}

// Make the swarm move out of the viewport
function swarmslowdown()	{
	for (var i = 0; i < swarm.fireflies.length; i++) {
		var change = map(gameposition, 12800, 13200, 0, 2);
			swarm.fireflies[i].position.x -= change;
			swarm.fireflies[i].center.x -= change;
	}
}

// Make the world slow down and stop.
function worldslowdown()	{
	paralax.backgroundchange *= 0.99;
	paralax.background2change *= 0.99;
	paralax.lightbeamchange *= 0.99;
	paralax.foregroundchange *= 0.99;
	paralax.blurchange *= 0.99;
}