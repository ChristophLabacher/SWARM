////////////////////////////////////////////////////////////////////
////	FIREFLY
////////////////////////////////////////////////////////////////////

function Firefly(i_)	{
	this.id = i_;
	this.position = new Vector(200 + this.id * 3 + random(-50,50), (canvas.height/2) + random(-100, 100));
	this.center = new Vector(200 + this.id * 3, canvas.height/2);
	this.distance = 0;
	this.velocity = new Vector(random(-1,1),random(-1,1));
	this.jiggle = new Vector(random(-1,1), random(-1,1));
	this.size = 2;
	this.isalive = true;
	this.isfrontmost = false;

	this.focustime = 0;
	this.isfocused = false;
	this.wasfocused = false;
	this.spreadtime = 100;
	this.spreadvelocity = new Vector(random(-5,5),random(-5,5));

	this.updateCount = 0;
}

// Update the position of the firefly
Firefly.prototype.update = function ()	{
	this.isfrontmost = false;

	if (this.center.x == frontmostX) {
		this.isfrontmost = true;
	};

	// Make the firefly jiggle in each frame
	this.jiggle = new Vector(random(-1,1), random(-1,1))
	this.position.add(this.jiggle);

	// Change the direction of the firefly all 50 frames
	if (this.updateCount%50 == 0)	{
		this.velocity = new Vector(random(-1,1), random(-1,1));
	}

	// If the firefly is too far away from its center make it return there
	this.distance = 0;
	this.distance = dist(this.position.x, this.position.y, this.center.x, this.center.y);
	if (this.distance > 100)	{
		var x = this.center.x - this.position.x;
		var y = this.center.y - this.position.y;
		this.velocity =  new Vector(x * 0.01, y * 0.01);
	}

	// If the firefly has to be spreaded and spread it
	this.spread();

	// The firefly follows either the mouse or the one in front of it
	this.follow();

	// Move the firefly
	this.position.add(this.velocity);
	this.updateCount++;
}

// Let the firefly follow the mouse/the one in front of it
Firefly.prototype.follow = function()	{
	//If this is the firefly at the front it follows the mouse
	if (this.isfrontmost)	{
		var distanceY = Math.abs(mouseY - this.center.y);
		var changeRateY = map(distanceY, 0, canvas.height/2, 0, 50);

		if(mouseY > this.center.y)	{
			this.center.y += changeRateY;
			this.position.y += changeRateY;
		}
		if(mouseY < this.center.y)	{
			this.center.y -= changeRateY;
			this.position.y -= changeRateY;
		}
	}
	// Else it searches for the one closest to it and follows that one
	else {
		var closestdistance = 500;
		var closestfirefly = 0;

      for (var i = 0; i < swarm.fireflies.length; i++) {
      	var distance = swarm.fireflies[i].center.x - this.center.x;
      	if (distance < closestdistance && distance > 0)	{
      		closestdistance = distance;
      		closestfirefly = i;
      	}
      }

      var closestfieflyY = swarm.fireflies[closestfirefly].center.y;
      var distanceY = Math.abs(closestfieflyY - this.center.y);
      var changeRateY = map(distanceY, 0, canvas.height, 0, 800);

      	if(closestfieflyY > this.center.y)	{
			this.center.y += changeRateY;
			this.position.y += changeRateY;
		}
		if(closestfieflyY < this.center.y)	{
			this.center.y -= changeRateY;
			this.position.y -= changeRateY;
		}
	}
}

// Focus the firefly (= Move it to its center)
Firefly.prototype.focus = function()	{
	var x = this.center.x - this.position.x;
	var y = this.center.y - this.position.y;
	this.velocity =  new Vector(x * 0.1, y * 0.1);

	// Reset the spreadcounter & spreadvelocity
	this.spreadtime = 0;

	energy = map(this.focustime, 0, 250, 3, 7);
	engery = constrain(energy, 3, 7);
	this.spreadvelocity = new Vector(random(-energy,energy),random(-energy,energy));
}

// Check if the firefly needs to be spreaded and spread it
Firefly.prototype.spread = function() 	{
	// If the firefly was focused before and the spreadcounter hasn't reached 40 the firefly is spreaded
	if (this.spreadtime < 40 && this.wasfocused == true) {
        this.velocity =  this.spreadvelocity;

        // The firefly changes direction a little to make thåings seem more natural
        if (this.spreadtime == 10) {
        	this.spreadvelocity.add(new Vector(random(-4, 4), random(-4, 4)));
        }

        // During the end of the spreadtime the firefly slows down and start moving towards its center
        if (this.spreadtime > 30) {
			var x = this.center.x - this.position.x;
			var y = this.center.y - this.position.y;
        	this.velocity.add(new Vector(x * 0.002, y * 0.002));
        }

        this.spreadtime++;
		
		// Increase the swarm sound when focused
		if(this.spreadtime <= 10)	{
			soundEffects.swarm.volume = constrain(map(this.spreadtime, 0, 10, 0.5, 0.6), 0.5, 0.6);
		} else {
			soundEffects.swarm.volume = constrain(map(this.spreadtime, 40, 10, 0.1, 0.6), 0.1, 0.6);
		}

    } else	{
      	// At the end of the spreadtime the wasfocused is reseted
      	this.wasfocused = false;
    }
}

// Draw the firefly
Firefly.prototype.draw = function ()	{
	ctx.fillStyle = 'rgb(240,200,20)';
	flicker(0.3, 0.8);
	ctx.beginPath();
	ctx.arc(this.position.x, this.position.y, this.size, 0, Math.PI*2, false);
	ctx.fill();

	if (this.isfocused)	{
		flicker(0.3, 0.4);
		ctx.drawImage(fireflyglow, this.position.x-35, this.position.y-35, 70, 70);
	} else	{
		flicker(0.1, 0.2);
		ctx.drawImage(fireflyglow, this.position.x-35, this.position.y-35, 70, 70);
	}
	
	flickerReset();
	
}

// Draw the center of the firefly
Firefly.prototype.drawCenter = function()	{
	if(this.isfrontmost)	{
		ctx.fillStyle = 'rgba(255,0,255, 1)';
		ctx.beginPath();
		ctx.arc(this.center.x, this.center.y, 4, 0, Math.PI*2, false);
		ctx.fill();
	} else	{
		ctx.fillStyle = 'rgba(255,0,0, 1)';
		ctx.beginPath();
		ctx.arc(this.center.x, this.center.y, 1, 0, Math.PI*2, false);
		ctx.fill();		
	}
}