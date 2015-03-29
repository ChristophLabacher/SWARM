////////////////////////////////////////////////////////////////////
////	LOADING
////////////////////////////////////////////////////////////////////

// During the pause show and animate the icons
function loadingScreen()	{
	var loadingRadius = 50;
	var innerLoadingRadiusLimit = 10;
	var loadingStep = (loadingRadius - 10) / fileStepCount;
	
	innerLoadingRadiusLimit = loadingRadius - (fileCount * loadingStep);
	
	if (innerLoadingRadius < innerLoadingRadiusLimit)	{
		innerLoadingRadius += 0.5;
	} else if (fileCount === 0)	{
		filesLoaded();
		$("#splashScreen").removeClass("active");
	}
	
	innerLoadingRadius += random(-.4, .4);

	// Draw outer circle
	loadingCtx.strokeStyle = 'rgb(240,200,20)';
	loadingCtx.lineWidth = 2;
	loadingCtx.beginPath();
	loadingCtx.arc(canvas.width/2, canvas.height/2, loadingRadius, 0, Math.PI*2, false);
	loadingCtx.stroke();

	// Draw inner circle
	loadingCtx.fillStyle = 'rgb(240,200,20)';
	loadingCtx.beginPath();
	loadingCtx.arc(canvas.width/2, canvas.height/2, innerLoadingRadius, 0, Math.PI*2, false);
	loadingCtx.fill();
}