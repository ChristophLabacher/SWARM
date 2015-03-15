////////////////////////////////////////////////////////////////////
////	SOUNDEFFECTS
////////////////////////////////////////////////////////////////////

function SoundEffects()	{
	
	// Ambient Sound
	this.ambient = new Audio();
	this.ambient.src = 'sounds/fx/ambient.mp3';
	this.ambient.loop = true;
	this.ambient.play();
	this.ambient.volume = 0.3;

	// Swarm Sound
	this.swarm = new Audio();
	this.swarm.src = 'sounds/fx/swarm.mp3';
	this.swarm.loop = true;
	this.swarm.play();
	this.swarm.volume = 0.1;
}