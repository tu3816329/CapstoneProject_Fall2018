<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>

<style>
	#lessons {
		opacity: 0;
	}
	
	.lesson-item .fa {
		font-size: 18px;
	}

	.lesson-item h4 {
		font-weight: bold;
	}

	.fa-pencil-square-o, .fa-arrow-right {
		float: right;
		color: #ab0800;
		margin-right: 15px;
	}
	
	.lesson-item {
		margin-bottom: 10px;
		padding: 1em;
		color: #555;
	}
	
	#add-lesson {
		float: right;
		border: none;
		background: #ab0800;
		border-radius: 0
	}
	
	/* Loading animation */
	.lds-dual-ring {
		display: none;
		width: 100px;
		height: 100px;
		margin: auto;
		position: absolute;
		top: 80px;
		left: 50%;
		transform: translateX(-50%);
	}

	.lds-dual-ring:after {
	content: " ";
	display: block;
	width: 100px;
	height: 100px;
	margin: 1px;
	border-radius: 50%;
	border: 5px solid #ab0800;
	border-color: #ab0800 transparent #ab0800 transparent;
	animation: lds-dual-ring 1.2s linear infinite;
	}
	@keyframes lds-dual-ring {
		0% {
			transform: rotate(0deg);
		}
		100% {
			transform: rotate(360deg);
		}
	}
</style>

<input type="hidden" value="${CAT.divisionId.divisionName}" id="divName">
<input type="hidden" value="${CAT.categoryName}" id="catName">
<input type="hidden" value="${CAT.id}" id="catId">
<div id="lessons">
	<a:forEach items="${LESSONS}" var="l">
		<div class="lesson-item">
			<a href="show-mathforms?lessonId=${l.id}">
				<i class="fa fa-arrow-right" aria-hidden="true"></i>
			</a>
			<a href="edit-lesson?lessonId=${l.id}">
				<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
			</a>
			<h4 style="margin-bottom: 10px">${l.lessonTitle}</h4>
			${l.lessonContent}
		</div>
	</a:forEach>
</div>
<div class="lds-dual-ring"></div>

<script>
	$(document).ready(function() {
		$('.lds-dual-ring').css('display', 'block');
		var divisionName = $('#divName').val();
		var categoryName = $('#catName').val();
		var categoryId = $('#catId').val();
		$('h2.w3_inner_tittle').text('Công thức ' + categoryName);
		$('.w3l_agileits_breadcrumbs_inner>ul').append($('<li>')
													.append(divisionName + ' ')
													.append('<span>«</span>')
												)
												.append($('<li>').append(categoryName)
												);
		
		$('h2.w3_inner_tittle')
			.append($('<a id="add-lesson" href="add-new-lesson?categoryId=' + categoryId + 
						'" class="btn btn-warning" style="float: right">')
				.append('Thêm Công Thức')
			);
		
		setTimeout(function() {
			$('.lds-dual-ring').css('display','none');
			$('#lessons').css('opacity', '1');
		}, 1000);
	});
</script>