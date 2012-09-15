if (gon.party_statement_chart_data && gon.json_path) {

  $.get(gon.json_path, function (data)
  {
    var margin = {top: 30, right: 10, bottom: 10, left: 50},
        width = $('#content_container').width() - margin.left - margin.right,
        height = 150 - margin.top - margin.bottom;

    var x0 = 3;

    var y = d3.scale.linear()
        .domain([-x0, x0])
        .range([0, width]);
    var x = d3.scale.ordinal()
        .domain(d3.range(data['values'].length))
        .rangeRoundBands([0, height], .2);
    var svg = d3.select("#statement_chart").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");


    svg.append("text")
        .attr("class", "x label")
        .attr("text-anchor", "end")
        .attr("y", 0)
        .attr("x", -3)
        .text(data['scales']['top'])
        .attr("style", 'fill: black;');

    svg.append("text")
        .attr("class", "x label")
        .attr("text-anchor", "end")
        .attr("y", height / 2)
        .attr("x", -3)
        .text(data['scales']['middle'])
        .attr("style", 'fill: black;');

    svg.append("text")
        .attr("class", "x label")
        .attr("text-anchor", "end")
        .attr("y", height)
        .attr("x", -3)
        .text(data['scales']['bottom'])
        .attr("style", 'fill: black;');

    svg.append("g")
        .attr("class", "x axis")
      .append("line")
        .attr("x1", 0)
        .attr("x2", width)
        .attr("y1", height/2)
        .attr("y2", height/2);

    svg.append("g")
        .attr("class", "y axis")
      .append("line")
        .attr("x1", 0)
        .attr("x2", 0)
        .attr("y1", 0)
        .attr("y2", height);

    // party platform guideline
    svg.append("g")
        .attr("class", "party_platform_guideline")
      .append("line")
        .attr("x1", 0)
        .attr("x2", width)
        .attr("y1", data['guidelines']['party_platform_score'])
        .attr("y2", data['guidelines']['party_platform_score'])
        .attr("style", 'fill: blue;');

    // all party platform avg guideline
    svg.append("g")
        .attr("class", "all_party_platform_avg_guideline")
      .append("line")
        .attr("x1", 0)
        .attr("x2", width)
        .attr("y1", data['guidelines']['all_party_platform_avg_score'])
        .attr("y2", data['guidelines']['all_party_platform_avg_score'])
        .attr("style", 'fill: red;');

  });
}
