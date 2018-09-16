<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Home 2</title>
		
		<style>
			body, p {
				margin: 0;
			}
		</style>
		
	<!-- Jquery -->
		<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/jquery-3.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/jquery-3.2.1.min.js"></script>
		
		<!-- jqMath -->
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=UnifrakturMaguntia">
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/mathscribe/jqmath-0.4.3.css">
		
		<%-- <script src="${pageContext.servletContext.contextPath}/resources/mathscribe/jquery-1.4.3.min.js"></script> --%>
		<script src="${pageContext.servletContext.contextPath}/resources/mathscribe/jqmath-etc-0.4.6.min.js" charset="utf-8"></script>
	</head>
	<body>
		<div>${FORMULA}</div>
	</body>
</html>