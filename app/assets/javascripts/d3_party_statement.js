if (gon.party_statement_chart_data && gon.json_data) {
console.log("values = " + gon.json_data['values']);
	if (gon.json_data['values'] == undefined){
		// no data exists
console.log("json_data has no length");
		$('#statement_chart').hide();
	} else {
console.log("json_data has length");
		$('#statement_chart').show();
		var	w = $('#content_container').width(),
			h = 240,
			margin = {top: 100, right: 50, bottom: 50, left: 75},
			x = d3.scale.linear().domain([0, gon.json_data['values']['y'].length-1]).range([0 + margin.left, w - margin.right]),
			y = d3.scale.linear().domain([-3,3]).range([0 + margin.top, h - margin.bottom]);

			var vis = d3.select("#statement_chart")
			    .append("svg:svg")
			    .attr("width", w)
			    .attr("height", h)

			var g = vis.append("svg:g")
			    .attr("transform", "translate(0, 250)");

			var line = d3.svg.line()
			    .x(function(d,i) { return x(i); })
			    .y(function(d) { return -1 * y(d); })

			g.append("svg:path").attr("d", line(gon.json_data['values']['y']));

			// axis lines
			g.append("svg:line")
			    .attr("x1", x(0))
			    .attr("y1", -1 * y(0))
			    .attr("x2", x(gon.json_data['values']['y'].length-1))
			    .attr("y2", -1 * y(0))
			g.append("svg:line")
	        .attr("class", "axis")
			    .attr("x1", x(0))
			    .attr("y1", -1 * y(-3))
			    .attr("x2", x(0))
			    .attr("y2", -1 * y(3))

			// line tick marks
			g.selectAll(".xTicks")
			    .data(x.ticks(gon.json_data['values']['y'].length-1))
			    .enter().append("svg:line")
			    .attr("class", "xTicks")
			    .attr("x1", function(d) { return x(d); })
			    .attr("y1", -1 * y(0))
			    .attr("x2", function(d) { return x(d); })
			    .attr("y2", -1 * y(-0.3))
			g.selectAll(".yTicks")
			    .data(y.ticks(7))
			    .enter().append("svg:line")
			    .attr("class", "yTicks")
			    .attr("y1", function(d) { return -1 * y(d); })
			    .attr("x1", x(0)-5)
			    .attr("y2", function(d) { return -1 * y(d); })
			    .attr("x2", x(0))

			// guideline - party platform score
			g.append("svg:line")
			    .attr("x1", x(0))
			    .attr("y1", -1 * (y(0) - ((y(0)-y(1)) * gon.json_data['guidelines']['party_platform_score'])))
			    .attr("x2", x(gon.json_data['values']['y'].length-1))
			    .attr("y2", -1 * (y(0) - ((y(0)-y(1)) * gon.json_data['guidelines']['party_platform_score'])))
			    .attr("style", "stroke: #0f0;stroke-dasharray: 10,6;stroke-width: 3;")

			// guideline - all party platform avg score
			g.append("svg:line")
			    .attr("x1", x(0))
			    .attr("y1", -1 * (y(0) - ((y(0)-y(1)) * gon.json_data['guidelines']['all_party_platform_avg_score'])))
			    .attr("x2", x(gon.json_data['values']['y'].length-1))
			    .attr("y2", -1 * (y(0) - ((y(0)-y(1)) * gon.json_data['guidelines']['all_party_platform_avg_score'])))
			    .attr("style", "stroke: #f00;stroke-dasharray: 13,10;stroke-width: 3;")

			// x-axis label
			g.append("svg:text")
		      .attr("class", "label")
			    .attr("x", x(gon.json_data['values']['y'].length-1)+5)
			    .attr("y", -1 * y(0))
		      .text(gon.json_data['scales']['x']['time'])
	        .attr("style", 'fill: black;')
			    .attr("dy", 4)

			// y-axis label
			g.append("svg:text")
		      .attr("class", "label")
		      .attr("text-anchor", "end")
		      .attr("x", x(0)-8)
		      .attr("y", -1 * y(3))
		      .text(gon.json_data['scales']['y']['top'])
	        .attr("style", 'fill: black;')
			    .attr("dy", 4)
			g.append("svg:text")
		      .attr("class", "label")
		      .attr("text-anchor", "end")
		      .attr("x", x(0)-8)
		      .attr("y", -1 * y(0))
		      .text(gon.json_data['scales']['y']['middle'])
	        .attr("style", 'fill: black;')
			    .attr("dy", 4)
			g.append("svg:text")
		      .attr("class", "label")
		      .attr("text-anchor", "end")
		      .attr("x", x(0)-8)
		      .attr("y", -1 * y(-3))
		      .text(gon.json_data['scales']['y']['bottom'])
	        .attr("style", 'fill: black;')
			    .attr("dy", 4)

			// title
			g.append("svg:text")
		      .attr("class", "label")
		      .attr("x", w/2)
		      .attr("y", -1 * y(6))
		      .text(gon.json_data['title']['line1'])
	        .attr("style", 'fill: black;text-anchor:middle;')
			g.append("svg:text")
		      .attr("class", "label")
		      .attr("x", w/2)
		      .attr("y", -1 * y(5))
		      .text(gon.json_data['title']['line2'])
	        .attr("style", 'fill: black;text-anchor:middle;')
			g.append("svg:text")
		      .attr("class", "label")
		      .attr("x", w/2)
		      .attr("y", -1 * y(4))
		      .text(gon.json_data['title']['line3'])
	        .attr("style", 'fill: black;text-anchor:middle;')

			// legend
			g.append("svg:line")
			    .attr("x1", x(0))
			    .attr("y1", -1 * y(-5))
			    .attr("x2", x(0)+15)
			    .attr("y2", -1 * y(-5))
			    .attr("style", "stroke: steelblue;stroke-width: 3;")
			g.append("svg:text")
		      .attr("class", "label")
		      .attr("x", x(0)+16)
		      .attr("y", -1 * y(-5))
		      .text(gon.json_data['legend']['party_statements'])
	        .attr("style", 'fill: black;')
			    .attr("dy", 4)
			g.append("svg:line")
			    .attr("x1", x(0))
			    .attr("y1", -1 * y(-6))
			    .attr("x2", x(0)+15)
			    .attr("y2", -1 * y(-6))
			    .attr("style", "stroke: #0f0;stroke-dasharray: 5,3;stroke-width: 3;")
			g.append("svg:text")
		      .attr("class", "label")
		      .attr("x", x(0)+16)
		      .attr("y", -1 * y(-6))
		      .text(gon.json_data['legend']['party_platform'])
	        .attr("style", 'fill: black;')
			    .attr("dy", 4)
			g.append("svg:line")
			    .attr("x1", x(0))
			    .attr("y1", -1 * y(-7))
			    .attr("x2", x(0)+15)
			    .attr("y2", -1 * y(-7))
			    .attr("style", "stroke: #f00;stroke-dasharray: 5,3;stroke-width: 3;")
			g.append("svg:text")
		      .attr("class", "label")
		      .attr("x", x(0)+16)
		      .attr("y", -1 * y(-7))
		      .text(gon.json_data['legend']['all_party_platform_avg'])
	        .attr("style", 'fill: black;')
			    .attr("dy", 4)
	}
}
