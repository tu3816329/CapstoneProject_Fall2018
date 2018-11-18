<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
 crossorigin="anonymous">

<style>
	/* Chapter */
	#chapter {
		background-color: white;
	}

	/* Lessons */
	#lessons {
		background-color: white;
		padding: 20px;
		height: calc(100% - 176px);
		overflow-y: auto;
	}

	#lessons a {
		color: #0084ff;
	}

    .chap-item {
        display: grid;
        grid-template-columns: 22% 77.5%;
        grid-column-gap: 0.5%;
        height: 156px;
        margin-bottom: 20px;
    }

    .chap-image {
        background: #ccc;
        border: 2px solid #fff;
		cursor: pointer;
		position: relative;
    }
    
    .chap-image img {
		max-width: 70%;
		max-height: 70%;
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translateY(-50%) translateX(-50%);
    }

    .chap-detail {
        padding: 10px 0 0 5px;
    }

	.chap-title {
		display: grid;
		grid-template-columns: 75% 25%;
		padding-right: 10px;
	}

    .chap-title h3 {
        margin-bottom: 5px;
    }

    .chap-title>h3>a:first-child {
        text-decoration: none;
        color: #333;
        transition: 0.5s;
        font-weight: bold;
        font-size: 21px;
    }

    .chap-title a:hover {
        color: #45a3e5;
    }

    .chap-title span {
        color: #757575;
        font-weight: bold;
        font-size: 15px;
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
		color: #0084ff;
		margin-right: 15px;
	}
	
	.lesson-item {
		margin-bottom: 10px;
		padding: 1em;
		color: #555;
		border: 1px solid #ddd;
	}
	
	#add-lesson {
		float: right;
		font-weight: normal;
		color: white;
	}
</style>

<%@ include file="../modals/delete-modal.jsp" %>
<input type="hidden" value="${chapter.divisionId.divisionName}" id="divName">
<input type="hidden" value="${chapter.chapterName}" id="chapName">
<input type="hidden" value="${chapter.id}" id="chapId">

<div id="chapter">
	<div class="chap-item">
		<input id="imgFile" name="imageFile" type="file" class="form-control-file" accept="image/*" style="display: none">
		<div class="chap-image">
			<input type="hidden" value="${chapter.chapterIcon}" class="chap-icon">
			<img id="preview" style="display: none" src="" alt="avatar preview" width="150px" height="150px">
			<a:if test="${chapter.chapterIcon eq null}">
				<img class="img sample" src="resources/images/image-icon.png">
			</a:if>
			<a:if test="${chapter.chapterIcon ne null}">
				<img class="img" src="${pageContext.servletContext.contextPath}/load-photo?chapterId=${chapter.id}" alt="">
			</a:if>
		</div>
		<div class="chap-detail">
			<div class="chap-title">
				<h3>
					<a href="#">${chapter.chapterName}</a>
				</h3>
				<a href="add-new-lesson?chapterId=${chapter.id}" class="btn content-button" id="add-lesson">
					<i class="fas fa-plus-circle"></i> Add Lesson
				</a>

				<a:if test="${fn:length(LESSONS) le 1}">
					<span>${fn:length(LESSONS)} lesson</span>
				</a:if>
				<a:if test="${fn:length(LESSONS) gt 1}">
					<span>${fn:length(LESSONS)} lessons</span>
				</a:if>
			</div>
		</div>
	</div>
</div>

<div id="lessons">
	<div class="content-header">
		<span class="content-title" style="font-weight: bold; font-size: 18px">Lessons of ${chapter.chapterName}</span>
		<input style="float: right" placeholder="Search lesson ..." id="search-bar">
	</div>
	<a:forEach items="${LESSONS}" var="l">
		<div class="lesson-item">
			<a href="delete-lesson?lessonId=${l.id}&chapterId=${l.chapterId.id}">
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

<script>
	$(window).on('load', function () {
		$('#loading-img').fadeOut();
		$('#content').children().not('style, script').css('display', 'block');
		$('.content-header').css('display', 'grid');
	});

	$(document).ready(function () {
		var divisionName = $('#divName').val();
		var chapterName = $('#chapName').val();
		var chapterId = $('#chapId').val();

		$('#content').css({
			'padding': 0,
			'background-color': '#e9e9e9',
			'box-shadow': 'none',
			'overflow-y': 'hidden'
		});

		$(document).on('click', '.lesson-item>a:nth-child(1)', function(e) {
			e.preventDefault();
			var deleteLink = $(this).attr('href');
            $('.modal').css('height', '100%');
			$('.message-modal-title').text('Delete lesson');
			$('.message-modal-body').text('Are you sure you want to delete this lesson?');
            $('.modal button:eq(0)').click(function () {
                $(this).addClass('disabled running');
                window.location.href = deleteLink;
            });
            $('.modal button:eq(1)').click(function () {
                $('.modal').css('height', '0');
            });
		});
	});

	function removeVNeseSigns(str) {
		str = str.normalize('NFD').replace(/[\u0300-\u036f]/g, "");
		str = str.normalize('NFD').replace(/[\u0110-\u0111]/g, "d");
		return str;
	}

	$('#search-bar').bind('keypress', function (e) {
		if (e.keyCode == 13) {
			var searchValue = removeVNeseSigns($(this).val()).trim().toLowerCase();
			$('.lesson-item').css('display', 'block');
			$('.lesson-item h4').each(function () {
				var lessonName = removeVNeseSigns($(this).text()).trim().toLowerCase();
				if (lessonName.indexOf(searchValue) == -1) {
					$(this).parents('.lesson-item').css('display', 'none');
				}
			});
		}
	});

	$('.chap-image').click(function () {
		$('#imgFile').click();
	});

	$("#imgFile").change(function () {
		$(".img").hide();
		readImage();
	});

	function readImage() {
		var preview = document.getElementById('preview');
		var file = document.querySelector('input[type=file]').files[0];

		var reader = new FileReader();

		if (file != undefined) {
			if (file.type.match(/image.*/)) {
				reader.onload = function () {
					formData = new FormData();
					formData.append('imageFile', file);
					$.ajax({
						type: 'post',
						processData: false,
						contentType: false,
						url: 'save-chapter-image?chapterId=' + $('#chapId').val(),
						data: formData,
						success: function (res) {
							if (res === 'success') {
								alert('Saved chapter image');
							} else if (res === 'error') {
								alert('Cannot change image!');
							}
						},
						error: function (res) {
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