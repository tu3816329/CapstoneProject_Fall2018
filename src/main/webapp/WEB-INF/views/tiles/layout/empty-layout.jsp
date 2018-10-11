<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html>
	<head>
		<title><tiles:getAsString name="title" /></title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="icon" type="image/png"
			href="${pageContext.servletContext.contextPath}/resources/login/images/icons/favicon.ico" />
		
		<link rel="stylesheet" type="text/css"
			href="${pageContext.servletContext.contextPath}/resources/login/vendor/bootstrap/css/bootstrap.min.css">
		
		<link rel="stylesheet" type="text/css"
			href="${pageContext.servletContext.contextPath}/resources/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
		
		<link rel="stylesheet" type="text/css"
			href="${pageContext.servletContext.contextPath}/resources/login/fonts/iconic/css/material-design-iconic-font.min.css">
		
		<link rel="stylesheet" type="text/css"
			href="${pageContext.servletContext.contextPath}/resources/login/vendor/animate/animate.css">
		
		<link rel="stylesheet" type="text/css"
			href="${pageContext.servletContext.contextPath}/resources/login/vendor/css-hamburgers/hamburgers.min.css">
		
		<link rel="stylesheet" type="text/css"
			href="${pageContext.servletContext.contextPath}/resources/login/vendor/animsition/css/animsition.min.css">
		
		<link rel="stylesheet" type="text/css"
			href="${pageContext.servletContext.contextPath}/resources/login/vendor/select2/select2.min.css">
		
		<link rel="stylesheet" type="text/css"
			href="${pageContext.servletContext.contextPath}/resources/login/vendor/daterangepicker/daterangepicker.css">
		
		<link rel="stylesheet" type="text/css"
			href="${pageContext.servletContext.contextPath}/resources/login/css/util.css">
		<link rel="stylesheet" type="text/css"
			href="${pageContext.servletContext.contextPath}/resources/login/css/main.css">
		
	</head>
	<body style="zoom: 1">
		<tiles:insertAttribute name="body"/>
		
		
		<script
			src="${pageContext.servletContext.contextPath}/resources/login/vendor/jquery/jquery-3.2.1.min.js"></script>
		
		<script
			src="${pageContext.servletContext.contextPath}/resources/login/vendor/animsition/js/animsition.min.js"></script>
		
		<script
			src="${pageContext.servletContext.contextPath}/resources/login/vendor/bootstrap/js/popper.js"></script>
		<script
			src="${pageContext.servletContext.contextPath}/resources/login/vendor/bootstrap/js/bootstrap.min.js"></script>
		
		<script
			src="${pageContext.servletContext.contextPath}/resources/login/vendor/select2/select2.min.js"></script>
		
		<script
			src="${pageContext.servletContext.contextPath}/resources/login/vendor/daterangepicker/moment.min.js"></script>
		<script
			src="${pageContext.servletContext.contextPath}/resources/login/vendor/daterangepicker/daterangepicker.js"></script>
		
		<script
			src="${pageContext.servletContext.contextPath}/resources/login/vendor/countdowntime/countdowntime.js"></script>
		
		<script
			src="${pageContext.servletContext.contextPath}/resources/login/js/main.js"></script>
	</body>
</html>