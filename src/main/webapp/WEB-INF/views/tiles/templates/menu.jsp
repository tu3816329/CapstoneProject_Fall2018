<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>

<h3 id="data-explorer"><a href="#"><i class="fas fa-wrench"></i> Data Explorer</a></h3>
<ul id="tree-menu"></ul>
<div class="side-menu-item"><a href="${pageContext.servletContext.contextPath}">
		<i class="fas fa-home"></i> Home
	</a></div>
<div class="side-menu-item"><a href="show-chapters">
		<i class="fas fa-desktop"></i> Data Management
	</a></div>
<div class="side-menu-item"><a href="show-questions">
		<i class="fas fa-question"></i> Quiz
	</a></div>
<div class="side-menu-item"><a href="show-versions">
		<i class="fas fa-code-branch"></i> Versions
	</a></div>

<script>
	$(document).ready(function () {
		var divisions = getDivisions();
		$.ajax({
			type: 'GET',
			url: 'get-grades',
			contentType: 'application/json',
			dataType: 'json',
			success: function (res) {
				var grades = res;
				for (var i = 0; i < grades.length; i++) {
					$('#tree-menu').append($('<li class="grade-item">')
						.append('<i class="fas fa-plus-square"> </i><i class="fas fa-folder-open"></i> ' + grades[i].gradeName)
						.append('<input type="hidden" class="gradeId" value="' + grades[i].id + '">')
						.append($('<ul class="nested division-tree">'))
					);
				}

				// Load divisions
				$('.division-tree').each(function () {
					for (var i = 0; i < divisions.length; i++) {
						$(this).append($('<li class="division-item">')
							.append('<i class="fas fa-plus-square"></i> <i class="fas fa-box"></i> ' + divisions[i].divisionName)
							.append('<input type="hidden" class="divisionId" value="' + divisions[i].id + '">')
							.append($('<ul class="nested chapter-tree">'))
						);
					}
				});

				// Load chapters
				$('.chapter-tree').each(function () {
					var divisionId = $(this).siblings('.divisionId').val();
					var gradeId = $(this).parents('.division-tree').siblings('.gradeId').val();
					var chapters = getChapters(divisionId, gradeId);
					for (var i = 0; i < chapters.length; i++) {
						$(this).append($('<li class="chapter-item">')
							.append('<i class="fas fa-plus-square"></i> <i class="fas fa-book"></i> <a href="show-lessons?chapterId=' + chapters[i].id + '">' + chapters[i].chapterName + '</a>')
							.append('<input type="hidden" class="chapterId" value="' + chapters[i].id + '">')
							.append($('<ul class="nested lesson-tree">'))
						);
					}
				});

				// Load lessons
				$('.lesson-tree').each(function () {
					var chapterId = $(this).siblings('.chapterId').val();
					var lessons = getLessons(chapterId);
					for (var i = 0; i < lessons.length; i++) {
						$(this).append($('<li class="les-item">')
							.append('<i class="fas fa-plus-square"></i> <i class="fas fa-file"></i> <a href="show-mathforms?lessonId=' + lessons[i].id + '">' + lessons[i].lessonTitle + '</a>')
							.append('<input type="hidden" class="lessonId" value="' + lessons[i].id + '">')
							.append($('<ul class="nested mathform-tree">'))
						);
					}
				});

				// Load math forms
				$('.mathform-tree').each(function () {
					var lessonId = $(this).siblings('.lessonId').val();
					var mathforms = getMathforms(lessonId);
					for (var i = 0; i < mathforms.length; i++) {
						$(this).append($('<li class="mathform-item">')
							.append('<i class="fas fa-caret-square-right"></i> <a href="mathform-detail?mathformId=' + mathforms[i].id + '">' + mathforms[i].mathformTitle + '</a>')
							.append('<input type="hidden" class="mathformId" value="' + mathforms[i].id + '">')
						);
					}
				});
			},
			error: function (res) {
				alert('Some errors occured while loading grades');
			}
		});

		// Tree data
	});

	$(document).on('click', '#data-explorer', function () {
		if ($('#tree-menu').css('display') === 'none') {
			$('#tree-menu').css('display', 'block');
		} else {
			$('#tree-menu').css('display', 'none');
		}
	});

	function getDivisions() {
		var divisions;
		$.ajax({
			type: 'GET',
			async: false,
			url: 'get-divisions',
			contentType: 'application/json',
			dataType: 'json',
			success: function (res) {
				divisions = res;
			},
			error: function (res) {
				alert('Some errors occured while loading divisions');
			}
		});
		return divisions;
	}

	function getChapters(divisionId, gradeId) {

		var chapters;
		$.ajax({
			type: 'GET',
			async: false,
			url: 'get-chapter-tree?divisionId=' + divisionId + '&gradeId=' + gradeId,
			contentType: 'application/json',
			dataType: 'json',
			success: function (res) {
				chapters = res;
			},
			error: function (res) {
				alert('Some errors occured while loading chapters');
			}
		});
		return chapters;
	}

	function getLessons(chapterId) {
		var lessons;
		$.ajax({
			type: 'GET',
			async: false,
			url: 'get-lesson-tree?chapterId=' + chapterId,
			contentType: 'application/json',
			dataType: 'json',
			success: function (res) {
				lessons = res;
			},
			error: function (res) {
				alert('Some errors occured while loading lessons');
			}
		});
		return lessons;
	}

	function getMathforms(lessonId) {
		var mathforms;
		$.ajax({
			type: 'GET',
			async: false,
			url: 'get-mathform-tree?lessonId=' + lessonId,
			contentType: 'application/json',
			dataType: 'json',
			success: function (res) {
				mathforms = res;
			},
			error: function (res) {
				alert('Some errors occured while loading math forms');
			}
		});
		return mathforms;
	}

	$(document).on('click', 'i.fa-plus-square, i.fa-minus-square', function () {
		$(this).siblings('.nested').toggleClass('active');
		if ($(this).siblings('.nested').hasClass('active')) {
			$(this).attr('class', 'fas fa-minus-square');
		} else {
			$(this).attr('class', 'fas fa-plus-square');
		}
	});
</script>