
function getPoints () {
	paper.install(window);

	paper.setup('svgCanvas');
	
	top_Points = []
	bottom_Points = []
			
	shape = project.importSVG(levelSVG);
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
	
	top_Points_selected = [];
	bottom_Points_selected = [];
}

function movePoints()	{
	var step = 20;
	
	top_Points_selected = [];
	
	for (var i = 0; i < top_Points.length; i += step) {
		var point = top_Points[i];
				
		if (point.x - gameposition < 800 && point.y > 1)	{
			top_Points_selected.push(point);
		}
	}
	
	bottom_Points_selected = [];
	
	for (var i = 0; i < bottom_Points.length; i += step) {
		var point = bottom_Points[i];
				
		if (point.x - gameposition < 800 && point.y < canvas.height - 1)	{
			bottom_Points_selected.push(point);
		}
	}
}