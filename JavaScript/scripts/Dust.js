////////////////////////////////////////////////////////////////////
////	FIREFLY
////////////////////////////////////////////////////////////////////

function Dust(i_, x_, y_)	{
	this.id = i_;
	this.position = new Vector(x_, y_);
	this.position.x += canvas.width/2;
	this.position.x += random(-100, 100);
	this.position.y = (canvas.height/2) + random(-400, 400);
	this.center = new Vector(x_, y_);
	this.center.x += canvas.width/2;
	this.center.x += random(-100, 100);
	this.center.y = (canvas.height/2) + random(-400, 400);
	this.distance = 0;
	this.velocity = new Vector(random(-0.5,0.5),random(-0.5,0.5));
	this.size = 1;

	this.updateCount = 0;
}

// Update the position of the firefly
Dust.prototype.update = function ()	{
	// Change the direction of the firefly all 50 frames
	if (this.updateCount%50 == 0)	{
		this.velocity = new Vector(random(-1,1), random(-1,1));
	}

	this.distance = dist(this.position.x, this.position.y, this.center.x, this.center.y);
	if (this.distance > 100)	{
		var x = this.center.x - this.position.x;
		var y = this.center.y - this.position.y;
		this.velocity =  new Vector(x * 0.0025, y * 0.0025);
	}

	// Move the firefly
	this.position.add(this.velocity);
	this.updateCount++;
}

// Draw the firefly
Dust.prototype.draw = function ()	{
	ctx.fillStyle = 'rgba(255,255,255,0.25)';
	ctx.beginPath();
	ctx.arc(this.position.x, this.position.y, this.size, 0, Math.PI*2, false);
	ctx.fill();
}