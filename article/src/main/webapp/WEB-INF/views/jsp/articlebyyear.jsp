<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>News Article</title>
	<script src="resources/js/jquery.min.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/jquery.dataTables.min.js"></script>
	<script src="resources/js/dataTables.bootstrap.min.js"></script>
	<link rel="stylesheet" href="resources/css/bootstrap.min.css">
</head>
<style>
.loader{
  position: fixed;
  left: 0px;
  top: 0px;
  width: 100%;
  height: 100%;
  z-index: 9999;
  background: url('resources/assets/200.gif') 
              50% 50% no-repeat rgb(249,249,249);
  display:none;
}
</style>
<body>
<div class="container-fluid inversedata" style="padding: 2% 3%;">
	<div class="text pull-left" style="margin:5px;">Top 2010 News Article</div><br/>
	<select id="month">
  	<option value="Jan">January</option>
 	 <option value="Feb">Feb</option>
  	<option value="Mar">Mar</option>
  	<option value="Apr">April</option>
  	<option value="May">May</option>
  	<option value="Jun">June</option>
  	<option value="Jul">July</option>
  	<option value="Aug">August</option>
  	<option value="Sep">September</option>
  	<option value="Oct">October</option>
  	<option value="Nov">November</option>
  	<option value="Dec">December</option>
	</select>
	<input type="button" id="searcharticle" value="Submit">
	</div>
	<div class="container-fluid inversedata" style="padding: 1% 3%;">
	<div class="row">
		<div class="col-lg-10 col-md-10">
			<table id="tabledata" class="table" style="width:100%">
				<thead>
					<tr>
						<th>Link</th>
						<th>Text</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			
			</table>
				<div class="loader"></div>
		</div>
	</div>
	
</div>
</body>
<script>
var filtertable;
$("#searcharticle").click(function()
		{
			searchval = $("#month").val();
			console.log(searchval);
			resettable(searchval);
		});
$(document).ready(function() {	
	filtertable = $('#tabledata').DataTable(
			 {
				 "searching": false,
			        ajax: {
			            url: 'getarticles/Jan',
			         },

			         columns: [
				            {
				            	"width": "20%",
				                data: "link",
				                "bSearchable": false,
				                "bSortable": false,
				                "mRender": function(data, type, full) {
				                	return "<a href="+data+">"+data+"</a>";
				              
				                }
				            }, {
				            	"width": "30%",
				                data: "article",
				                "bSortable": true,
				                render: function(data, type, full, meta) {

				                	return "<span>"+data+"</span>";
				                },
				            },
				                ]
				            });
});
function resettable(filterval)
{
	//$(".loader").show();
	filtertable.ajax.url('getarticles/'+filterval).load(function()
			{
			$(".loader").hide();
			});
	
	
}
</script>
</html>