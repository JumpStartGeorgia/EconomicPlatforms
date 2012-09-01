if (gon.economic_chart_data) {
  for (var i=0; i<gon.economic_chart_data.length; i++){
    build_economic_indicator_chart(gon.economic_chart_data[i]["div_id"], gon.economic_chart_data[i]["data"]);
  }
}

function build_economic_indicator_chart(div_id, data){
  var margin = {top: 30, right: 10, bottom: 10, left: 10},
      width = 300 - margin.left - margin.right,
      height = 150 - margin.top - margin.bottom;

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
      .attr("class", function(d, i) { return d["value_centered"] < 0 ? "bar negative" : "bar positive"; })
      .attr("x", function(d, i) { return x(Math.min(0, d["value_centered"])); })
      .attr("y", function(d, i) { return y(i); })
      .attr("width", function(d, i) { return Math.abs(x(d["value_centered"]) - x(0)); })
      .attr("height", y.rangeBand());

  svg.append("g")
      .attr("class", "x axis")
      .call(d3.svg.axis().scale(x).orient("top").ticks(7));

  svg.append("g")
      .attr("class", "y axis")
    .append("line")
      .attr("x1", x(0))
      .attr("x2", x(0))
      .attr("y1", 0)
      .attr("y2", height);

  $('svg rect').tipsy({ 
      gravity: 'n',
      html: true,
      offset: y.rangeBand(),
      title: function() { 
        var d = this.__data__;
        return '<strong>' + d["political_party"] + '</strong> - ' + d["value_explaination"]; 
      }
    });
      
}
