<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

<style>
    #question-input {
        opacity: 0;
    }

    .form-title {
        display: grid;
        height: 30px;
        grid-template-columns: 10% 88%;
        grid-column-gap: 2%;
    }

    #question-input>form>label {
        color: black;
        font-weight: bold;
        font-size: 20px;
        padding: 0;
        text-align: left;
        padding-top: 4px;
    }

    label[for="input"] {
        margin: 15px 0 10px 0;
    }

    input {
        border: 1px solid #ccc;
        color: #555;
        padding: 5px;
    }
    
    #answers {
        display: grid;
        grid-template-columns: 48% 48%;
        grid-column-gap: 4%;
        margin-top: 20px;
    }

    .answer-item {
        margin-top: 20px;
    }

    .answer-item span {
        color: #111;
        font-size: 17px;
    }

    .answer-item textarea {
        resize: none;
    }

    .answer-input {
        display: grid;
        grid-template-columns: 90% 7%;
        grid-column-gap: 3%;
        position: relative;
    }

    .fa-check-circle {
        color: #ddd;
        transform: translateY(-50%);
        position: absolute;
        font-size: 30px;
        right: 0;
        top: 50%;
        cursor: pointer;
    }

	#save-question {
		margin-top: 10px;
		background: #ab0800;
		border-radius: 0;
        color: white;
        display: block;
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

<input type="file" id="uploadImg" style="display: none">
<div id="question-input">
	<form:form action="save-quiz-question" method="post" modelAttribute="qa" acceptCharset="UTF-8">
        <form:hidden path="lessonId"/>
	    <label for="input">Question</label>
	    <button class="btn" id="save-question">Save question</button>
	    <form:textarea id="input" path="questionContent"></form:textarea>
	    <div id="answers">
	        <div class="answer-item">
	            <label for="answer-1"><span>Answer 1</span></label>
	            <div class="answer-input">
	                <form:textarea path="choices[0].content" rows="1" id="answer-1" 
                                    class="answer-textarea"></form:textarea>
                    <form:hidden class="is-correct" path="choices[0].isCorrect"/>
	                <i class="fas fa-check-circle"></i>
	            </div>
	        </div>
	        <div class="answer-item">
	            <label for="answer-2"><span>Answer 2</span></label>
	            <div class="answer-input">
	                <form:textarea path="choices[1].content" rows="1" id="answer-2" 
                                    class="answer-textarea"></form:textarea>
                    <form:hidden class="is-correct" path="choices[1].isCorrect"/>
	                <i class="fas fa-check-circle"></i>
	            </div>
	        </div>
	        <div class="answer-item">
	            <label for="answer-3"><span>Answer 3</span></label>
	            <div class="answer-input">
	                <form:textarea path="choices[2].content" rows="1" id="answer-3" 
                                    class="answer-textarea"></form:textarea>
                    <form:hidden class="is-correct" path="choices[2].isCorrect"/>
	                <i class="fas fa-check-circle"></i>
	            </div>
	        </div>
	        <div class="answer-item">
	            <label for="answer-4"><span>Answer 4</span></label>
	            <div class="answer-input">
	                <form:textarea path="choices[3].content" rows="1" id="answer-4" 
                                    class="answer-textarea"></form:textarea>
                    <form:hidden class="is-correct" path="choices[3].isCorrect"/>
	                <i class="fas fa-check-circle"></i>
	            </div>
	        </div>
	    </div>
	</form:form>
</div>
<div class="lds-dual-ring"></div>

<script>
    $(document).ready(function () {
        $('.lds-dual-ring').css('display', 'block');
        $('.w3l_agileits_breadcrumbs_inner>ul')
            .append($('<li>')
                .append('New question')
            );
    
        //Upload image
        $.FroalaEditor.DefineIcon('image', {NAME: 'uploadImg'});
        $.FroalaEditor.RegisterCommand('insertImage', {
            title: 'Add Image',
            focus: false,
            undo: false,
            refreshAfterCallback: false,
            callback: function () {
                $('#uploadImg').click();
            }
        });
        
        $('#uploadImg').change(function () {
            var file = document.querySelector('input[type=file]').files[0];
            if(file) {
                var reader = new FileReader();
                reader.onloadend = function() {
                    $('#input').froalaEditor('html.insert', 
                                '<img width="200px" src="' + reader.result + '">', false);
                }
                reader.readAsDataURL(file);
            }
            $('#input').froalaEditor('events.focus');
        });
                
        //initialize editor
        $('#input').froalaEditor({
            height: 200,
            iframe: true,
            quickInsertTags: [],
            toolbarButtons : ['fullscreen', 'bold', 'italic', 'underline', 'strikeThrough', 
                    '|', 'fontFamily', 'fontSize', 'color', '|', 'paragraphFormat', 'align', 
                    'formatOL', 'formatUL', , '-', 'insertImage', 'specialCharacters', 
                    'insertHR', '|', 'selectAll', 'clearFormatting', '|', 'wirisEditor', 
                    'undo', 'redo'],
            imageEditButtons: ['wirisEditor', 'imageDisplay', 'imageAlign', 
                                    'imageInfo', 'imageRemove'],
            htmlAllowedTags:   ['.*'],
            htmlAllowedAttrs: ['.*']
        });

        //Remove froala license
        $('a[href^="https://www.froala.com/wysiwyg-editor?k=u"]').remove();

        //End of animation
        setTimeout(function() {
			$('.lds-dual-ring').css('display','none');
			$('#question-input').css('opacity', '1');
        }, 1000);
        
        $('.answer-textarea').froalaEditor({
            toolbarButtons: ['wirisEditor'],
            quickInsertTags: [],
            placeholderText: ''
        });

        $('.fr-box').css('zoom', '0.8');

        // $('.fr-sticky-off').css('border','none');

        $('.answer-item .fr-counter').remove();

        setInterval(function() {
            $('.wrs_modal_dialogContainer').css('zoom','0.8');
        }, 1000);
    });

    $('.fa-check-circle').click(function() {
        var check = $(this);
        if(check.css('color') === 'rgb(0, 128, 0)') {
            check.css('color','#ddd');
            check.siblings('.is-correct').val('false');
        } else {
            check.css('color','green');
            check.siblings('.is-correct').val('true');
        }
    });
</script>