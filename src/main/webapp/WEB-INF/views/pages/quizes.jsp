<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a"%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
    crossorigin="anonymous">

<style>
    .quiz-item {
        display: grid;
        grid-template-columns: 22% 77.5%;
        grid-column-gap: 0.5%;
        height: 156px;
        border: .125rem solid #ddd;
        box-shadow: 0 0 0.5rem 0 rgba(0, 0, 0, .15);
        margin-bottom: 20px;
    }

    .quiz-image {
        text-align: center;
        background: #ccc;
        border: 2px solid #fff;
    }

    .quiz-image img {
        max-width: 100%;
        max-height: 100%;
    }

    .quiz-detail {
        padding: 10px 0 0 5px;
    }

    .quiz-title h3 {
        margin-bottom: 5px;
    }

    .quiz-title a {
        text-decoration: none;
        color: #333;
        transition: 0.5s;
        font-weight: bold;
        font-size: 21px;
    }

    .quiz-title a:hover {
        color: #45a3e5;
    }

    .quiz-title span {
        color: #757575;
        font-weight: bold;
        font-size: 15px;
    }

    .fas {
        font-size: 19px;
    }

    /* Pagination */
    #pagination {
        text-align: center;
        margin-top: 10px;
        margin-bottom: 20px;
    }

    .firstPage, .lastPage, .pageNum {
        background: #0084ff;
        color: white;
        border-radius: 5px;
        padding: 12px 15px;
        margin-right: 5px;
        box-shadow: 0 0 0.5rem 0 rgba(0, 0, 0, .15);
        cursor: pointer;
    }
</style>

<input type="hidden" value="${pageid}" id="pageId">
<div class="content-header">
    <h3 class="content-title">Quizzes</h3>
    <input style="float: right" placeholder="Search quiz ..." id="search-bar">
</div>
<div id="quizes">
    <a:forEach items="${QUIZES}" var="q">
        <div class="quiz-item">
            <div class="quiz-image">
            </div>
            <div class="quiz-detail">
                <div class="quiz-title">
                    <h3><a href="quiz-detail?lessonId=${q.lessonId}">${q.lessonTitle}</a></h3>
                    <span>${q.numOfQuestions} questions</span>
                </div>
            </div>
        </div>
    </a:forEach>
</div>
<div id="pagination"></div>

<script>
    $(document).ready(function () {
        $('#pageId').val('1');
        pagination();
    });

    function removeVNeseSigns(str) {
        str = str.normalize('NFD').replace(/[\u0300-\u036f]/g, "");
        str = str.normalize('NFD').replace(/[\u0110-\u0111]/g, "d");
        return str;
    }

    $('#search-bar').bind('keypress', function (e) {
        $('.quiz-item').removeClass('hidden');
        if (e.keyCode == 13) {
            var searchValue = removeVNeseSigns($(this).val()).trim().toLowerCase();
            $('.quiz-item').css('display', 'grid');
            $('.quiz-item h3').each(function () {
                var quizName = removeVNeseSigns($(this).text()).trim().toLowerCase();
                if (quizName.indexOf(searchValue) == -1) {
                    $(this).parents('.quiz-item').addClass('hidden');
                }
            });
            $('.hidden').css('display', 'none');
            $('#pagination').empty();
            pagination();
        }
    });

    $(document).on('click', '.pageNum', function () {
        $('#pageId').val($(this).text());
        pagination();
    });

    function pagination() {
        // Set item position
        var position = 1;
        $('.quiz-item').removeAttr('position');
        $('.quiz-item').not('.hidden').each(function () {
            $(this).attr('position', position++);
        });

        // Items per page
        var pageId = parseInt($('#pageId').val());
        var from = 5 * (pageId - 1);
        var to = 5 * pageId + 1;
        $('.quiz-item[position]').each(function () {
            if ($(this).attr('position') <= from || $(this).attr('position') >= to) {
                $(this).css('display', 'none');
            } else {
                $(this).css('display', 'grid');
            }
        });

        // 
        var itemNum = $('.quiz-item[position]').length;
        var pageNum = ((itemNum / 5) | 0) + 1;

        // Pagination buttons visibility
        $('.pageNum').css('display', '');
        if (itemNum != 0) {
            if ($('#pagination').is(':empty')) {
                if (pageNum > 1) {
                    $('#pagination').append($('<a class="btn btn-default firstPage">')
                        .append('First')
                    );
                }
                for (var i = 1; i <= pageNum; i++) {
                    $('#pagination').append($('<a class="btn btn-default pageNum">')
                        .append(i)
                    );
                }
                if (pageNum > 1) {
                    $('#pagination').append($('<a class="btn btn-default lastPage">')
                        .append('Last')
                    );
                }
            }

            if (pageNum > 5) {
                if (pageId <= 3) {
                    $('.pageNum').each(function () {
                        var index = parseInt($(this).text());
                        if (index > 5) {
                            $(this).css('display', 'none');
                        }
                    });
                } else {
                    $('.pageNum').each(function () {
                        var index = parseInt($(this).text());
                        var start = pageId - 2;
                        var end = pageId + 2;

                        if (end <= pageNum) {
                            if (index < pageId - 2 || index > pageId + 2) {
                                $(this).css('display', 'none');
                            }
                        } else {
                            if (index <= pageNum - 5) {
                                $(this).css('display', 'none');
                            }
                        }
                    });
                }
            }
        }

        // Current page button style
        $('.pageNum').css({
            'border': '',
            'background': '',
            'color': ''
        });
        $('.pageNum').each(function () {
            if ($(this).text() === $('#pageId').val()) {
                $(this).css('border', '2px solid #0084ff');
                $(this).css('background', 'white');
                $(this).css('color', '#0084ff');
            }
        });
    }

    $(document).on('click', '.firstPage', function () {
        alert('first');
        $('#pageId').val('1');
        pagination();
    });

    $(document).on('click', '.lastPage', function () {
        alert('last');
        var itemNum = $('.quiz-item[position]').length;
        var pageNum = ((itemNum / 5) | 0) + 1;
        $('#pageId').val(pageNum);
        pagination();
    });

    $('.quiz-item').each(function () {
        var target = $(this).children('.quiz-image');
        if (target.has('img').length) {
            target.css('background', '#fff');
        }
    });
</script>