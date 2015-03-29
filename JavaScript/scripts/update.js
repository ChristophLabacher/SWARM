// Update all elements
function update()	{

	// Move the swarm => ever firefly
	swarm.update();

	// Update dust
	for (var i = 0; i < lightbeams.length; i++)	{
		for (var j = 0; j < lightbeams[i].dust.length; j++)	{
			lightbeams[i].dust[j].update();
		}
	}

	// Update soundspots
	for (var i = 0; i < soundspots.length; i++)		{
		soundspots[i].update();
	}

	// Update target
	target.update();

	// Move the paralaxes => every imagelayer & the soundspots & lightBeams
	paralax.update();
	movePoints();

	// Update focus display
	focusDisplay.update();
}