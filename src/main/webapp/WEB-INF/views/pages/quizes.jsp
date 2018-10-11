<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a"%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

<style>
    #quizes {
        width: 95%;
        margin: auto;
    }

    .quiz-item {
        display: grid;
        grid-template-columns: 22% 77.5%;
        grid-column-gap: 0.5%;
        height: 156px;
        border: .125rem solid #ddd;
        box-shadow: 0 0 0.5rem 0 rgba(0,0,0,.15);
        margin-bottom: 20px;
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
</style>

<div id="quizes">
	<a:forEach items="${QUIZES}" var="q">
	    <div class="quiz-item">
	        <div class="quiz-image">
                <input type="hidden" value="${q.categoryIcon}" class="cat-image">
                <a:if test="${q.categoryIcon ne null}">
	        		<img src="${pageContext.servletContext.contextPath}/load-photo?categoryId=${q.categoryId}" alt="">
	        	</a:if>
	        </div>
	        <div class="quiz-detail">
	            <div class="quiz-title">
	                <h3><a href="quiz-detail?categoryId=${q.categoryId}">${q.categoryName}</a></h3>
	                <span>${q.numOfQuestions} Questions</span>
	            </div>
	        </div>
	    </div>
	</a:forEach>
</div>

<script>
    $(document).ready(function() {
        $('.w3l_agileits_breadcrumbs_inner>ul')
			.append($('<li>')
				.append('Quizes')
        	);
        $('h2.w3_inner_tittle').text('Quizes');
        $('.gn-menu li:nth-child(3)').children('a').css('background','#283242');
    });

    $('.quiz-item').each(function() {
        var target = $(this).children('.quiz-image');
        if (target.has('img').length) {
            target.css('background','#fff');
        }
    });
</script>