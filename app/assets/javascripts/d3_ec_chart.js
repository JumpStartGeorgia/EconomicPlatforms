if (gon.economic_chart_data) {
  for (var i=0; i<gon.economic_chart_data.length; i++){
    build_economic_indicator_chart(gon.economic_chart_data[i]["div_id"], gon.economic_chart_data[i]["data"]);
  }  

  // hide legend by default
	$('div#legend_content').hide();
	$('#legend').click(function () {
    $('div#legend_content').slideToggle(200);	   	      
   });
/*
  // show political parties by default
	$('div#political_party_scales_content').show();
	$('#political_party_scales').click(function () {
    $('div#political_party_scales_content').slideToggle(200);	   	      
   });

  // make the indicator scales hidden
	$('div#indicator_scales_content').hide();
	$('#indicator_scales').click(function () {
    $('div#indicator_scales_content').slideToggle(200);	   	      
   });
*/
}

function build_economic_indicator_chart(div_id, data){
  var margin = {top: 30, right: 10, bottom: 10, left: 10},
      width = 300 - margin.left - margin.right,
      height = 150 - margin.top - margin.bottom,
      bar_height = height/gon.number_parties - 5;
      

  var x0 = 3;

  var x = d3.scale.linear()
      .domain([-x0, x0])
      .range([0, width]);
  var y = d3.scale.ordinal()
      .domain(d3.range(data.length))
      .rangeRoundBands([0, height], .2);

  var svg = d3.select("#" + div_id).append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  svg.selectAll(".bar")
      .data(data)
    .enter().append("rect")
      .attr("style", function(d, i) { return "fill:" + d["color"]; })
      .attr("x", function(d, i) { 
        // if value is 0, start it at -0.5
        if (d["value_centered"] == 0)
          return (x(1)-x(0))/2+x(-1);
        else
          return x(Math.min(0, d["value_centered"])); 
      })
      .attr("y", function(d, i) { return y(i); })
      .attr("width", function(d, i) { 
        // if value is 0, have it go to 0.5
        if (d["value_centered"] == 0)
          return x(1)-x(0);
        else
          return Math.abs(x(d["value_centered"]) - x(0)); 
      })
      .attr("height", bar_height);

/*
  svg.append("g")
      .attr("class", "x axis")
      .call(d3.svg.axis().scale(x).orient("top").ticks(7));
*/
  svg.append("text")
      .attr("class", "x label")
      .attr("text-anchor", "start")
      .attr("x", 0)
      .attr("y", 0)
      .text("left");

  svg.append("text")
      .attr("class", "x label")
      .attr("text-anchor", "middle")
      .attr("x", width / 2)
      .attr("y", 0)
      .text("center");

  svg.append("text")
      .attr("class", "x label")
      .attr("text-anchor", "end")
      .attr("x", width)
      .attr("y", 0)
      .text("right")
      .attr("style", 'fill: black;');

  svg.append("g")
      .attr("class", "y axis")
    .append("line")
      .attr("x1", x(0))
      .attr("x2", x(0))
      .attr("y1", 0)
      .attr("y2", height);

  $('svg rect').tipsy({
      gravity: $.fn.tipsy.autoBounds(60, 'nw'),
      html: true,
      opacity: 1,
      offset: bar_height,
      title: function() { 
        var d = this.__data__;
        return '<strong>' + d["political_party"] + '</strong> - ' + d["value_explaination"];
      }
    });
      
}
