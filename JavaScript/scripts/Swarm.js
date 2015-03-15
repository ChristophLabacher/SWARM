////////////////////////////////////////////////////////////////////
////	SWARM
////////////////////////////////////////////////////////////////////

function Swarm(c_)	{
	this.fireflies = []
	var fireflyCount = c_ || 100;

	fireflyglow = new Image();
	fireflyglow.src = 'imgs/sprites/firefly_glow.png';

	swarmfocus = false;
	frontmostX = 0;
	focustime = 0;

	// Create new this.fireflies
	for (var i = 0; i < fireflyCount; i++)	{
		this.fireflies[i] = new Firefly(i);
	}
}

// Update all the this.fireflies
Swarm.prototype.update = function ()	{

	if(swarmtick)	{
		// Gets the position of the frontmost firefly
		frontmostX = 0;
		for (var i = 0; i < this.fireflies.length; i++) {
			if(this.fireflies[i].center.x > frontmostX)	{
				frontmostX = this.fireflies[i].center.x;
			}
		}

		for (var i = 0; i < this.fireflies.length; i++) {
			this.fireflies[i].update();

			// Check if the firefly needs to be killed
			if (!this.fireflies[i].isalive)	{
				this.fireflies.splice(i, 1);
			}
		}

		// If the mouse is down focus the swarm
		if(swarmfocus == true)	{
			this.focus();
		}
	}
}

// Focus all the this.fireflies
Swarm.prototype.focus = function ()	{
	// Only lowenergy isn't activated
	if (!focusDisplay.lowenergy)	{
		for (var i = 0; i < this.fireflies.length; i++) {
			this.fireflies[i].wasfocused = false;
			this.fireflies[i].isfocused = true;
			this.fireflies[i].focus();
		}

		focustime++;

		// Make the focus energy discharge
		focusDisplay.chargeing = false;

		// Increase the swarm sound when focused
		soundEffects.swarm.volume = constrain(map(focustime, 0, 100, 0.1, 0.5), 0.1, 0.5);
	}
}

// Spread all the this.fireflies
Swarm.prototype.spread = function ()	{
	for (var i = 0; i < this.fireflies.length; i++) {
		this.fireflies[i].isfocused = false;
		this.fireflies[i].wasfocused = true;
		this.fireflies[i].focustime = focustime;
		focustime = 0;
	}

	// Make the focus energy charge
	focusDisplay.chargeing = true;
}

// Draw all the this.fireflies
Swarm.prototype.draw = function ()	{
	for (var i = 0; i < this.fireflies.length; i++) {
		this.fireflies[i].draw();
		//this.fireflies[i].drawCenter();
	}
}