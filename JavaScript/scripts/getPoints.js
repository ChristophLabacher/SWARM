var top_top;

function getPoints () {
	paper.install(window);

	paper.setup('svgCanvas');
	
	top_top_Points = [];
	
	var shape = project.importSVG(document.getElementById('svg'));
	shape.visible = false;

	top_top = shape.children.top_top;
	top_bottom = shape.children.top_bottom;
	
	top_top.applyMatrix = true;
	top_bottom.applyMatrix = true;	
	
	for (var i = 0; i < top_top.children[0].length; i += 1) {
		// Find the point on the path:
		var point = top_top.children[0].getPointAt(i);
		top_top_Points.push(point)
	}
}

function movePoints()	{
	project.clear();

	for (var i = 0; i < top_top_Points.length; i += 20) {
		var point = jQuery.extend({}, top_top_Points[i]);
		
		point.x -= gameposition;
		point.y += 20;
		
		if (point.x < 800 && point.x > 100 && point.y > 25)	{
		// Create a small circle shaped path at the point:
		var circle = new Path.Circle({
		    center: point,
		    radius: 3,
		    fillColor: 'red'
		});	
		}
	}
	
	paper.view.draw();
}