<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
 <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css">
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${rows}. </P>
<c:forEach items="${rows}" var="item"  >
	${item.idtestt}
</c:forEach>

<textarea name="content" id="content" rows="22" style="width:645px;">
 </textarea>

<div class="row">
	<div class="col-md-2">2</div>
	<div class="col-md-2">2</div>
	<div class="col-md-2">2</div>
	<div class="col-md-2">2</div>
	<div class="col-md-2">2</div>
</div>
<script type="text/javascript">

       var oEditors = [];

       nhn.husky.EZCreator.createInIFrame({

       oAppRef: oEditors,

       elPlaceHolder: "content", //textarea에서 지정한 id와 일치해야 합니다.

       sSkinURI: "${contextPath}/smarteditor/SmartEditor2Skin.html",

       fCreator: "createSEditor2"

       });

  </script>



</body>
</html>
