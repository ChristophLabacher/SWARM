function getPoints () {

	collisionTop = [];

	paper.install(window);

	window.onload = function() {
		paper.setup('svgCanvas');
		
		var shape = project.importSVG(document.getElementById('svg'));
		shape.visible = false;
	
		var top_top = shape.children.top_top;
		var top_bottom = shape.children.top_bottom;
		
		top_top.applyMatrix = true;
		top_bottom.applyMatrix = true;
		
		for (var i = 0; i < top_top.children[0].length; i++) {
			// Find the point on the path:
			var point = top_top.children[0].getPointAt(i);
			collisionTop.push(point);
			// Create a small circle shaped path at the point:
			var circle = new Path.Circle({
			    center: point,
			    radius: 3,
			    fillColor: 'red'
			});
		}
		
		paper.view.draw();
		
	}

}
