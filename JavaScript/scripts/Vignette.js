////////////////////////////////////////////////////////////////////
////	VIGNETTE
////////////////////////////////////////////////////////////////////

function Vignette()	{
	// Setup vignette canvas
	overlayCanvas = document.getElementById('overlayCanvas');
	overlayCtx = overlayCanvas.getContext('2d');
	overlayCanvas.width = 1280;
	overlayCanvas.height = 800;
	
	// Load static vignette
	this.vignettestatic = new Image();
	this.vignettestatic.src = 'imgs/sprites/vignette_static.png';

	// Load dynamic vignette
	this.vignettedynamic = new Image();
	this.vignettedynamic.src = 'imgs/sprites/vignette_dynamic.png';
}

// Draw static vignette
Vignette.prototype.vignetteStatic = function()	{
	overlayCtx.globalAlpha = 0.8;
	overlayCtx.drawImage(this.vignettestatic, 0, 0);
	overlayCtx.globalAlpha = 1;
}

// Draw dynamic vignette
Vignette.prototype.vignetteDynamic = function()	{
	var opacity = constrain(map(swarm.fireflies.length, 0, 100, 0.6, 0.3));
	var r = random(opacity-0.03,opacity+0.03);
	overlayCtx.globalAlpha = r;
	overlayCtx.drawImage(this.vignettedynamic, 0, 0);
	overlayCtx.globalAlpha = 1;
}