////////////////////////////////////////////////////////////////////
////	MEDAL
////////////////////////////////////////////////////////////////////

function PauseIcons()	{
	this.leftactiveopacity = 1;
	this.leftinactiveopacity = 0;
	this.opacitycount = 0;	
	this.lefthandset = false;

	this.rightpositionY = canvas.height/2 - 84 - 50 ;
	this.movecount = 0;
	this.righthandset = false;


	// Setup pause canvas
	pauseCanvas = document.getElementById('pauseCanvas');
	pauseCtx = pauseCanvas.getContext('2d');
	pauseCanvas.width = 1280;
	pauseCanvas.height = 800;
	
	// Load pause icons
	this.leftactive = new Image();
	this.leftactive.src = 'imgs/screens/pause_icon_left_active.png';

	this.leftinactive = new Image();
	this.leftinactive.src = 'imgs/screens/pause_icon_left_inactive.png';

	this.right = new Image();
	this.right.src = 'imgs/screens/pause_icon_right.png';
}

// Update the icons
PauseIcons.prototype.update = function ()	{
	this.leftactiveopacity = map(Math.sin(this.opacitycount), -1, 1, 01, 2);
	this.leftinactiveopacity = map(Math.sin(this.opacitycount + Math.PI), -1, 1, 0, 1);
	this.opacitycount += 0.1

	// Make the icons jiggle;
	this.rightpositionY += Math.sin(this.movecount)*4;
	console.log(Math.sin(this.movecount)*5);
	this.movecount += 0.05;

}

// Draw the Icons
PauseIcons.prototype.draw = function ()	{
	pauseCtx.globalAlpha = this.leftactiveopacity*0.6;
	pauseCtx.drawImage(this.leftactive, canvas.width/2 - 300 - 84, canvas.height/2 - 84);
	pauseCtx.globalAlpha = 1;

	pauseCtx.globalAlpha = this.leftinactiveopacity;
	pauseCtx.drawImage(this.leftinactive, canvas.width/2 - 300 - 84, canvas.height/2 - 84);
	pauseCtx.globalAlpha = 1;

	pauseCtx.globalAlpha = 0.8;
	pauseCtx.drawImage(this.right, canvas.width/2 + 300 - 84, this.rightpositionY);
	pauseCtx.globalAlpha = 1;s
}