////////////////////////////////////////////////////////////////////
////	SOUNDSPOT
////////////////////////////////////////////////////////////////////

function SoundSpot(i_, p_)	{
	this.id = i_;
	this.position = p_;

	this.radius = 30;
	this.innerradius = 10;
	this.innerradiusmin = this.innerradius;
	this.innerradiuslimit = 10;
	this.step = (this.radius - this.innerradiusmin) / 10;
	this.innerradiusopacity = 0.4;

	this.counter = 0;
	this.grow;
	this.activated = false;
	this.timemout = 40;

	soundspotblur = new Image();
	soundspotblur.src = 'imgs/sprites/soundspot_blur.png';
	soundspotrotate = new Image();
	soundspotrotate.src = 'imgs/sprites/soundspot_rotate.png';
	this.rotate = random(0, 360);

	this.sound = new Audio();
	this.sound.src = 'sounds/loops_corridor/loop' + this.id + '.mp3';
	this.sound.loop = true;
	this.sound.play();
	this.sound.volume = 0;

	this.updatecount = 0;
}

// Update the soundspot
SoundSpot.prototype.update = function ()	{
	// If ten particles have reached the soundspot it is activated
	if (!this.activated && this.counter == 10)	{
		this.activated = true;

		this.sound.volume = 0.8;
		score += 1;
		console.log(score);
	}

	// If the current radius is smaller than the supposed one it grows
	if (this.innerradius < this.innerradiuslimit)	{
		this.innerradius += 0.5;
		this.innerradiusopacity = map(this.innerradius, 10, 30, 0.4, 0.8);
	}

	//If the soundspot is not yet activated
	if (!this.activated)	{
		// Analyse the particles
		this.activating();
	
		// If it doesn't grow anymore count down the timeout
		if (!this.grow && this.timeout > 0)	{
			this.timeout--;
		}

		// If the timeout has ran out reset the soundspot
		if (!this.grow && this.timeout == 0 && this.innerradiusmin < this.innerradius)	{
			this.innerradius -= 0.5;
			this.innerradiuslimit = this.innerradiusmin;
			counter = 0;
		}
	}

	// Flicker if activated
	if (this.activated)	{
		this.radius = random(30, 40);
		this.innerradiusopacity = random(0.5, 0.8);
	}	

	// Make the soundspot jiggle;
	this.position.y +=Math.sin(this.updatecount);
	this.updatecount += 0.05;
}

// Check if any particles are activating the soundspot
SoundSpot.prototype.activating	= function()	{
	for (var i = 0; i < swarm.fireflies.length; i++) {
		if(this.counter < 10)	{
			if(dist(swarm.fireflies[i].position.x, swarm.fireflies[i].position.y, this.position.x, this.position.y) < this.radius)	{
				this.counter++;
				this.grow = true;
				this.innerradiuslimit += this.step;
				this.timeout = 40;
				swarm.fireflies[i].isalive = false;
			} else	{
				this.grow = false;
			} 
		}
	}
}

// Draw the Soundspot
SoundSpot.prototype.draw = function ()	{

	// Background blur
	flicker(0.35, 0.4);
	ctx.drawImage(soundspotblur, this.position.x-50, this.position.y-50, 100, 100);
	flickerReset();

	// Rotating blur
	//ctx.rotate(radians(this.rotate));
	flicker(0.35, 1);
	ctx.drawImage(soundspotrotate, this.position.x-30, this.position.y-30, 60, 60);
	flickerReset();
	//ctx.rotate(radians(-this.rotate));
	//this.rotate++;

	// Draw outer circle
	ctx.strokeStyle = 'rgba(0, 157, 235, 0.3)';
	ctx.lineWidth = 2;
	ctx.beginPath();
	ctx.arc(this.position.x, this.position.y, this.radius, 0, Math.PI*2, false);
	ctx.stroke();

	// Draw inner circle
	ctx.fillStyle = 'rgba(0, 157, 235, ' + this.innerradiusopacity +')';
	ctx.beginPath();
	ctx.arc(this.position.x, this.position.y, this.innerradius, 0, Math.PI*2, false);
	ctx.fill();
}