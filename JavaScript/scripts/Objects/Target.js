////////////////////////////////////////////////////////////////////
////	TARGET
////////////////////////////////////////////////////////////////////

function Target()	{
	this.position = new Vector(900, canvas.height/2);
	this.opacity = 1;
	this.fadeout = false;

	// Load static vignette
	this.target = sprites[7];
}

// Update the target
Target.prototype.update = function ()	{
	var distanceY = Math.abs(mouseY - this.position.y);
	var changeRateY = map(distanceY, 0, canvas.height/2, 0, 70);

	if(mouseY > this.position.y)	{
		this.position.y += changeRateY;
	}
	if(mouseY < this.position.y)	{
		this.position.y -= changeRateY;
	}

	// Fade out the target
	if(this.fadeout && this.opacity > 0.05)	{
		this.opacity -= 0.01;
	}
}

// Draw the target
Target.prototype.draw = function ()	{

	flicker(0.4*this.opacity, 0.6*this.opacity);
	ctx.drawImage(this.target, this.position.x, this.position.y);
	flickerReset();

}