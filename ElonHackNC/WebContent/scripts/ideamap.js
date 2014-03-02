/**
 * 
 */
$(document).ready(function() {
	
  var ideaString = $("#bubbles").text();
  //console.log(ideaArray[i].substring(2,3));
  var ideaArray = ideaString.split(";");
  var nodes = [];
  var edges = [];
  
  
  for (var i = 0; i < ideaArray.length - 1; i++)
  { 
	  var one = ideaArray[i].substring(0,1);
	  var two = ideaArray[i].substring(6);
	  nodes[i]={id: parseInt(one), label: two};
	  console.log(nodes[i]);
  }
  
  for (var i = 0; i < ideaArray.length - 1; i++)
  { 
  if(ideaArray[i].substring(3,4) !== "0"){
	  var one = ideaArray[i].substring(0,1);
	  var three = ideaArray[i].substring(3,4);
	  edges[edges.length] = {from: parseInt(three), to: parseInt(one)};
	 // console.log(edges[i]);
  }
  }
  
  // create a graph
  var container = document.getElementById('mygraph');
  var data = {
    nodes: nodes,
    edges: edges
  };
  var options = {
		  nodes: {
	    color: {
	        background: 'purple',
	        border: 'gold',
	        highlight: {
	          background: 'red',
	          border: 'purple'
	        }
	      }, fontColor: 'gold'
  }
  };
  var graph = new vis.Graph(container, data, options);
  
  
  graph.on('select', function(properties) {
	  $("#explore").removeAttr("disabled");
	  console.log(properties);
	  });
  
   $("#explore").click(function(){
    for (var i = 0; i < nodes.length; i++) {
    	console.log(nodes[i].id);
        if (nodes[i].id === parseInt(graph.getSelection().nodes[0])){
            
        }
    }
  });
   
   $("#test").click(function(){
	   console.log($("#in").val());
	   console.log(nodes[nodes.length-1]);
	   var temp;
	   if(graph.getSelection()){
		   for (var i = 0; i < nodes.length; i++) {
		    	console.log(nodes[i].id);
		        if (nodes[i].id === parseInt(graph.getSelection().nodes[0])){
		        	console.log(nodes[i].id);
		        	temp = nodes[i].id;
		        }
		    }
		   console.log(temp);
		   edges[edges.length] = {from: parseInt(temp), to: parseInt(nodes.length+1)};
	   }
	    nodes[nodes.length]={id: nodes.length+1, label: $("#in").val()};
	    
	    console.log(nodes[nodes.length-1]);
	    console.log(edges[nodes.length-1]);
	    
	    //graph = new vis.Graph(container, data, options);
	    
	    graph = new vis.Graph(container, data, options);
	  });
  
});
