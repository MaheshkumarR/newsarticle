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
<body>
<div class="container-fluid inversedata" style="padding: 2% 3%;">
	<div class="text pull-left">Search for Article </div><br/>
	<input type="text" id="searchtext" placeholder="type your search"/>
	<input type="button" id="searcharticle" value="Search">
	</div>
<div class="container-fluid inversedata" style="padding: 1% 3%;">
	<div class="row">

		<div class="col-lg-10 col-md-10">
			<table id="tabledata" class="table" style="width:100%">
				<thead>
					<tr>
						<th>Published date</th>
						<th>Link</th>
						<th>Text</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
<script>
var filtertable;
$("#searcharticle").click(function()
		{
			searchval = $("#searchtext").val();
			console.log(searchval);
			resettable(searchval);
		})
$(document).ready(function() {	
	filtertable = $('#tabledata').DataTable(
			 {
				 "searching": false,
			        ajax: {
			            url: 'scrapweb/signzy',
			         },
			         columns: [
				            {
				            	"width": "20%",
				                data: "date",
				                "bSearchable": false,
				                "bSortable": false,
				                "mRender": function(data, type, full) {
				                	console.log(data);
				                	return "<span>"+data+"</span>";
				              
				                }
				            }, {
				            	"width": "30%",
				                data: "link",
				                "bSortable": true,
				                render: function(data, type, full, meta) {

				                	return "<a href="+data+">"+data+"</a>";
				                },
				            }, {
				            	"width": "50%",
				                data: "article",
				                render: function(data, type, full, meta) {
				                	return "<p>"+data+"</p>";
				                }
				            	},
				                ]
				            });
});
function resettable(filterval)
{
	filtertable.ajax.url('scrapweb/'+filterval).load();
	
}
</script>
</html>