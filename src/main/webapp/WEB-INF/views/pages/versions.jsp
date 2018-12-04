<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>

<!-- Handsontable -->
<script src="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.min.css">

<style>
    #add-version {
        height: auto;
        width: fit-content;
    }

    #versions-table th,
    #versions-table td {
        text-align: center;
    }
</style>

<div class="content-header">
    <h3 class="content-title">Versions</h3>
    <div style="text-align: right">
        <a id="add-version" class="btn content-button" href="add-version">New version</a>
    </div>
</div>
<table id="versions-table" class="table table-hover">
    <thead>
        <tr>
            <th>Version number</th>
            <th>Name</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <a:forEach items="${versions}" var="v">
            <tr>
                <td>${v.databaseVersion}</td>
                <td>${v.versionName}</td>
                <td>
                    <a:if test="${v.isCurrent eq true}">
                        Activated
                    </a:if>
                    <a:if test="${v.isCurrent eq false}">
                        Deactivated
                    </a:if>
                </td>
            </tr>
        </a:forEach>
    </tbody>
</table>

<script>
    $(window).on('load', function () {
        $('#loading-img').fadeOut();
        $('#content').children().not('style, script').css('display', 'block');
        $('.content-header').css('display', 'grid');
        $('#versions-table').css('display', 'table');
    });
</script>