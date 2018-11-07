<%@ page session="false" contentType="text/html; charset=UTF-8" %>

<!-- Handsontable -->
<script src="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.min.css">

<style>
    .handsontable th {
        font-weight: bold
    }

    #chapters-table, .btn {
        opacity: 0;
    }

    #btn-save-chapters {
        margin-top: 10px;
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

<div id="chapters-table"></div>
<button class="btn" id="btn-save-chapters">Save</button>
<div class="lds-dual-ring"></div>

<script>
    $(document).ready(function() {
        $('.lds-dual-ring').css('display', 'block');
        $('.gn-menu li:nth-child(2)').children('a').css('background','#283242');
        $('h2.w3_inner_tittle').text('Chapters');
        $('.w3l_agileits_breadcrumbs_inner>ul')
			.append($('<li>')
				.append('Chapters')
        	)
        var divisionSource = getDivisionSource();
        var gradeSource = getGradeSource();
        chaptersTableConfig(divisionSource, gradeSource);
        setTimeout(function() {
			$('.lds-dual-ring').css('display','none');
			$('#chapters-table, .btn').css('opacity', '1');
		}, 1000);
    });

    function getDivisionSource() {
        var divisionSource = [];
        $.ajax ({
            url: 'get-divisions',
            dataType: 'json',
            contentType: 'application/json',
            type: 'GET',
            async: false,
            success: function(res) {
                for (var i = 0; i < res.length; i++) {
                    divisionSource.push(res[i]);
                }
            }
        });
        return divisionSource;
    }

    function getGradeSource() {
        var gradeSource = [];
        $.ajax ({
            url: 'get-grades',
            dataType: 'json',
            contentType: 'application/json',
            type: 'GET',
            async: false,
            success: function(res) {
                for (var i = 0; i < res.length; i++) {
                    gradeSource.push(res[i]);
                }
            }
        });
        return gradeSource;
    }

    function chaptersTableConfig(divisionSource, gradeSource) {
        var divNames = [];
        for(var i = 0; i < divisionSource.length; i++) {
            divNames.push(divisionSource[i].divisionName);
        }
        var gradeNames = [];
        for(var i = 0; i < gradeSource.length; i++) {
            gradeNames.push(gradeSource[i].gradeName);
        }
        var container = document.getElementById('chapters-table');
        var hstb = new Handsontable(container, {
            minSpareRows: 1,
            startRows: 4,
            rowHeaders: true,
            colHeaders: ['ID','Chapter name','Division','Grade','Version','Action','Detail'],
            columns: [{
                data: 'id',
                readOnly: true
            },{
                data: 'chapterName'
            },{
                type: 'dropdown',
                data: 'divisionId.divisionName',
                source: divNames
            },{
                type: 'dropdown',
                data: 'gradeId.gradeName',
                source: gradeNames
            },{
                data: 'versionId.versionName',
                readOnly: true
            },{
                renderer: 'html',
                readOnly: true
            },{
                renderer: 'html',
                readOnly: true,
            }],
            stretchH: 'all',
            manualColumnResize: true,
            className: 'htCenter htMiddle'
        });

        $.ajax ({
            url: 'load-chapters-table',
            dataType: 'json',
            contentType: 'application/json',
            type: 'GET',
            success: function(res) {
                hstb.loadData(res);
                for (var i = 0; i < res.length - 1; i++) {
                    hstb.setDataAtCell(i, 5, '<a href="delete-chapter?chapterId=' + res[i].id + '">Delete</a>')
                    hstb.setDataAtCell(i, 6, '<a href="show-lessons?chapterId=' + res[i].id + '">View</a>')
                }
            },
            error: function(res) {
                alert('Some errors occured while loading data!');
            }
        });

        $('#btn-save-chapters').click(function() {
            var data = hstb.getData();
            var saveData = [];
            var divisions = getDivisionSource();
            var grades = getGradeSource();
            for (var i = 0; i < data.length; i++) {
                //
                var divisionId = {};
                for (var j = 0; j < divisions.length; j++) {
                    if(divisions[j].divisionName === data[i][2]) {
                        divisionId = divisions[j];
                    }
                }
                //
                var gradeId = {};
                for (var j = 0; j < grades.length; j++) {
                    if(grades[j].gradeName === data[i][3]) {
                        gradeId = grades[j];
                    }
                }
                //
                if(data[i][1] != null && $.trim(data[i][1]) != '') {
                    var id = data[i][0];
                    if(id === null) id = 0; 
                    var json = {
                        'id' : id,
                        'chapterName' : data[i][1],
                        'divisionId' : divisionId,
                        'gradeId' : gradeId
                    };
                    saveData.push(json);
                }
            }
            data = JSON.stringify(saveData);

            $.ajax ({
                url: 'save-chapters-table',
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                data: data,
                success: function(res) {
                    if (res === true) {
                        alert('Save data successfully!');
                        window.location.replace('show-chapters');
                    } else {
                        alert('Save data failed!')
                    }
                },
                error: function(res) {
                    alert('Some errors occured while saving');
                }
            });
        });
    }
</script>