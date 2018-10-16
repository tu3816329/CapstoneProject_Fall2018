<%@ page session="false" contentType="text/html; charset=UTF-8" %>

<!-- Handsontable -->
<script src="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.min.css">

<style>
    .handsontable th {
        font-weight: bold
    }

    #versions-table {
        opacity: 0;
    }

    #add-version {
        margin-top: 10px;
		border: none;
		background: #ab0800;
		border-radius: 0;
        color: white;
        float: right;
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

<div id="versions-table"></div>
<div class="lds-dual-ring"></div>

<script>
    $(document).ready(function() {
        $('.lds-dual-ring').css('display', 'block');
        $('.gn-menu li:nth-child(4)').children('a').css('background','#283242');
        $('h2.w3_inner_tittle').text('Phiên bản');
        $('h2.w3_inner_tittle')
            .append(
                '<a id="add-version" class="btn" href="add-version">Nâng cấp</a>'
            );
        $('.w3l_agileits_breadcrumbs_inner>ul')
			.append($('<li>')
				.append('Phiên bản')
        	);
        versionsTableConfig();
        setTimeout(function() {
			$('.lds-dual-ring').css('display','none');
			$('#versions-table').css('opacity', '1');
		}, 1000);
    });

    function versionsTableConfig() {
        var container = document.getElementById('versions-table');
        var hstb = new Handsontable(container, {
            startRows: 4,
            rowHeaders: true,
            colHeaders: ['ID','Phiên bản','Tên phiên bản','Trạng thái'],
            columns: [{
                data: 'id',
                readOnly: true
            },{
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
                        hstb.setDataAtCell(i, 3, 'Hiện tại')
                    } else {
                        hstb.setDataAtCell(i, 3, 'Cũ')
                    }
                }
            },
            error: function(res) {
                alert('Some errors occured while loading data!');
            }
        });
    }
</script>