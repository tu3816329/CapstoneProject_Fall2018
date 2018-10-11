<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a"%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

<style>
    #category {
        width: 95%;
        margin: auto;
        display: grid;
        grid-template-columns: 22% 77.5%;
        grid-column-gap: 0.5%;
        height: 150px;
        border-bottom: 1px solid #ddd;
        margin-bottom: 30px;
    }

    #add-question {
        border: none;
		background: #ab0800;
        border-radius: 0;
        color: white;
    }

    .quiz-image {
        background: #ccc;
        border: 2px solid #fff;
    }
    
    .quiz-image img {
    	max-width: 100%;
    }

    .quiz-detail {
        padding: 10px 0 0 5px;
    }

    .quiz-title {
        display: grid;
        grid-template-columns: 75% 25%;
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
        grid-template-columns: 85% 5% 5%;
        grid-column-gap: 2.5%;
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
        text-align: right;
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
        grid-template-columns: 12% 10%;
        grid-column-gap: 78%;
    }

    .answer-item>span:nth-child(1) {
        padding: 10px 50px;
        text-align: center;
    }

    .answer-item>span:nth-child(2) {
        padding: 10px 20px;
    }
</style>

<div id="category">
	<div class="quiz-image">
        <input type="hidden" value="${quiz.categoryIcon}" class="cat-image">
        <a:if test="${quiz.categoryIcon ne null}">
    		<img src="${pageContext.servletContext.contextPath}/load-photo?categoryId=${quiz.categoryId}" alt="">
	    </a:if>
	</div>
    <div class="quiz-detail">
	    <div class="quiz-title">
            <h3><a href="#">${quiz.categoryName}</a></h3>
            <a href="add-question?categoryId=${quiz.categoryId}" class="btn" id="add-question">
                <i class="fas fa-plus-circle"></i> Thêm câu hỏi
            </a>
	        <span>${quiz.numOfQuestions} Questions</span>
        </div>
	</div>
</div>
<div id="questions">
	<a:forEach items="${qas}" var="qa" varStatus="counter">
        <div class="qa-item">
            <div class="question-item">
                <div class="seq-no"><h1><span>${counter.count}</span></h1></div>
                <div class="question-content">
                    <span>${qa.questionContent}</span>
                    <span>
                        <a href="edit-question?questionId=${qa.questionId}"><i class="fas fa-edit"></i></a>
                    </span>
                    <span>
                        <a href="delete-question?questionId=${qa.questionId}&categoryId=${qa.categoryId}"><i class="fas fa-times"></i></a>
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

<script>;
    $(document).ready(function() {
        $('.w3l_agileits_breadcrumbs_inner>ul')
			.append($('<li>')
                .append($('.quiz-title a').text())
                .append('<span>«</span>')
            )
            .append($('<li>')
                .append('Quiz')
            );
            
        if ($('.quiz-image').has('img').length) {
            $('.quiz-image').css('background','#fff');
        }
    });

    $('.question-item').click(function() {
        var target = $(this);
        var isVisible = (target.siblings('.answers').css('display') === 'block');
        if (isVisible) {
            target.css('margin-bottom','20px');
            target.siblings('.answers').css('display','none');
        } else {
            target.css('margin-bottom','0');
            target.siblings('.answers').css('display','block');
        }
    });
</script>