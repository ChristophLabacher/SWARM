function loadFiles()	{
	sprites = [];
	spriteURL = [
		 'imgs/sprites/firefly_glow.png',
		 'imgs/sprites/light_beam_1.png',
		 'imgs/sprites/light_beam_2.png',
		 'imgs/sprites/light_beam_3.png',
		 'imgs/sprites/medal_blur.png',
		 'imgs/sprites/soundspot_blur.png',
		 'imgs/sprites/soundspot_rotate.png',
		 'imgs/sprites/target.png',
		 'imgs/sprites/vignette_dynamic.png',
		 'imgs/sprites/vignette_static.png'
	];
	spriteCount = spriteURL.length;
	
	level = [];
	levelURL = [
		'imgs/level/background_neat_light.jpg',
		'imgs/level/background2_neat.png',
		'imgs/level/blur.png',
		'imgs/level/foreground.png',
	];
	levelCount = levelURL.length;
	
	levelSVG = null;
	levelSVGURL = 'imgs/level/level.svg';
	levelSVGCount = 1;
	
	sounds = [];
	soundURL = [
		'sounds/loops/loop1.mp3',
		'sounds/loops/loop2.mp3',
		'sounds/loops/loop3.mp3',
		'sounds/loops/loop4.mp3',
		'sounds/loops/loop5.mp3',
		'sounds/loops/loop6.mp3',
		'sounds/fx/ambient.mp3',
		'sounds/fx/swarm.mp3'
	];
	soundCount = soundURL.length;
	
	fileCount = spriteCount + levelCount + levelSVGCount + soundCount;
	fileStepCount = fileCount;
	
	// Load sprites
	for(var i = 0; i < spriteCount; i++) {
		 /// create a new image element
		 var img = new Image();
	
		 /// element is valid so we can push that to stack
		 sprites.push(img);
	
		 /// set handler and url
		 img.onload = onloadHandler;
		 img.src = spriteURL[i];
	}
	
	// Load level
	for(var i = 0; i < levelCount; i++) {
		 /// create a new image element
		 var img = new Image();
	
		 /// element is valid so we can push that to stack
		 level.push(img);
	
		 /// set handler and url
		 img.onload = onloadHandler;
		 img.src = levelURL[i];
	}
	
	// Load levelSVG
	$.ajax({
		type: "GET",
		async: false,
		url: levelSVGURL,
		dataType: "xml",
		success: function(xml){
			levelSVG = xml.getElementsByTagName("svg")[0];
			onloadHandler();
		}
	});
	
	// Load sounds
	for(var i = 0; i < soundCount; i++) {
		 /// create a new image element
		 var audio = new Audio();
	
		 /// element is valid so we can push that to stack
		 sounds.push(audio);
	
		 /// set handler and url
		 audio.autoPlay = false;
		 audio.oncanplaythrough = onloadHandler;
		 audio.src = soundURL[i];
	}
}

function onloadHandler() {
	fileCount--;
}