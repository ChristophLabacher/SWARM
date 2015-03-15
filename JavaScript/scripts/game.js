////////////////////////////////////////////////////////////////////
////	GENERAL GAME RUN
////////////////////////////////////////////////////////////////////

// Setup Canvas
var canvas = document.getElementById('gameCanvas');
var ctx = canvas.getContext('2d');
canvas.width = 1280;
canvas.height = 800;

// Initiate fullscreen
var wrapper = document.getElementById("wrapper");
  
function toggleFullScreen() {
  if (!document.mozFullScreen && !document.webkitFullScreen) {
    if (wrapper.mozRequestFullScreen) {
      wrapper.mozRequestFullScreen();
    } else {
      wrapper.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
    }
  } else {
    if (document.mozCancelFullScreen) {
      document.mozCancelFullScreen();
    } else {
      document.webkitCancelFullScreen();
    }
  }
}

document.addEventListener("keydown", function(e) {
  if (e.keyCode == 13) {
    toggleFullScreen();
  }
}, false);

// Initiate mouse position
mouseX = 0;
mouseY = canvas.height/2;

worldtick = false;
swarmtick = false;
started = false;

// Loop all functions
function loop()	{
	clear();
	update();
	draw();
	pauseScreen();
	endScreen();
	queue();
}
 
// Clear the canvas
function clear()	{
	ctx.clearRect(0, 0, canvas.width, canvas.height);
	overlayCtx.clearRect(0, 0, canvas.width, canvas.height);
	pauseCtx.clearRect(0, 0, canvas.width, canvas.height);
	endCtx.clearRect(0, 0, canvas.width, canvas.height);
}

// Update all elements
function update()	{
	if(!started)	{
		
	}

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

	// Update focus display
	focusDisplay.update();
}

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

// When the browser is ready start the new run
function queue()	{
	// Limit framerate to about 35 fps
	setTimeout(function()	{
		window.requestAnimationFrame(loop);
	}, 1000/40);
}

// Initiate the setup and run the loop
setup();
loop();
