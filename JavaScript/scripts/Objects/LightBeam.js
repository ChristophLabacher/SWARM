////////////////////////////////////////////////////////////////////
////	SOUNDSPOT
////////////////////////////////////////////////////////////////////

function LightBeam(i_, p_)	{
	this.id = i_;
	this.position = p_;

	// Load lightbeam
	this.lightbeam = sprites[this.id];

	this.dust = [];
	for (var i = 0; i < 60; i++)	{
		this.dust[i] = new Dust(i, this.position.x, this.position.y);
	}
}

// Draw lightbeam
LightBeam.prototype.draw = function ()	{
	ctx.drawImage(this.lightbeam, this.position.x, this.position.y);
	
	
	for (var j = 0; j < this.dust.length; j++)	{
		this.dust[j].draw();
	}
}