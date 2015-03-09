// Tickets per day of week
var ready;
ready = function() {
  
  //
  // Setup Tickets per day of week chart
  //
  if (gon.day_labels) { var labels = gon.day_labels; } 
  if (gon.day_values) { var values = gon.day_values; }
  var lineChartData = {
  	labels : labels,
  	datasets : [
  		{
  			label: "Tickets per day of week",
  			fillColor : "rgba(220,220,220,0.2)",
  			strokeColor : "rgba(220,220,220,1)",
  			pointColor : "rgba(220,220,220,1)",
  			pointStrokeColor : "#fff",
  			pointHighlightFill : "#fff",
  			pointHighlightStroke : "rgba(220,220,220,1)",
  			data : values,  		
      }
  	]
  };
	var tickets_wday_ctx = document.getElementById("tickets_dayofweek").getContext("2d");
	window.myLine = new Chart(tickets_wday_ctx).Line(lineChartData, {
		responsive: true
	});
  
  //
  // Setup Tickets per month chart
  //
  if (gon.mth_labels) { var mth_labels = gon.mth_labels; } 
  if (gon.mth_values) { var mth_values = gon.mth_values; }
  var tickets_per_month_lineChartData = {
  	labels : mth_labels,
  	datasets : [
  		{
  			label: "Tickets per month",
  			fillColor : "rgba(220,220,220,0.5)",
  			strokeColor : "rgba(220,220,220,1)",
  			pointColor : "rgba(220,220,220,1)",
  			pointStrokeColor : "#fff",
  			pointHighlightFill : "#fff",
  			pointHighlightStroke : "rgba(220,220,220,1)",
  			data : mth_values,  	
      }
  	]
  };
	var tickets_wmth_ctx = document.getElementById("tickets_permonth").getContext("2d");
	window.myTBMLine = new Chart(tickets_wmth_ctx).Bar(tickets_per_month_lineChartData, {
		responsive: true
	});
};

$(document).ready(ready);
$(document).on('page:load', ready);