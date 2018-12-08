<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>

<!-- Handsontable -->
<script src="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.min.css">

<style>
    .handsontable th {
        font-weight: bold
    }

    #add-solution {
        height: auto;
    }

    #solutions-table td:nth-child(n+2),
    #solutions-table th:nth-child(n+2) {
        text-align: center;
    }
</style>

<%@ include file="../modals/delete-modal.jsp" %>
<div class="content-header">
    <h3 class="content-title">Math forms</h3>
    <div style="text-align: right">
        <a id="add-solution" class="btn content-button" href="add-solution?lessonId=${LESSONID}">
            <i class="fas fa-plus-circle"></i> New math form</a>
    </div>
</div>
<table id="solutions-table" class="table table-hover">
    <thead>
        <tr>
            <th>Name</th>
            <th>Num. of exercises</th>
            <th>Version</th>
            <th>Action</th>
            <th>Detail</th>
        </tr>
    </thead>
    <tbody>
        <a:forEach items="${solutions}" var="m">
            <tr>
                <td>${m.title}</td>
                <td>${m.numOfExercises}</td>
                <td>${m.versionId.versionName}</td>
                <td><a style="color: #0084ff" href="delete-solution?solutionId=${m.id}&lessonId=${LESSONID}">Delete</a></td>
                <td><a style="color: #0084ff" href="solution-detail?solutionId=${m.id}">View</a></td>
            </tr>
        </a:forEach>
    </tbody>
</table>

<script>
    $(window).on('load', function () {
        $('#loading-img').fadeOut();
        $('#content').children().not('style, script').css('display', 'block');
        $('.content-header').css('display', 'grid');
        $('#solutions-table').css('display', 'table');
    });

    $(document).on('click', 'tr>td:nth-child(4)>a', function(e) {
			e.preventDefault();
			var deleteLink = $(this).attr('href');
            $('.modal').css('height', '100%');
            $('.message-modal-title').text('Delete math form');
			$('.message-modal-body').text('Are you sure you want to delete this math form?');
            $('.modal button:eq(0)').click(function () {
                $(this).addClass('disabled running');
                window.location.href = deleteLink;
            });
            $('.modal button:eq(1)').click(function () {
                $('.modal').css('height', '0');
            });
		});
</script>