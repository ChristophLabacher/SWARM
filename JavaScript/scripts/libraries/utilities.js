////////////////////////////////////////////////////////////////////
////	SOME SMALL TOOLS AND HELPERS
////////////////////////////////////////////////////////////////////


//	NEW OBJECTS
////////////////////////////////////////////////////////////////////

// Allow usage of vectors
function Vector(x, y) {
	this.x = x || 0;
	this.y = y || 0;
}

// Add two vectors
Vector.prototype.add = function(vector) {
	this.x += vector.x;
	this.y += vector.y;
}

// Get the lenght of a vector
Vector.prototype.lenght = function () {
	return Math.sqrt(this.x * this.x + this.y * this.y);
};

//	MATH
////////////////////////////////////////////////////////////////////

// Get a random number between f and t
function random(f, t)	{
	this.f = f || 0;
	this.t = t || 1;
	var r = Math.random()*(t-f) + f;
	return r;
}

// Calculate the distance between two points
function dist(x1, y1, x2, y2) {
	var xs = 0;
	var ys = 0;

	xs = x2 - x1;
	xs *= xs;
	ys = y2 - y1;
	ys *= ys;

	return Math.sqrt(xs + ys);
};

// Make opacity flicker between f and t (0 – 1)
function flicker(f, t)	{
	this.f = f || 0;
	this.t = t || 1;
	var r = random(f,t);
	ctx.globalAlpha = r;
}

// Reset opacity to 1
function flickerReset()	{
	ctx.globalAlpha = 1;
}

// Map a number
function map(value, low1, high1, low2, high2) {
    return low2 + (high2 - low2) * (value - low1) / (high1 - low1);
}

// Constrain a number
function constrain(value, f, t)	{
	if (value < f)	{
		return f;
	}
	if (value > t)	{
		return t;
	}
	else	{
		return value;
	}
}

// Calcutlate from degrees to radians
function radians(value)	{
	return value*Math.PI/180;
}

//	EVENTS
////////////////////////////////////////////////////////////////////

// Get the mouse position
function getMousePosition()	{
	var mie = (navigator.appName == "Microsoft Internet Explorer") ? true : false;
	
	if (!mie) {
	     document.captureEvents(Event.MOUSEMOVE);
	     document.captureEvents(Event.MOUSEDOWN);
	}
	
	document.onmousemove = function (e) {mousePos(e);};
	
	function mousePos (e) {
	    if (!mie) {
	        mouseX = e.pageX; 
	        mouseY = e.pageY;
	    }
	    else {
	        mouseX = event.clientX + document.body.scrollLeft;
	        mouseY = event.clientY + document.body.scrollTop;
	    }
	
	    return true;
	}

}

//	DOM
////////////////////////////////////////////////////////////////////
function addClass(id, klasse)	{
	document.getElementById(id).className += ' ' + klasse;
}

function deleteClasses(id)	{
	document.getElementById(id).className = '';
}

function setClass(id, klasse)	{
	document.getElementById(id).className = klasse;
}
