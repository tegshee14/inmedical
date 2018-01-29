<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
 <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css">

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


<div class="row">
	<div class="col-md-2">2</div>
	<div class="col-md-2">2</div>
	<div class="col-md-2">2</div>
	<div class="col-md-2">2</div>
	<div class="col-md-2">2</div>
</div>



</body>
</html>
