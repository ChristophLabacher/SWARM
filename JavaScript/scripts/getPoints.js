
function getPoints () {
	paper.install(window);

	paper.setup('svgCanvas');
	
	top_Points = []
	bottom_Points = []
			
	function loadSVG(file){
		var svg = null;
		$.ajax({
			type: "GET",
			async: false,
			url: file,
			dataType: "xml",
			success: function(xml){
				svg = project.importSVG(xml.getElementsByTagName("svg")[0]);
			}
		});
		return svg;	
	}
		
	shape = loadSVG('imgs/level/level.svg');
	//shape = project.importSVG(document.getElementById('svg'));
	shape.visible = false;

	top_top = shape.children.top_top;
	top_bottom = shape.children.top_bottom;
	bottom_bottom = shape.children.bottom_bottom;
	bottom_top1 = shape.children.bottom_top_1;
	bottom_top2 = shape.children.bottom_top_2;
	top_top.applyMatrix = true;	
	top_bottom.applyMatrix = true;
	bottom_bottom.applyMatrix = true;
	bottom_top1.applyMatrix = true;
	bottom_top2.applyMatrix = true;
	
	for (var i = 0; i < top_top.children[0].length; i += 1) {
		// Find the point on the path:
		var point = top_top.children[0].getPointAt(i);
		top_Points.push(point)
	}
	
	for (var i = 0; i < top_bottom.children[0].length; i += 1) {
		// Find the point on the path:
		var point = top_bottom.children[0].getPointAt(i);
		top_Points.push(point)
	}
	
	for (var i = 0; i < bottom_bottom.children[0].children[0].length; i += 1) {
		// Find the point on the path:
		var point = bottom_bottom.children[0].children[0].getPointAt(i);
		bottom_Points.push(point)
	}
	
	for (var i = 0; i < bottom_top1.children[0].length; i += 1) {
		// Find the point on the path:
		var point = bottom_top1.children[0].getPointAt(i);
		bottom_Points.push(point)
	}
	
	for (var i = 0; i < bottom_top2.children[0].length; i += 1) {
		// Find the point on the path:
		var point = bottom_top2.children[0].getPointAt(i);
		bottom_Points.push(point)
	}
}

function movePoints()	{
	project.clear();


	for (var i = 0; i < top_Points.length; i += 40) {
		var point = jQuery.extend({}, top_Points[i]);
		
		point.x -= gameposition;
		
		if (point.x < 800 && point.x > 100 && point.y > 1)	{
		// Create a small circle shaped path at the point:
		var circle = new Path.Circle({
		    center: point,
		    radius: 2,
		    fillColor: 'red'
		});	
		}
	}
	

	for (var i = 0; i < bottom_Points.length; i += 40) {
		var point = jQuery.extend({}, bottom_Points[i]);
		
		point.x -= gameposition;
		
		if (point.x < 800 && point.x > 100 && point.y < canvas.height - 1)	{
		// Create a small circle shaped path at the point:
		var circle = new Path.Circle({
		    center: point,
		    radius: 2,
		    fillColor: 'white'
		});	
		}
	}

	
	paper.view.draw();
}