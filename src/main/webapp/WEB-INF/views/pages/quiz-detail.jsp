<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a"%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
    crossorigin="anonymous">

<style>
    #lesson {
        display: grid;
        grid-template-columns: 22% 77.5%;
        grid-column-gap: 0.5%;
        height: 150px;
        margin-bottom: 30px;
        background: #fff;
    }

    #lesson h3>a {
        color: #0084ff;
    }

    #add-question {
        height: fit-content;
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

    .quiz-title {
        display: grid;
        grid-template-columns: 75% 25%;
        padding-right: 10px;
    }

    .quiz-title h3 {
        margin-bottom: 5px;
    }

    .quiz-title a {
        font-size: 21px;
    }

    .quiz-title>a {
        font-size: 15px;
    }

    .quiz-title span {
        color: #757575;
        font-weight: bold;
        font-size: 15px;
    }

    .fas {
        font-size: 15px;
    }

    /* Questions */
    #questions {
        background: #fff;
        height: calc(100% - 180px);
        padding: 20px;
        overflow-y: auto;
    }
    .question-item {
        min-height: 100px;
        display: grid;
        grid-template-columns: 12% 88%;
        cursor: pointer;
        margin-bottom: 20px;
    }

    .seq-no {
        background: #757575;
        color: white;
        font-style: italic;
    }

    .seq-no h1 {
        height: 100%;
        position: relative;
        margin: 0;
    }

    .seq-no span {
        top: 50%;
        left: 50%;
        position: absolute;
        transform: translateX(-50%) translateY(-50%);
        font-weight: bold;
    }

    .question-content {
        background: #f2f2f2;
        padding-left: 20px;
        display: grid;
        grid-template-columns: 90% 5% 5%;
    }

    .question-content>span:nth-child(1) {
        padding: 20px;
    }

    .question-content>span:nth-child(2) {
        padding-top: 10px;
        text-align: right;
    }

    .question-content>span:nth-child(3) {
        padding-top: 10px;
        text-align: center;
    }

    .question-content a {
        margin-right: 15px;
    }

    .question-content .fas {
        font-size: 17px;
        color: #555;
    }

    .fa-times {
        font-size: 20px !important;
    }

    /* Answers */
    .answers {
        display: none;
        margin-bottom: 20px;
    }

    .answer-item {
        border: 1px solid #ddd;
        display: grid;
        grid-template-columns: 85% 10%;
        grid-column-gap: 5%;
    }

    .answer-item>span:nth-child(1) {
        padding: 10px 50px;
    }

    .answer-item>span:nth-child(2) {
        margin: auto;
        padding: 10px 20px;
    }
</style>

<%@ include file="../modals/delete-modal.jsp" %>
<div id="lesson">
    <div class="quiz-image">

    </div>
    <div class="quiz-detail">
        <div class="quiz-title">
            <h3><a href="#">${quiz.lessonTitle}</a></h3>
            <a href="add-question?lessonId=${quiz.lessonId}" class="btn content-button" id="add-question">
                <i class="fas fa-plus-circle"></i> New question
            </a>
            <a:if test="${quiz.numOfQuestions le 1}">
                <span>${quiz.numOfQuestions} question</span>
            </a:if>
            <a:if test="${quiz.numOfQuestions gt 1}">
                <span>${quiz.numOfQuestions} questions</span>
            </a:if>
        </div>
    </div>
</div>

<div id="questions">
    <div class="content-header">
        <h3 class="content-title">questions</h3>
    </div>
    <a:forEach items="${qas}" var="qa" varStatus="counter">
        <div class="qa-item">
            <div class="question-item">
                <div class="seq-no">
                    <h1><span>${counter.count}</span></h1>
                </div>
                <div class="question-content">
                    <span>${qa.questionContent}</span>
                    <span>
                        <a href="edit-question?questionId=${qa.questionId}"><i class="fas fa-edit"></i></a>
                    </span>
                    <span>
                        <a href="delete-question?questionId=${qa.questionId}&lessonId=${qa.lessonId}"><i class="fas fa-times"></i></a>
                    </span>
                </div>
            </div>
            <div class="answers">
                <a:forEach items="${qa.choices}" var="c">
                    <a:if test="${not empty c.content and c.content ne null}">
                        <div class="answer-item">
                            <span>${c.content}</span>
                            <a:if test="${c.isCorrect eq true}">
                                <span><i style="color: green" class="fas fa-check"></i></span>
                            </a:if>
                            <a:if test="${c.isCorrect ne true}">
                                <span><i style="color: red" class="fas fa-times"></i></span>
                            </a:if>
                        </div>
                    </a:if>
                </a:forEach>
            </div>
        </div>
    </a:forEach>
</div>

<script>
    $(window).on('load', function () {
        $('#loading-img').fadeOut();
        $('#content').children().not('style, script').css('display', 'block');
        $('.content-header').css('display', 'grid');
        $('#lesson').css('display', 'grid');
    });

    $(document).ready(function () {
        if ($('.quiz-image').has('img').length) {
            $('.quiz-image').css('background', '#fff');
        }
        $('#content').css({
            'padding': 0,
            'background-color' : '#e9e9e9',
            'box-shadow': 'none',
            'overflow-y': 'hidden'
        });

        $(document).on('click', '.question-content>span:nth-child(3)>a', function(e) {
			e.preventDefault();
			var deleteLink = $(this).attr('href');
            $('.modal').css('height', '100%');
            $('.message-modal-title').text('Delete question');
			$('.message-modal-body').text('Are you sure you want to delete this question?');
            $('.modal button:eq(0)').click(function () {
                $(this).addClass('disabled running');
                window.location.href = deleteLink;
            });
            $('.modal button:eq(1)').click(function () {
                $('.modal').css('height', '0');
            });
		});
    });

    $('.question-item').click(function () {
        var target = $(this);
        var isVisible = (target.siblings('.answers').css('display') === 'block');
        if (isVisible) {
            target.css('margin-bottom', '20px');
            target.siblings('.answers').css('display', 'none');
        } else {
            target.css('margin-bottom', '0');
            target.siblings('.answers').css('display', 'block');
        }
    });
</script>