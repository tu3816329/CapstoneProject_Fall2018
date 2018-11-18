<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>

<!-- Handsontable -->
<script src="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.min.css">

<style>
    .handsontable th {
        font-weight: bold
    }

    #add-mathform {
        height: auto;
    }

    #mathforms-table td:nth-child(n+2),
    #mathforms-table th:nth-child(n+2) {
        text-align: center;
    }
</style>

<%@ include file="../modals/delete-modal.jsp" %>
<div class="content-header">
    <h3 class="content-title">Math forms</h3>
    <div style="text-align: right">
        <a id="add-mathform" class="btn content-button" href="add-mathform?lessonId=${LESSONID}">
            <i class="fas fa-plus-circle"></i> New math form</a>
    </div>
</div>
<table id="mathforms-table" class="table table-hover">
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
        <a:forEach items="${mathforms}" var="m">
            <tr>
                <td>${m.mathformTitle}</td>
                <td>${m.numOfExercises}</td>
                <td>${m.versionId.versionName}</td>
                <td><a style="color: #0084ff" href="delete-mathform?mathformId=${m.id}&lessonId=${LESSONID}">Delete</a></td>
                <td><a style="color: #0084ff" href="mathform-detail?mathformId=${m.id}">View</a></td>
            </tr>
        </a:forEach>
    </tbody>
</table>

<script>
    $(window).on('load', function () {
        $('#loading-img').fadeOut();
        $('#content').children().not('style, script').css('display', 'block');
        $('.content-header').css('display', 'grid');
        $('#mathforms-table').css('display', 'table');
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