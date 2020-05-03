$(document).ready(function() {
	$.ajax({
	    url: "get_tweets.htm",
	    type: "GET",
	    dataType: 'json',
	    async:false,//synchronous request. Default value is true 
	    timeout:10000,//default timeout 20000
	    success: function (data) {
	    	console.log(data);
	    	for (var key in data.data) {
	    		  if (data.data.hasOwnProperty(key)) {
	    		    var val = data.data[key];
	    		   // console.log(val);
	    		    console.log(val["displayId"]);
	    		    if(val["photo"] == "na")
	    		    	{
	    		    	imgsrc = "resources/assets/no-image.png";
	    		    	}
	    		    else
	    		    	{
	    		    	imgsrc = val["photo"];
	    		    	}
	    		    $(".rendertweets").append("<div class='col-sm-4  col-md-4 divstyle' id='"+val['displayId']+"'><div class='divmargin'>" +
	    		    		"<div id='tweetedusername'><p>@"+val["accountId"]+"<span id='time'>"+val["displayCreatedAt"]+"</span></p></div>" +
	    		    		"<div id='tweettext'><p>"+val["tweetText"]+"</p></div>" +
	    		    		"<div id='tweetimage'><img src='"+imgsrc+"' class='img-responsive' /></div>" +
	    		    		"<div id='divfooter'><span id='heartutf'>&#x2661;</span><span id='likes'>"+val["likes"]+"</span>" +
	    		    		"<span id='Approve' class='generalstyle'><button id='publish' value="+val['displayId']+" onclick='Changestatus(this)'>Approve</button></span>" +
	    		    		"<span id='Reject' class='generalstyle'><button id='unpublish' value="+val['displayId']+" onclick='Changestatus(this)'>Reject</button></span></div></div></div>");
	    		  }
	    		  
	    		}
	 
	     },error: function (jqXHR, textStatus, errorThrown) {  console.log(textStatus);console.log(errorThrown);  }
	    });
	console.log("process started");

} ); 
function Changestatus(status)
{
	console.log(status.id);
	var tweetstatusjson = '{"statuschange":[{"tweetID":"","tweetstatus":""}]}';
	console.log("ChangeStatus oF ID  >>>"+status.value);
	var parsedjson = JSON.parse(tweetstatusjson);
	 parsedjson.statuschange[0]['tweetID'] =status.value;
	 parsedjson.statuschange[0]['tweetstatus'] = status.id; 
	jsonstring = JSON.stringify(parsedjson);
	if(status.id =="publish")
		{
		$("#"+status.value).remove();
		}
	//console.log(jsonstring);
	$.ajax({
	    url: "changestatus.htm",
	    type: "POST",
	    data: {data:jsonstring},
	    //dataType: 'json',
	    async:false,//synchronous request. Default value is true 
	    timeout:10000,//default timeout 20000
	    success: function (data) {
	// console.log(data);
	    	
	     },error: function (jqXHR, textStatus, errorThrown) {  console.log(textStatus);console.log(errorThrown);  }
	    });
	
}
function imgError(image) {
    image.onerror = "";
    image.src = "resources/assets/transparent.png";
    return true;
}

