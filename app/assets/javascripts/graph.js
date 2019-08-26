function set_the_div_for_graphs(graphs_ids=[]){
        var table_str ='';
        var table = document.getElementById('chart_table');
        table.innerHTML ='';
        for(var i = 0; i < graphs_ids.length; i++){
                        table_str = table_str+"<div class='col-md-6 graph_main_div'><div class= 'chart-heading'id= 'chart-title"+graphs_ids[i]+"'></div><div class='graph_li' id='chart"+graphs_ids[i]+"' ></div></div>"

        }
        table.innerHTML = table.innerHTML + table_str;
        for(var i = 0; i < graphs_ids.length; i++){
                execute_graph_data(graphs_ids[i]);
        }
}
function execute_graph_data(id){
  if (id !=null){
    $.ajax({
      url: '/projects/'+id+'/graph',
      type: 'get',
      dataType: 'json',
      success: function (response) {
        var data = response.data;
        if(data.length <=0 || data == null || data == [])
          $('chart'+id).closest('div').remove();
        else
          get_graph_html(response);
      },
      error: function(error) {
        $('chart'+id).closest('li').remove();
      }
    });
  }
}
function get_graph_html(graph){
  // Load the Visualization API and the piechart package.
  google.charts.load('current', {'packages':['corechart']});

  // Set a callback to run when the Google Visualization API is loaded.
  google.charts.setOnLoadCallback(drawChart);

  // Callback that creates and populates a data table, 
  // instantiates the pie chart, passes in the data and
  // draws it.
  function drawChart() {

    // Create the data table.
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Status');
    data.addColumn('number', 'Count');
    //debugger
    data.addRows(graph.data);

    // Set chart options
    var options = {'title': graph.title,
                   'width':400,
                   'height':300};

    // Instantiate and draw our chart, passing in some options.
    var chart = new google.visualization.PieChart(document.getElementById('chart'+graph.id));
    chart.draw(data, options);
  }  
}