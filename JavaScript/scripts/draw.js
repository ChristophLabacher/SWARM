// Draw all elements
function draw()	{
	// Draw background
	paralax.drawBackground();

	// Draw background2
	//paralax.drawBackground2();

	// Draw swarm => every firefly
	swarm.draw();

	// Draw lightbeams
	for (var i = 0; i < lightbeams.length; i++)	{
		lightbeams[i].draw();
	}

	// Draw soundspots
	for (var i = 0; i < soundspots.length; i++)	{
		soundspots[i].draw();
	}

	// Draw target
	target.draw();

	// Draw foreground
	paralax.drawForeground();

	// Draw blur
	paralax.drawBlur();

	// Draw focus display
	focusDisplay.draw();

	// Draw medals
	for (var i = 0; i < medals.length; i++)	{
		medals[i].draw();
	}
	// Draw vignette
	vignette.vignetteStatic();
	vignette.vignetteDynamic();
}