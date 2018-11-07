<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a"%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

<style>
    #quizes {
        width: 95%;
        margin: auto;
        opacity: 0;
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
<div class="lds-dual-ring"></div>

<script>
    $(document).ready(function() {
        $('.lds-dual-ring').css('display', 'block');
        $('.w3l_agileits_breadcrumbs_inner>ul')
			.append($('<li>')
				.append('Quizes')
        	);
        $('h2.w3_inner_tittle').text('Quizes');
        $('.gn-menu li:nth-child(3)').children('a').css('background','#283242');
        setTimeout(function() {
			$('.lds-dual-ring').css('display','none');
			$('#quizes').css('opacity', '1');
		}, 1000);
    });

    $('.quiz-item').each(function() {
        var target = $(this).children('.quiz-image');
        if (target.has('img').length) {
            target.css('background','#fff');
        }
    });
</script>