<%@ page session="false" contentType="text/html; charset=UTF-8" %>

<!-- Handsontable -->
<script src="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.min.css">

<style>
    .handsontable th {
        font-weight: bold
    }

    #add-version {
        height: fit-content;
        width: fit-content;
    }
</style>

<div class="content-header">
    <h3 class="content-title">Versions</h3>
    <a id="add-version" class="btn content-button" href="add-version">Upgrade</a>
</div>
<div id="versions-table"></div>

<script>
    $(document).ready(function() {
        versionsTableConfig();
    });

    function versionsTableConfig() {
        var container = document.getElementById('versions-table');
        var hstb = new Handsontable(container, {
            startRows: 4,
            rowHeaders: true,
            colHeaders: ['Version number','Name','Status'],
            columns: [{
                data: 'databaseVersion',
                readOnly: true
            },{
                data: 'versionName',
                readOnly: true
            },{
                readOnly: true
            }],
            stretchH: 'all',
            manualColumnResize: true,
            className: 'htCenter htMiddle'
        });

        $.ajax ({
            url: 'load-versions-table',
            dataType: 'json',
            contentType: 'application/json',
            type: 'GET',
            success: function(res) {
                hstb.loadData(res);
                for (var i = 0; i < res.length; i++) {
                    if (res[i].isCurrent) {
                        hstb.setDataAtCell(i, 2, 'Activated')
                    } else {
                        hstb.setDataAtCell(i, 2, 'Deactivated')
                    }
                }
            },
            error: function(res) {
                alert('Some errors occured while loading data!');
            }
        });
    }
</script>