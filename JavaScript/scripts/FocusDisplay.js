////////////////////////////////////////////////////////////////////
////	FOCUS DISPLAY
////////////////////////////////////////////////////////////////////

function FocusDisplay()	{
	this.chargeing = true;
	this.lowenergy = false;

	this.focusenergy = 1;
}

// Update the focusdisplay
FocusDisplay.prototype.update = function ()	{
	this.focusenergy = constrain(this.focusenergy, 0, 1);

	// Check whether the focus energy has to be charged or discharged
	// If it hits 0 spread the swarm
	if(this.chargeing || this.focusenergy <= 0)	{
		this.charge();
		swarm.spread();
	}
	else	{
		this.discharge();
	}
}

// Charge the focus energy
FocusDisplay.prototype.charge = function ()	{
	this.focusenergy += 0.007;

	// If there is less than a third activate lowenergy
	if(this.focusenergy <= 0.33)	{
		this.lowenergy = true;
	} else	{
		this.lowenergy = false;
	}
}

// Discharge the focus energy
FocusDisplay.prototype.discharge = function() {
	this.focusenergy -= 0.01;
}

// Draw the focus dispay
FocusDisplay.prototype.draw = function ()	{
	// Draw white circle
	ctx.strokeStyle = 'rgba(255, 255, 255, 0.3)';
	ctx.lineWidth = 5;
	ctx.beginPath();
	ctx.arc(100, canvas.height-100, 50, 0, Math.PI*2, false);
	ctx.stroke();
 
 	// If it is charging make it more transparent
	if(this.chargeing)	{
		ctx.strokeStyle = 'rgba(240, 200, 20, 0.5)'
	} else	{
	// If it is discharing make it brighter
		ctx.strokeStyle = 'rgba(240, 200, 20, 0.8)';
	}
	// If the lowenergy is activated make it red
	if(this.lowenergy)	{
		ctx.strokeStyle = 'rgba(240, 0, 0, 0.3)';
	}

	this.focusenergy = constrain(this.focusenergy, 0, 1);

	// Draw the enregy circle
	ctx.lineWidth = 5;
	ctx.beginPath();
	ctx.arc(100, canvas.height-100, 50, 0 - (Math.PI/2), (Math.PI*2)*this.focusenergy - (Math.PI/2), false);
	ctx.stroke();
}