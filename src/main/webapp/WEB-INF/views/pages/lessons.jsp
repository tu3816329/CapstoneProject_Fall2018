<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

<style>
	#category, #lessons {
		opacity: 0;
	}

    .cat-item {
        display: grid;
        grid-template-columns: 22% 77.5%;
        grid-column-gap: 0.5%;
        height: 156px;
        border-bottom: .125rem solid #ddd;
		padding-bottom: 15px;
        margin-bottom: 20px;
    }

    .cat-image {
		text-align: center;
        background: #ccc;
        border: 2px solid #fff;
    }
    
    .cat-image img {
		max-width: 100%;
		max-height: 100%;
    }

    .cat-detail {
        padding: 10px 0 0 5px;
    }

	.cat-title {
		padding-right: 10px;
	}

    .cat-title h3 {
        margin-bottom: 5px;
    }

    .cat-title>h3>a:first-child {
        text-decoration: none;
        color: #333;
        transition: 0.5s;
        font-weight: bold;
        font-size: 21px;
    }

    .cat-title a:hover {
        color: #45a3e5;
    }

    .cat-title span {
        color: #757575;
        font-weight: bold;
        font-size: 15px;
    }

	.cat-image {
		background: #ccc;
		text-align: center;
	}

    .fas {
        font-size: 19px;
    }
	
	.lesson-item .fa {
		font-size: 18px;
	}

	.lesson-item h4 {
		font-weight: bold;
	}

	.fa-pencil-square-o, .fa-times {
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
		border-radius: 0;
		color: white;
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
<div id="category">
	<div class="cat-item">
	    <div class="cat-image">
			<input id="imgFile" name="imageFile" type="file" class="form-control-file" accept="image/*" style="display: none">
			<input type="hidden" value="${CAT.categoryIcon}" class="cat-image">
			<img id="preview" style="display: none" src="" alt="avatar preview" width="150px" height="150px">
            <a:if test="${CAT.categoryIcon ne null}">
	        	<img class="img" src="${pageContext.servletContext.contextPath}/load-photo?categoryId=${CAT.id}" alt="">
	        </a:if>
	    </div>
	    <div class="cat-detail">
            <div class="cat-title">
				<h3>
					<a href="#">${CAT.categoryName}</a>
					<a href="add-new-lesson?categoryId=${CAT.id}" class="btn" id="add-lesson">
						<i class="fas fa-plus-circle"></i> Thêm công thức
					</a>
				</h3>
				
	            <span>${fn:length(LESSONS)} Công thức</span>
	        </div>
	    </div>
    </div>
</div>
<div id="lessons">
	<a:forEach items="${LESSONS}" var="l">
		<div class="lesson-item">
			<a href="delete-lesson?lessonId=${l.id}&categoryId=${l.categoryId.id}">
				<i class="fas fa-times"></i>
			</a>
			<a href="edit-lesson?lessonId=${l.id}">
				<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
			</a>
			<h4 style="margin-bottom: 10px"><a href="show-mathforms?lessonId=${l.id}">${l.lessonTitle}</a></h4>
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
		// $('h2.w3_inner_tittle').text('Công thức ' + categoryName);
		$('.w3l_agileits_breadcrumbs_inner>ul').append($('<li>')
													.append(divisionName + ' ')
													.append('<span>«</span>')
												)
												.append($('<li>')
													.append(categoryName + ' ')
													.append('<span>«</span>')
												)
												.append($('<li>').append('Công thức'));
		
		if ($('.cat-image').has('img').length) {
            $('.cat-image').css('background','#fff');
        }
		setTimeout(function() {
			$('.lds-dual-ring').css('display','none');
			$('#lessons, #category').css('opacity', '1');
		}, 1000);
	});

	$('.cat-image').click(function(){
		$('#imgFile').click();
	});

	$("#imgFile").change(function () {
		$(".img").hide();
		readImage();
	});

	function readImage() {
		var preview = document.getElementById('preview');
		var file    = document.querySelector('input[type=file]').files[0];
		
		var reader  = new FileReader();

		if(file != undefined) {
			if(file.type.match(/image.*/)) {
				reader.onload = function () {
					formData = new FormData();
					formData.append('imageFile', file);
					$.ajax({
						type: 'post',
						processData: false,
						contentType: false,
						url: 'save-category-image?categoryId=' + $('#catId').val(),
						data: formData,
						success: function(res) {
							if (res === 'success') {
								alert('Saved category image');
							} else if(res === 'error') {
								alert('Cannot change image!');
							}
						},
						error: function(res) {
							alert('Cannot upload image!');
						}
					});
				}

				reader.onloadend = function () {
					preview.src = reader.result;
				}

				if (file) {
					reader.readAsDataURL(file);
				} else {
					preview.src = "";
				}
				$("#preview").show();
			} else {
				alert('Please choose an image');
			}
		}
	}
</script>