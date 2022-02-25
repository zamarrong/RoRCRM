// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require bootstrap-datetimepicker
//= require locales/bootstrap-datetimepicker.es
//= require typeahead.bundle.min
//= require_tree .
 	google.load('visualization', '1.0', {'packages':['corechart']});

	// Set a callback to run when the Google Visualization API is loaded.
	google.setOnLoadCallback(drawChart);

	// Callback that creates and populates a data table,
	// instantiates the pie chart, passes in the data and
	// draws it.
	
function chartsReady(){
  var dt= new Date();
  var end_date = dt.getFullYear() + '-' + (dt.getMonth() + 1) + '-' +dt.getDate();
  dt.setMonth(dt.getMonth()-1);
  var start_date = dt.getFullYear() + '-' + (dt.getMonth() + 1) + '-' +dt.getDate();
  drawChart(start_date, end_date, 'Desempeño mensual');
  $('#monthly-performance').click(function(){
    var dt= new Date();
    var end_date = dt.getFullYear() + '-' + (dt.getMonth() + 1) + '-' +dt.getDate();
    dt.setMonth(dt.getMonth()-1);
    var start_date = dt.getFullYear() + '-' + (dt.getMonth() + 1) + '-' +dt.getDate();
    drawChart(start_date, end_date, 'Desempeño mensual');
  });
  $('#trimonthly-performance').click(function(){
    var dt= new Date();
    var end_date = dt.getFullYear() + '-' + (dt.getMonth() + 1) + '-' +dt.getDate();
    dt.setMonth(dt.getMonth()-3);
    var start_date = dt.getFullYear() + '-' + (dt.getMonth() + 1) + '-' +dt.getDate();
    drawChart(start_date, end_date, 'Desempeño trimestral');
  });
  $('#anual-performance').click(function(){
    var dt= new Date();
    var end_date = dt.getFullYear() + '-' + (dt.getMonth() + 1) + '-' +dt.getDate();
    dt.setMonth(dt.getMonth()-12);
    var start_date = dt.getFullYear() + '-' + (dt.getMonth() + 1) + '-' +dt.getDate();
    drawChart(start_date, end_date, 'Desempeño anual');
  });
}

function drawChart(start_date, end_date, chart_title) {
    if($('.employees.show').length > 0){
      $.ajax({
        method: "GET",
        url: "/employees/"+$('#employee-id').html()+"/performance.json",
        data: { start_date: start_date, end_date: end_date}
      })
        .done(function( msg ) {

        for(var i=0; i<msg['data'].length; i++){
          msg['data'][i][0] = new Date(msg['data'][i][0]);
        }
          
       msg['data'].unshift(['Fecha','Cotizaciones hechas','Ventas cerradas']);
       

		// Create the data table.
		 var data = google.visualization.arrayToDataTable(msg['data']);

     var formatter = new google.visualization.NumberFormat({decimalSymbol: '.',groupingSymbol: ',', negativeColor: 'red', negativeParens: true, prefix: '$ '});
      formatter.format(data, 1);
      var formatter = new google.visualization.NumberFormat({decimalSymbol: '.',groupingSymbol: ',', negativeColor: 'red', negativeParens: true, prefix: '$ '});
      formatter.format(data, 2);

        var options = {
          title: chart_title,
          hAxis: {title: 'Fecha',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0, format: '$#,###'}
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
        chart.draw(data, options);
         });

      }
	}

$(document).ready(chartsReady);
$(document).on('turbolinks:load', chartsReady);