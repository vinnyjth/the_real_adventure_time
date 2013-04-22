
$.getJSON('/pages/graph').done(function(data){

var width = $('.graph').width();
var height = $('.graph').height();var color = d3.scale.category20();

var force = d3.layout.force()
    .charge(-1000)
    .linkDistance(100)
    .size([width, height]);

var svg = d3.select(".graph").append("svg")
    .attr("width", width)
    .attr("height", height)
    .attr("viewBox", "0 0 " + width + " " + height )
    .attr("preserveAspectRatio", "xMidYMid meet")
    .attr("pointer-events", "all")
    .call(d3.behavior.zoom().on("zoom", redraw));


var vis = svg
  .append('svg:g');

  force
      .nodes(data.nodes)
      .links(data.links)
      .start();

  function redraw() {
      vis
      .attr("transform",
      "translate(" + d3.event.translate + ")"
      + " scale(" + d3.event.scale + ")");
  }
  vis.append("svg:defs").selectAll("marker")
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

  var link = vis.selectAll(".link")
      .data(data.links)
      .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", 7)
      .attr("marker-end", "url(#endMarker)");

  var node = vis.selectAll(".g")
      .data(data.nodes)
      .enter().append("svg:g")
      .attr("class", "node")
      .on("click", function(d) {window.location.href = "/pages/" + d.id})
      .call(force.drag);

  node.append("circle")
      .attr("class", "node")
      .attr("r", function(d) { return d.rating + 10; })
      .style("fill", function(d) { return d.color; }); 

  node.append("title")
      .text(function(d) { return d.name; });

  node.append("text")
    .attr("x", 12)
    .attr("dy", ".35em")
    .attr("class", "graph-text")
    .text(function(d) { return d.name; });

  node.append("svg:a")
    .attr("xlink:href", "www.google.com");  

  force.on("tick", function() {
    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node
        .attr("transform", function(d) { 
            return "translate(" + d.x + "," + d.y + ")"; });
  });
});