<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<title>dd</title>
</head>
<body>
<style>
	#btnControl {
    display: none;
}

#btnControl:checked + label > div {
    width: 70px;
    height: 74px;
}
	*{margin: 0; padding: 0;}
	.grid-container {
		display:grid;
		justify-content: center;
		grid-template-columns: repeat(3, 1fr);
		-ms-grid-columns: repeat(3, 1fr);
		grid-gap:10px;
		padding: 10px;
		background: #eee;
		
	  padding: 10px;
		
	}
	.grid-container > div {
		 
		padding: 20px 0 ;
		font-size: 30px;
		background-color: rgba(255, 255, 255, 0.8);
	}
	
	.box1 { 
  grid-column-start: 1; 
  grid-column-end: 4; 
  grid-row-start: 1; 
  grid-row-end: 3; 
}
</style>
<input type="checkbox" id="btnControl"/>
<label class="btn" for="btnControl"><div>wwwww</div></label>
<div class="grid-container">
	<div class="box1">1</div>
	<div class="box2">2</div>
	<div class="box3">3</div>
	<div class="box4">4</div>
	<div class="box5">5</div>
	<div class="box6" onclick="ajax();">6</div>
</div>

<script type="text/javascript">

	function ajax(){
		
		$.ajax({
			url : 'ajax'
	        , method : "post"
			, dataType : 'json'
			, data : {naa : "wdawda"}
			, processData : true /*querySTring make false*/
			, contentType : "application/json; charset=UTF-8"
			, success : function(data, stat, xhr) {
				alert("success");
			}
		    , error : function(xhr, stat, err) {
		    	alert("error");
		    	console.log(err);
		    }
		});
	}
</script>
</body>
</html>