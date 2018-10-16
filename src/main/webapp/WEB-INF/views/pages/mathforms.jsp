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
        margin-top: 10px;
		border: none;
		background: #ab0800;
		border-radius: 0;
        color: white;
        float: right;
    }
</style>

<input type="hidden" id="l-id" value="${LESSONID}">
<div id="mathforms-table"></div>

<script>
    $(document).ready(function() {
        $('h2.w3_inner_tittle').text('Danh sách dạng bài');
        $('h2.w3_inner_tittle')
            .append(
                '<a id="add-mathform" class="btn" href="add-mathform?lessonId=' + $('#l-id').val() + '">Thêm dạng bài</a>'
            );
        $('.w3l_agileits_breadcrumbs_inner>ul')
			.append($('<li>')
				.append('Danh sách dạng bài')
        	);
        mathformsTableConfig();
    });

    function mathformsTableConfig () {
        var container = document.getElementById('mathforms-table');
        var hstb = new Handsontable(container, {
            rowHeaders: true,
            colHeaders: ['ID','Tên dạng bài','Bài tập','Phiên bản','Hành động','Chi tiết'],
            columns: [{
                data: 'id',
                readOnly: true
            },{
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
                    hstb.setDataAtCell(i, 2, res[i].numOfExercises + ' bài');
                    hstb.setDataAtCell(i, 4, '<a href="delete-mathform?mathformId=' + res[i].id + 
                                                            '&lessonId=' + $('#l-id').val() + '">Xoá</a>');
                    hstb.setDataAtCell(i, 5, '<a href="mathform-detail?mathformId=' + res[i].id + '">Xem</a>');
                }
            },
            error: function(res) {
                alert('Some errors occured while loading mathforms');
            }
        });
    }
</script>