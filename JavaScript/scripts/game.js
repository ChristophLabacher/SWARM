////////////////////////////////////////////////////////////////////
////	GENERAL GAME RUN
////////////////////////////////////////////////////////////////////

// Setup Canvas
var canvas = document.getElementById('gameCanvas');
var ctx = canvas.getContext('2d');
canvas.width = 1280;
canvas.height = 800;

// Setup loading canvas
var loadingCanvas = document.getElementById('splashCanvas');
var loadingCtx = loadingCanvas.getContext('2d');
loadingCanvas.width = 1280;
loadingCanvas.height = 800;

var overlayCtx;
var pauseCtx;
var endCtx;

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
	
	if (started)	{
		update();
		draw();
		pauseScreen();
		endScreen();	
	} else {
		loadingScreen();
	}
	
	queue();
}
 
// Clear the canvas
function clear()	{
	if (ctx)	{
		ctx.clearRect(0, 0, canvas.width, canvas.height);	
	}
	if (overlayCtx)	{
		overlayCtx.clearRect(0, 0, canvas.width, canvas.height);
	}
	if (pauseCtx)	{
		pauseCtx.clearRect(0, 0, canvas.width, canvas.height);
	}
	if (endCtx)	{
		endCtx.clearRect(0, 0, canvas.width, canvas.height);
	}
}

// When the browser is ready start the new run
function queue()	{
	// Limit framerate to about 35 fps
	setTimeout(function()	{
		window.requestAnimationFrame(loop);
	}, 1000/80);
}


// Initiate the setup and run the loop
window.onload = function() {
	loadFiles();
	innerLoadingRadius = 10;
	loop();	
}

function filesLoaded()	{
	setup();
	started = true;
}