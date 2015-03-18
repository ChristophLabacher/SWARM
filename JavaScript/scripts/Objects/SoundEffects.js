////////////////////////////////////////////////////////////////////
////	SOUNDEFFECTS
////////////////////////////////////////////////////////////////////

function SoundEffects()	{
	
	// Ambient Sound
	this.ambient = sounds[6];
	this.ambient.loop = true;
	this.ambient.play();
	this.ambient.volume = 0.3;

	// Swarm Sound
	this.swarm = sounds[7];
	this.swarm.loop = true;
	this.swarm.play();
	this.swarm.volume = 0.1;
}