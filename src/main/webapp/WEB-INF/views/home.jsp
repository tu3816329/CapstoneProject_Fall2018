<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<html>
<head>
	<title>Home</title>
	<link href="${pageContext.servletContext.contextPath}/resources/css/admin.css" rel="stylesheet">
</head>
<body>
	<h1>Math Formulas</h1>
	<div class="dropdown div-drop">
		<button class="btn btn-default dropdown-toggle div-btn"
			type="button" data-toggle="dropdown">
			Chọn lĩnh vực <span class="caret"></span>
		</button>
		<ul class="dropdown-menu div-drop-menu">
			<a:forEach items="${DIVISIONS}" var="dvs">
				<li><a href="${dvs.id}">${dvs.name}</a></li>
			</a:forEach>
			<li><a href="add-division">Thêm lĩnh vực...</a></li>
		</ul>
	</div>
	<div class="dropdown cat-drop">
	<button class="btn btn-default dropdown-toggle cat-btn"
			type="button" data-toggle="dropdown">
			Chọn loại <span class="caret"></span>
	</button>
	<ul class="dropdown-menu cat-drop-menu">
	</ul>
	</div>
	<input type="hidden" id="catId">
	<button class="btn btn-warning" id="btnUpload">Add image</button>
	<div id="imgDiv" style="margin-bottom: 10px; display: none">
		Image URL <input type="text" id="imgUrl" size="40">
		<button id="addImg" class="btn btn-success">Add</button>
		<button id="cancelAddImg" class="btn btn-danger">Cancel</button>
	</div>
	<button class="btn btn-primary" id="btnSave">Save Formula</button>
	<input type="file" id="uploadImg" style="display: none">
		
	<textarea id="input"></textarea>
	
	<!-- My Javscript -->
	<jsp:include page="admin_js.jsp"></jsp:include>
</body>
</html>
