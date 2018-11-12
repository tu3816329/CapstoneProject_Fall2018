<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>

<style>
	#add-exercise {
		width: fit-content;
		height: fit-content;
	}

    #mathform-content {
        border-bottom: 1px solid darkgray;
        margin-bottom: 15px;
        display: grid;
        grid-template-columns: 90% 5% 5%;
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
		margin: 0;
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
        grid-template-columns: 90% 5% 5%;
    }

    .exercise-content>span:nth-child(1) {
        padding-top: 15px;
    }

	.exercise-content>span:nth-child(1)>p {
		margin-top: 0;
	}

    .exercise-content>span:nth-child(2), .exercise-content>span:nth-child(3) {
        padding-top: 10px;
		text-align: right;
    }

	.exercise-content>span:nth-child(3) {
		text-align: center;
	}

	.exercise-content>span:nth-child(4)>p {
		margin: 0 0 10px 0;
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
</style>

<div class="content-header">
	<h3 class="content-title">${MATHFORM.mathformTitle}</h3>
	<a id="add-exercise" href="add-exercise?mathformId=${MATHFORM.id}" class="btn content-button">
			<i class="fas fa-plus-circle"></i> New exercise</a>
</div>
<div id="mathform-content">
    <span>${MATHFORM.mathformContent}</span>
    <span>
        <a href="edit-mathform?mathformId=${MATHFORM.id}">
            <p><i style="color: #0084ff" class="fas fa-edit"></i></p></a>
    </span>
    <span>
        <a href="delete-mathform?mathformId=${MATHFORM.id}&lessonId=${MATHFORM.lessonId.id}">
            <p><i style="color: red" class="fas fa-times"></i></p></a>
    </span>
</div>
<input type="hidden" value="${MATHFORM.id}" class="m-id">
<input type="hidden" value="${MATHFORM.mathformTitle}" class="m-title">
<div id="exercises">
	<a:forEach items="${exercises}" var="ex" varStatus="counter">
        <div class="exercise-item">
            <div class="seq-no"><h1><span>${counter.count}</span></h1></div>
            <div class="exercise-content">
                <span style="font-weight: bold">${ex.topic}</span>
                <span>
                    <a href="edit-exercise?exId=${ex.id}"><i class="fas fa-edit"></i></a>
                </span>
                <span>
                    <a href="delete-exercise?exId=${ex.id}&mathformId=${ex.mathformId.id}"><i class="fas fa-times"></i></a>
				</span>
				<span>${ex.answer}</span>
            </div>
        </div>
	</a:forEach>
</div>