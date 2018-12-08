<%@ page session="false" contentType="text/html; charset=UTF-8" %>

<!-- Handsontable -->
<script src="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/resources/handsontable-master/handsontable.full.min.css">

<style>
    #chapters-table a {
        color: #0084ff;
    }

    /* Table */
    tr>td:first-child,
    tr>th:first-child {
        display: none;
    }

    tr>td:nth-child(n+3),
    tr>th:nth-child(n+3) {
        text-align: center;
    }

    /* Dropdowns */
    .subject-dropbtn,
    .grade-dropbtn {
        padding: 0;
        border: none;
        cursor: pointer;
    }

    .subject-dropdown,
    .grade-dropdown {
        position: relative;
        display: inline-block;
    }

    .subject-dropdown-content,
    .grade-dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
        z-index: 1;
        border-radius: 3px;
    }

    .subject-dropdown-content a,
    .grade-dropdown-content a {
        color: black;
        padding: 5px 10px;
        text-decoration: none;
        display: block;
    }

    .subject-dropdown-content a:hover,
    .grade-dropdown-content a:hover {
        background-color: #f1f1f1
    }

    .subject-dropdown:hover .subject-dropdown-content,
    .grade-dropdown:hover .grade-dropdown-content {
        display: block;
    }
</style>

<%@ include file="../modals/delete-modal.jsp" %>
<div class="content-header">
    <h3 class="content-title">Chapters</h3>
    <input placeholder="Search chapter ..." id="search-bar">
</div>
<table id="chapter-table" class="table table-striped">
    <thead>
        <tr>
            <th>ID</th>
            <th>Chapter Name</th>
            <th>Subject</th>
            <th>Grade</th>
            <th>Version</th>
            <th>Detail</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<button class="btn btn-default ld-ext-right content-button" id="btn-save-chapters">
    Save <div class="ld ld-ring ld-spin"></div>
</button>

<script>
    $(document).ready(function () {
        var gradeSource = getGradeSource();
        var subjectSource = getSubjectSource();
        chapterTableConfig(subjectSource, gradeSource);

        $(document).on('change', '#chapter-table td', function (evt, newValue) {
            if ($(this).hasClass('uneditable')) {
                return false;
            } else {
                var id = $(this).siblings('.chapter-id').text();
                if (id === '') {
                    if ($(this).parent().hasClass('last')) {
                        $(this).parent().attr('class', 'new');
                        $('#chapter-table').append('<tr class="last">' +
                            '<td class="uneditable chapter-id"></td>' +
                            '<td></td>' +
                            '<td class="uneditable">' +
                            getSubjectDropdown(subjectSource, '', '') +
                            '</td>' +
                            '<td class="uneditable">' +
                            getGradeDropdown(gradeSource, '', '') +
                            '</td>' +
                            '<td class="uneditable"></td>' +
                            '<td class="uneditable"></td>' +
                            '<td class="uneditable"></td>' +
                            '</tr>');

                        var bgColor = $('.last').css('background-color');
                        $('.last').find('.subject-dropbtn').css('background-color', bgColor);
                        $('.last').find('.grade-dropbtn').css('background-color', bgColor);
                        $('#chapter-table').editableTableWidget();
                    }
                } else {
                    $(this).parent().attr('class', 'edited');
                }
            }
            return true;
        });

        $(document).on('click', 'tr>td:nth-child(7)>a', function (e) {
            e.preventDefault();
            var deleteLink = $(this).attr('href');
            $('.modal').css('height', '100%');
            $('.modal button:eq(0)').click(function () {
                $(this).addClass('disabled running');
                window.location.href = deleteLink;
            });
            $('.modal button:eq(1)').click(function () {
                $('.modal').css('height', '0');
            });
        });
    });

    function getSubjectDropdown(subjectSource, subjectId, subjectName) {
        if (subjectName === '') {
            subjectName = 'Select divison';
        }
        var subjectDropdown = '<div class="subject-dropdown">' +
            '<button subject-id="' + subjectId + '" class="subject-dropbtn">' + subjectName +
            ' <i class="fas fa-caret-down"></i></button><div class="subject-dropdown-content">';
        for (var i = 0; i < subjectSource.length; i++) {
            subjectDropdown += '<a href="#" class="subject-option" subject-id="' + subjectSource[i].id + '">'
                + subjectSource[i].subjectName + '</a>';
        }
        subjectDropdown += '</div></div>';
        return subjectDropdown;
    }

    function getGradeDropdown(gradeSource, gradeId, gradeName) {
        if (gradeName === '') {
            gradeName = 'Select grade';
        }
        var gradeDropdown = '<div class="grade-dropdown">' +
            '<button grade-id="' + gradeId + '" class="grade-dropbtn">' + gradeName +
            ' <i class="fas fa-caret-down"></i></button><div class="grade-dropdown-content">';
        for (var i = 0; i < gradeSource.length; i++) {
            gradeDropdown += '<a href="#" class="grade-option" grade-id="' + gradeSource[i].id + '">'
                + gradeSource[i].gradeName + '</a>';
        }
        gradeDropdown += '</div></div>';
        return gradeDropdown;
    }

    function chapterTableConfig(subjectSource, gradeSource) {
        $.ajax({
            url: 'load-chapters-table',
            dataType: 'json',
            contentType: 'application/json',
            type: 'GET',
            success: function (res) {
                for (var i = 0; i < res.length; i++) {
                    $('#chapter-table').append('<tr>' +
                        '<td class="uneditable chapter-id">' + res[i].id + '</td>' +
                        '<td>' + res[i].chapterName + '</td>' +
                        '<td class="uneditable">' +
                        getSubjectDropdown(subjectSource, res[i].subjectId.id, res[i].subjectId.subjectName) +
                        '</td>' +
                        '<td class="uneditable">' +
                        getGradeDropdown(gradeSource, res[i].gradeId.id, res[i].gradeId.gradeName) +
                        '</td>' +
                        '<td class="uneditable">' + res[i].versionId.versionName + '</td>' +
                        '<td class="uneditable"><a href="show-lessons?chapterId=' + res[i].id + '">View</a></td>' +
                        '<td class="uneditable"><a href="delete-chapter?chapterId=' + res[i].id + '">Delete</a></td>' +
                        '</tr>');
                }
                $('#chapter-table').append('<tr class="last">' +
                    '<td class="uneditable" class="chapter-id"></td>' +
                    '<td></td>' +
                    '<td class="uneditable">' +
                    getSubjectDropdown(subjectSource, '', '') +
                    '</td>' +
                    '<td class="uneditable">' +
                    getGradeDropdown(gradeSource, '', '') +
                    '</td>' +
                    '<td class="uneditable"></td>' +
                    '<td class="uneditable"></td>' +
                    '<td class="uneditable"></td>' +
                    '</tr>');
                $('#chapter-table').editableTableWidget();
                $('#search-bar').bind('keypress', function (e) {
                    if (e.keyCode == 13) {
                        $('tbody>tr').css('display', '');
                        var searchValue = removeVNeseSigns($(this).val()).trim().toLowerCase();

                        $('tbody>tr').each(function () {
                            var chapterName = removeVNeseSigns($(this).children('td:eq(1)').text()).trim().toLowerCase();
                            console.log(chapterName);
                            if (chapterName.indexOf(searchValue) === -1) {
                                $(this).css('display', 'none');
                            }
                        });
                    }
                });
            },
            error: function (res) {
                alert('Some errors occured while loading data!');
            },
            complete: function (res) {
                // Custom Css
                $('#loading-img').fadeOut();
                $('#content').children().not('style, script').css('display', 'block');
                $('.content-header').css('display', 'grid');
                $('#chapter-table').css('display', 'table');
                $('#content>input').css('display', '');
                $('.subject-dropbtn, .grade-dropbtn').each(function () {
                    var bgColor = $(this).parents('tr').css('background-color');
                    $(this).css('background-color', bgColor);
                });

                $(document).on('click', '.subject-option', function () {
                    var subjectId = $(this).attr('subject-id');
                    var subjectDropBtn = $(this).parent().siblings('.subject-dropbtn');
                    subjectDropBtn.text($(this).text());
                    subjectDropBtn.append(' <i class="fas fa-caret-down"></i>');
                    subjectDropBtn.attr('subject-id', subjectId);
                    $(this).parent().css('display', 'none');
                    $(this).parents('tr').not('.new, .last').attr('class', 'edited');
                });

                $(document).on('click', '.grade-option', function () {
                    var gradeId = $(this).attr('grade-id');
                    var gradeDropBtn = $(this).parent().siblings('.grade-dropbtn');
                    gradeDropBtn.text($(this).text());
                    gradeDropBtn.append(' <i class="fas fa-caret-down"></i>');
                    gradeDropBtn.attr('grade-id', gradeId);
                    $(this).parent().css('display', 'none');
                    $(this).parents('tr').not('.new, .last').attr('class', 'edited');
                });

                $(document).on('mouseover', '.subject-dropdown', function () {
                    $(this).children('.subject-dropdown-content').removeAttr('style');
                });

                $(document).on('mouseover', '.grade-dropdown', function () {
                    $(this).children('.grade-dropdown-content').removeAttr('style');
                });

                $('#chapter-table td').on('validate', function (evt, newValue) {
                    if ($.trim(newValue) === '') {
                        return false; // mark cell as invalid 
                    }
                });
            }
        });

        $('#btn-save-chapters').click(function () {
            $(this).prop('disabled', true);
            $(this).addClass('disabled running');
            var saveData = [];
            var editedCount = $('tr.edited').length;
            var newCount = $('tr.new').length;

            // Edit record
            for (var j = 0; j < editedCount; j++) {
                var chapterObj = $('tr.edited').eq(j);
                var id = parseInt(chapterObj.children('td:eq(0)').text());
                var chapterName = chapterObj.children('td:eq(1)').text();

                var subjectId = parseInt(chapterObj.find('.subject-dropbtn').attr('subject-id'));
                var subjectIdObj = {};
                for (var i = 0; i < subjectSource.length; i++) {
                    if (subjectSource[i].id === subjectId) {
                        subjectIdObj = subjectSource[i];
                    }
                }

                var gradeId = parseInt(chapterObj.find('.grade-dropbtn').attr('grade-id'));
                var gradeIdObj = {};
                for (var i = 0; i < gradeSource.length; i++) {
                    if (gradeSource[i].id === gradeId) {
                        gradeIdObj = gradeSource[i];
                    }
                }

                var isEmpty = (Object.keys(subjectIdObj).length === 0) || (Object.keys(gradeIdObj).length === 0);
                if ($.trim(chapterName) !== '' && !isEmpty) {
                    var json = {
                        'id': id,
                        'chapterName': chapterName,
                        'subjectId': subjectIdObj,
                        'gradeId': gradeIdObj
                    };
                    saveData.push(json);
                }
            }

            // New record
            for (var j = 0; j < newCount; j++) {
                var chapterObj = $('tr.new').eq(j);
                var id = 0;
                var chapterName = chapterObj.children('td:eq(1)').text();

                var subjectId = parseInt(chapterObj.find('.subject-dropbtn').attr('subject-id'));
                var subjectIdObj = {};
                for (var i = 0; i < subjectSource.length; i++) {
                    if (subjectSource[i].id === subjectId) {
                        subjectIdObj = subjectSource[i];
                    }
                }

                var gradeId = parseInt(chapterObj.find('.grade-dropbtn').attr('grade-id'));
                var gradeIdObj = {};
                for (var i = 0; i < gradeSource.length; i++) {
                    if (gradeSource[i].id === gradeId) {
                        gradeIdObj = gradeSource[i];
                    }
                }

                var isEmpty = (Object.keys(subjectIdObj).length === 0) || (Object.keys(gradeIdObj).length === 0);
                if ($.trim(chapterName) !== '' && !isEmpty) {
                    var json = {
                        'id': id,
                        'chapterName': chapterName,
                        'subjectId': subjectIdObj,
                        'gradeId': gradeIdObj
                    };
                    saveData.push(json);
                }
            }
            data = JSON.stringify(saveData);

            $.ajax({
                url: 'save-chapters-table',
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                data: data,
                success: function (res) {
                    if (res === true) {
                        alert('Save data successfully!');
                    } else {
                        alert('Save data failed!')
                    }
                },
                error: function (res) {
                    alert('Some errors occured while saving');
                },
                complete: function (res) {
                    window.location.replace('show-chapters');
                }
            });
        });
    }

    function getSubjectSource() {
        var subjectSource = [];
        $.ajax({
            url: 'get-subjects',
            dataType: 'json',
            contentType: 'application/json',
            type: 'GET',
            async: false,
            success: function (res) {
                for (var i = 0; i < res.length; i++) {
                    subjectSource.push(res[i]);
                }
            },
            error: function (res) {
                alert('Load data failed');
            }
        });
        return subjectSource;
    }

    function getGradeSource() {
        var gradeSource = [];
        $.ajax({
            url: 'get-grades',
            dataType: 'json',
            contentType: 'application/json',
            type: 'GET',
            async: false,
            success: function (res) {
                for (var i = 0; i < res.length; i++) {
                    gradeSource.push(res[i]);
                }
            },
            error: function (res) {
                alert('Load data failed');
            }
        });
        return gradeSource;
    }

    function removeVNeseSigns(str) {
        str = str.normalize('NFD').replace(/[\u0300-\u036f]/g, "");
        str = str.normalize('NFD').replace(/[\u0110-\u0111]/g, "d");
        return str;
    }
</script>