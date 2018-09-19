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
		
		<!-- MathJax -->
		<script type="text/javascript" 
				src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/latest.js?
					config=TeX-MML-AM_CHTML" async></script>
	</head>
	<body>
		<div>${FORMULA}</div>
	</body>
</html>