////////////////////////////////////////////////////////////////////
////	MEDAL
////////////////////////////////////////////////////////////////////

function Medal(i_)	{
	this.id = i_;
	this.position = new Vector(canvas.width/2 - 600 + this.id * 300, canvas.height/2-50);
	this.opacity = 0.3;
	this.activated = false;
	this.countdown = this.id * 30;

	// Setup vignette canvas
	endCanvas = document.getElementById('endCanvas');
	endCtx = endCanvas.getContext('2d');
	endCanvas.width = 1280;
	endCanvas.height = 800;
	
	// Load static vignette
	this.medalblur = sprites[4];
}

// Called in endScreen() when the medal is activated
Medal.prototype.activate = function ()	{
	if(this.countdown <= 0)	{
		this.activated = true;
	}
	this.countdown--;
}

// Draw the Medal
Medal.prototype.draw = function ()	{

	// Blur and full opacity if activated
	if(this.activated)	{
		endCtx.globalAlpha = random(0.6*this.opacity, 0.8*this.opacity);
		endCtx.drawImage(this.medalblur, this.position.x-100, this.position.y-100);
		endCtx.globalAlpha = 1;

		if(this.opacity < 1)	{
			this.opacity += 0.01;
		}
	}

	// Draw outer circle
	endCtx.strokeStyle = 'rgba(240, 220, 0, ' + this.opacity + ')';
	endCtx.lineWidth = 2;
	endCtx.beginPath();
	endCtx.arc(this.position.x, this.position.y, 60, 0, Math.PI*2, false);
	endCtx.stroke();

	// Draw inner circle
	endCtx.fillStyle = 'rgba(240, 220, 0, ' + this.opacity + ')';
	endCtx.beginPath();
	endCtx.arc(this.position.x, this.position.y, 40, 0, Math.PI*2, false);
	endCtx.fill();
}