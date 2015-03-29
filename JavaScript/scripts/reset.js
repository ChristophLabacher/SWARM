////////////////////////////////////////////////////////////////////
////	RESET
////////////////////////////////////////////////////////////////////

// Removing all traces of the last run
function reset()	{

	delete swarm.fireflies;

	// Create a new swarm
	delete swarm;

	// Create new soundspots
	delete soundspots;

	// Create new lightbeams
	delete lightbeams;

	// Create new paralax effect
	delete paralax;

	// Create new focus display
	delete focusDisplay;

	// Create new focus display
	delete medals;

	// Create new target
	delete target;

	// Create new vignette
	delete vignette;

	// Create new sound effects
	delete soundEffects;

	$("#endScreen").removeClass("active");
}