////////////////////////////////////////////////////////////////////
////	PARALAX IMAGE LAYERS
////////////////////////////////////////////////////////////////////

function Paralax()	{	
	// Load background
	this.backgroundpositionX = -1000;
	this.backgroundpositionY = 0;
	this.backgroundchange = 2;
	this.background = new Image();
	this.background.src = 'imgs/level/background_neat_light.jpg';
	
	// Load background2
	this.background2positionX = 0;
	this.background2positionY = 0;
	this.background2change = 2;
	this.background2 = new Image();
	this.background2.src = 'imgs/level/background2_neat.png';

	// Lightbeams
	this.lightbeamchange = 4;
	
	// Load foreground
	this.foregroundpositionX = 0;
	this.foregroundchange = 4;
	this.foreground = new Image();
	this.foreground.src = 'imgs/level/foreground.png';

	// Soundspots
	this.soundspotchange = 4;

	// Load blur
	this.blurpositionX = 0;
	this.blurchange = 8;
	this.blur = new Image();
	this.blur.src = 'imgs/level/blur.png';
}

// Move all layers
Paralax.prototype.update = function()	{
	if(worldtick)	{
		// Move background
		this.backgroundpositionX -= this.backgroundchange;
		if (this.backgroundpositionX <= -4866)	{
			this.backgroundpositionX = 0;
		}
		this.backgroundpositionY = map(mouseY, 0, canvas.height, 10, -10);

		// Move background2
		this.background2positionX -= this.background2change;
		if (this.background2positionX <= -2540)	{
			this.background2positionX = 0;
		}
		this.background2positionY = map(mouseY, 0, canvas.height, 5, -5);

		// Move lightbeams
		for(var i = 0; i < lightbeams.length; i++)	{
			lightbeams[i].position.x -= this.lightbeamchange;
	
			for (var j = 0; j < lightbeams[i].dust.length; j++)	{
				lightbeams[i].dust[j].position.x -= this.lightbeamchange;
				lightbeams[i].dust[j].center.x -= this.lightbeamchange;
			}
		}

		// Move foreground
		this.foregroundpositionX -= this.foregroundchange;

		// Move soundspots
		for(var i = 0; i < soundspots.length; i++)	{
			soundspots[i].position.x -= this.soundspotchange;
		}

		// Move blur
		this.blurpositionX -= this.blurchange;
		if (this.blurpositionX <= -14080)	{
			this.blurpositionX = 0;
		}

		gameposition += this.foregroundchange;
	}
}

// Draw background
Paralax.prototype.drawBackground = function()	{
	ctx.drawImage(this.background, this.backgroundpositionX, this.backgroundpositionY);
}

// Draw background2
Paralax.prototype.drawBackground2 = function()	{
	ctx.drawImage(this.background2, this.background2positionX, this.background2positionY);
}

// Draw Foreground
Paralax.prototype.drawForeground = function()	{
	ctx.drawImage(this.foreground, this.foregroundpositionX, 0);
}

// Draw Blur
Paralax.prototype.drawBlur = function()	{
	ctx.drawImage(this.blur, this.blurpositionX, 0);
}