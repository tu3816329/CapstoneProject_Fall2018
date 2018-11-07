<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>

<style>
	#forms, #exercises {
		opacity: 0
	}
	
	#add-ex {
		border: none;
		background: #ab0800;
		border-radius: 0;
		color: white;
		float: right;
	}

	/* Mathform */
	.mf-detail {
		margin-bottom: 10px;
		padding: 20px;
	}

	.mf-detail>a {
		float: right;
		font-size: 17px;
		color: #ab0800;
	}

	/* Exercises */
    .exercise-item {
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

    .exercise-content {
        background: #f2f2f2;
        padding-left: 20px;
        display: grid;
        grid-template-columns: 85% 5% 5%;
        grid-column-gap: 2.5%;
    }

    .exercise-content>span:nth-child(1) {
        padding-top: 10px;
    }

    .exercise-content>span:nth-child(2), .exercise-content>span:nth-child(3) {
        padding-top: 10px;
        text-align: right;
    }

    .exercise-content a {
        margin-right: 15px;
    }

    .exercise-content .fas {
        font-size: 17px;
        color: #555;
    }

    .fa-times {
        font-size: 20px !important;
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

<div id="forms">
	<div class="mf-detail">
		<a href="edit-mathform?mathformId=${MATHFORM.id}"><i class="fas fa-edit"></i></a>
		${MATHFORM.mathformContent}
	</div>
	<input type="hidden" value="${MATHFORM.id}" class="m-id">
	<input type="hidden" value="${MATHFORM.mathformTitle}" class="m-title">
</div>
<div id="exercises">
	<a:forEach items="${exercises}" var="ex" varStatus="counter">
        <div class="exercise-item">
            <div class="seq-no"><h1><span>${counter.count}</span></h1></div>
            <div class="exercise-content">
                <span>${ex.topic}</span>
                <span>
                    <a href="edit-exercise?exId=${ex.id}"><i class="fas fa-edit"></i></a>
                </span>
                <span>
                    <a href="delete-exercise?exId=${ex.id}&mathformId=${ex.mathformId.id}"><i class="fas fa-times"></i></a>
				</span>
				<span>Answer: ${ex.answer}</span>
            </div>
        </div>
	</a:forEach>
</div>
<div class="lds-dual-ring"></div>

<script>
    $(document).ready(function() {
		$('.lds-dual-ring').css('display', 'block');
		$('h2.w3_inner_tittle').text($('.m-title').val());
		$('h2.w3_inner_tittle')
			.append('<a id="add-ex" class="btn" href="add-exercise?mathformId=' + $('.m-id').val() + '">New exercise</a>');
		$('.w3l_agileits_breadcrumbs_inner>ul').append($('<li>')
													.append('Chapter ')
													.append('<span>«</span>')
												)
												.append($('<li>')
													.append('Lesson ')
													.append('<span>«</span>')
												)
												.append($('<li>')
													.append('Math form')
												);		
		setTimeout(function() {
			$('.lds-dual-ring').css('display','none');
			$('#forms, #exercises').css('opacity', '1');
		}, 1000);
    });
</script>