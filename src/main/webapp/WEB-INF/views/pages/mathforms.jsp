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
        width: fit-content;
        height: fit-content;
    }
</style>

<div class="content-header">
    <h3 class="content-title">Math forms</h3>
    <a id="add-mathform" class="btn content-button" href="add-mathform?lessonId=${LESSONID}">
            <i class="fas fa-plus-circle"></i>New math form</a>
</div>
<input type="hidden" id="l-id" value="${LESSONID}">
<div id="mathforms-table"></div>

<script>
    $(document).ready(function() {
        mathformsTableConfig();
    });

    function mathformsTableConfig () {
        var container = document.getElementById('mathforms-table');
        var hstb = new Handsontable(container, {
            rowHeaders: true,
            colHeaders: ['Name','Num. of exercises','Version','Action','Detail'],
            columns: [{
                data: 'mathformTitle',
                readOnly: true
            },{
                readOnly: true
            },{
                data: 'versionId.versionName',
                readOnly: true
            },{
                renderer: 'html',
                readOnly: true
            },{
                renderer: 'html',
                readOnly: true
            }],
            stretchH: 'all',
            manualColumnResize: true,
            className: 'htCenter htMiddle'
        });

        $.ajax ({
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            url: 'load-mathforms-table?lessonId=' + $('#l-id').val(),
            success: function(res) {
                hstb.loadData(res);
                for (var i = 0; i < res.length; i++) {
                    hstb.setDataAtCell(i, 1, res[i].numOfExercises + ' exercises');
                    hstb.setDataAtCell(i, 3, '<a style="color: #0084ff" href="delete-mathform?mathformId=' 
                                                + res[i].id + '&lessonId=' + $('#l-id').val() + '">Delete</a>');
                    hstb.setDataAtCell(i, 4, '<a style="color: #0084ff" href="mathform-detail?mathformId=' 
                                                + res[i].id + '">View</a>');
                }
            },
            error: function(res) {
                alert('Some errors occured while loading mathforms');
            }
        });
    }
</script>