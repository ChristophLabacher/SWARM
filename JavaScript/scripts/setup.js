////////////////////////////////////////////////////////////////////
////	SETUP OF THE LEVEL
////////////////////////////////////////////////////////////////////

// Create all elements
function setup()	{
	getPoints();

	// Create a new swarm
	swarm = new Swarm(80);

	// Create new paralax effect
	paralax = new Paralax();

	// Create new lightbeams
	lightbeams = []
	lightbeams[0] = new LightBeam(1, new Vector(4800, 0));
	lightbeams[1] = new LightBeam(2, new Vector(10600, 0));
	lightbeams[2] = new LightBeam(3, new Vector(600, 0));

	// Create new focus display
	focusDisplay = new FocusDisplay();

	// Create new medals
	medals = []
	medals[0] = new Medal(1);
	medals[1] = new Medal(2);
	medals[2] = new Medal(3);

	// Create new target
	target = new Target();

	// Create new vignette
	vignette = new Vignette();

	// Create new sound effects
	soundEffects = new SoundEffects();

	// Create new soundspots
	soundspots = []
	soundspots[0] = new SoundSpot(1, new Vector(1700, 315));
	soundspots[1] = new SoundSpot(2, new Vector(4140, 410));
	soundspots[2] = new SoundSpot(3, new Vector(4740, 175));
	soundspots[3] = new SoundSpot(4, new Vector(9030, 320));
	soundspots[4] = new SoundSpot(5, new Vector(10150, 625));
	soundspots[5] = new SoundSpot(6, new Vector(12320, 155));

	pauseIcons = new PauseIcons();

	// Initiate mouse tracking
	getMousePosition();

	// Add mouse events: on mousedown the swam focuses, on mouseup it spreads
	var canvas = document.getElementById('swarm');
	canvas.addEventListener ('mousedown', function()	{if (focusDisplay.lowenergy == false) {swarmfocus = true;}}, false);
	canvas.addEventListener ('mouseup', function()	{swarmfocus = false; swarm.spread();}, false);

	score = 0;
	gameposition = 0;
	endofgameCounter = 0;
	endofgame = false;

	swarmtick = true;
	worldtick = true;
}