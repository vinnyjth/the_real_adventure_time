
$.getJSON('/pages/graph').done(function(data){

var width = $('.graph').width();
var height = $('.graph').height();var color = d3.scale.category20();

var force = d3.layout.force()
    .charge(-120)
    .linkDistance(100)
    .size([width, height]);

var svg = d3.select(".graph").append("svg")
    .attr("width", width)
    .attr("height", height);

  force
      .nodes(data.nodes)
      .links(data.links)
      .start();

  svg.append("svg:defs").selectAll("marker")
    .data([1]).enter()
    .append("svg:marker")
    .attr("id", 'endMarker')
    .attr("viewBox", "0 -5 10 10")
    .attr("refX", 15)
    .attr("refY", -1.5)
    .attr("markerWidth", 3)
    .attr("markerHeight", 3)
    .attr("orient", "auto")
  .append("svg:path")
    .attr("d", "M0,-5L10,0L0,5");

  var link = svg.selectAll(".link")
      .data(data.links)
    .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", 7)
      .attr("marker-end", "url(#endMarker)");

   var node = svg.selectAll(".node")
      .data(data.nodes)
    .enter().append("circle")
      .attr("class", "node")
      .attr("r", 10)
      .style("fill", function(d) { return color(d.group); })
      .call(force.drag);

  node.append("title")
      .text(function(d) { return d.name; });

  force.on("tick", function() {
    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node.attr("cx", function(d) { return d.x; })
        .attr("cy", function(d) { return d.y; });
  });
});