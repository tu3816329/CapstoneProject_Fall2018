<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
    crossorigin="anonymous">

<style>
    .form-title {
        display: grid;
        height: 30px;
        grid-template-columns: 10% 88%;
        grid-column-gap: 2%;
    }
    
    label {
    	font-weight: bold;
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
		width: fit-content;
		height: fit-content;
        float: right;
    }
</style>

<input type="file" id="uploadImg" style="display: none">
<form:form action="save-quiz-question" method="post" modelAttribute="qa" acceptCharset="UTF-8">
    <div class="content-header">
        <h3 class="content-title">Add quiz question</h3>
        <button class="btn content-button" id="save-question">Save</button>
    </div>
    <div id="question-input">
        <form:hidden path="lessonId" />
        <label for="input">Question</label>
        <form:textarea id="input" path="questionContent"></form:textarea>
        <div id="answers">
            <div class="answer-item">
                <label for="answer-1"><span>Answer 1</span></label>
                <div class="answer-input">
                    <form:textarea path="choices[0].content" rows="1" id="answer-1" class="answer-textarea"></form:textarea>
                    <form:hidden class="is-correct" path="choices[0].isCorrect" />
                    <i class="fas fa-check-circle"></i>
                </div>
            </div>
            <div class="answer-item">
                <label for="answer-2"><span>Answer 2</span></label>
                <div class="answer-input">
                    <form:textarea path="choices[1].content" rows="1" id="answer-2" class="answer-textarea"></form:textarea>
                    <form:hidden class="is-correct" path="choices[1].isCorrect" />
                    <i class="fas fa-check-circle"></i>
                </div>
            </div>
            <div class="answer-item">
                <label for="answer-3"><span>Answer 3</span></label>
                <div class="answer-input">
                    <form:textarea path="choices[2].content" rows="1" id="answer-3" class="answer-textarea"></form:textarea>
                    <form:hidden class="is-correct" path="choices[2].isCorrect" />
                    <i class="fas fa-check-circle"></i>
                </div>
            </div>
            <div class="answer-item">
                <label for="answer-4"><span>Answer 4</span></label>
                <div class="answer-input">
                    <form:textarea path="choices[3].content" rows="1" id="answer-4" class="answer-textarea"></form:textarea>
                    <form:hidden class="is-correct" path="choices[3].isCorrect" />
                    <i class="fas fa-check-circle"></i>
                </div>
            </div>
        </div>
    </div>
</form:form>

<script>
    $(document).ready(function () {
        // Validation
        $('form').submit(function (e) {
            $('label[for="input"]').next('br').remove();
            $('label[for="input"]').next('span').remove();

            var question = $('#input').val().replace(
                /<br>|<p>|<h1>|<h2>|<h3>|<h4>|<h5>|<h6>|&nbsp;|<\/p>|<\/h1>|<\/h2>|<\/h3>|<\/h4>|<\/h5>|<\/h6>/g, ''
            ).trim();
            var answer1 = $('#answer-1').val().replace(
                /<br>|<p>|<h1>|<h2>|<h3>|<h4>|<h5>|<h6>|&nbsp;|<\/p>|<\/h1>|<\/h2>|<\/h3>|<\/h4>|<\/h5>|<\/h6>/g, ''
            ).trim();
            var answer2 = $('#answer-2').val().replace(
                /<br>|<p>|<h1>|<h2>|<h3>|<h4>|<h5>|<h6>|&nbsp;|<\/p>|<\/h1>|<\/h2>|<\/h3>|<\/h4>|<\/h5>|<\/h6>/g, ''
            ).trim();
            var answer3 = $('#answer-3').val().replace(
                /<br>|<p>|<h1>|<h2>|<h3>|<h4>|<h5>|<h6>|&nbsp;|<\/p>|<\/h1>|<\/h2>|<\/h3>|<\/h4>|<\/h5>|<\/h6>/g, ''
            ).trim();
            var answer4 = $('#answer-4').val().replace(
                /<br>|<p>|<h1>|<h2>|<h3>|<h4>|<h5>|<h6>|&nbsp;|<\/p>|<\/h1>|<\/h2>|<\/h3>|<\/h4>|<\/h5>|<\/h6>/g, ''
            ).trim();

            var isCheck = false;
            $('.fa-check-circle').each(function () {
                if ($(this).css('color') === 'rgb(0, 128, 0)') {
                    isCheck = true;
                }
            });

            if (question === '' || question === null) {
                e.preventDefault();
                $('.fr-wrapper:eq(1), .fr-wrapper:eq(2), .fr-wrapper:eq(3), .fr-wrapper:eq(4)').removeAttr('style');
                $('.fr-counter:eq(1), .fr-counter:eq(2), .fr-counter:eq(3), .fr-counter:eq(4)').removeAttr('style');
                $('.fr-wrapper:eq(0)').css('border', '2px solid red');
                $('.fr-counter:eq(0)').css('border-bottom', '2px solid red');
                $('.fr-counter:eq(0)').css('border-right', '2px solid red');
            } else if (answer1 === '' || answer1 === null) {
                e.preventDefault();
                $('.fr-wrapper:eq(0), .fr-wrapper:eq(2), .fr-wrapper:eq(3), .fr-wrapper:eq(4)').removeAttr('style');
                $('.fr-counter:eq(0), .fr-counter:eq(2), .fr-counter:eq(3), .fr-counter:eq(4)').removeAttr('style');
                $('.fr-wrapper:eq(1)').css('border', '2px solid red');
                $('.fr-counter:eq(1)').css('border-bottom', '2px solid red');
                $('.fr-counter:eq(1)').css('border-right', '2px solid red');
            } else if (answer2 === '' || answer2 === null) {
                e.preventDefault();
                $('.fr-wrapper:eq(0), .fr-wrapper:eq(1), .fr-wrapper:eq(3), .fr-wrapper:eq(4)').removeAttr('style');
                $('.fr-counter:eq(0), .fr-counter:eq(1), .fr-counter:eq(3), .fr-counter:eq(4)').removeAttr('style');
                $('.fr-wrapper:eq(2)').css('border', '2px solid red');
                $('.fr-counter:eq(2)').css('border-bottom', '2px solid red');
                $('.fr-counter:eq(2)').css('border-right', '2px solid red');
            } else if (answer3 === '' || answer3 === null) {
                e.preventDefault();
                $('.fr-wrapper:eq(0), .fr-wrapper:eq(1), .fr-wrapper:eq(2), .fr-wrapper:eq(4)').removeAttr('style');
                $('.fr-counter:eq(0), .fr-counter:eq(1), .fr-counter:eq(2), .fr-counter:eq(4)').removeAttr('style');
                $('.fr-wrapper:eq(3)').css('border', '2px solid red');
                $('.fr-counter:eq(3)').css('border-bottom', '2px solid red');
                $('.fr-counter:eq(3)').css('border-right', '2px solid red');
            } else if (answer4 === '' || answer4 === null) {
                e.preventDefault();
                $('label[for="input"]').next('br').remove();
                $('.fr-wrapper:eq(0), .fr-wrapper:eq(1), .fr-wrapper:eq(2), .fr-wrapper:eq(3)').removeAttr('style');
                $('.fr-counter:eq(0), .fr-counter:eq(1), .fr-counter:eq(2), .fr-counter:eq(3)').removeAttr('style');
                $('.fr-wrapper:eq(4)').css('border', '2px solid red');
                $('.fr-counter:eq(4)').css('border-bottom', '2px solid red');
                $('.fr-counter:eq(4)').css('border-right', '2px solid red');
            } else if (!isCheck) {
                e.preventDefault();
                $('<br><span style="color: red; margin-top: 5px">Please choose at least one correct answer</span>').insertAfter($('label[for="input"]'));
            }
        });

        //Upload image
        $.FroalaEditor.DefineIcon('image', { NAME: 'uploadImg' });
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
            if (file) {
                var reader = new FileReader();
                reader.onloadend = function () {
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
            toolbarButtons: ['fullscreen', 'bold', 'italic', 'underline', 'strikeThrough',
                '|', 'fontFamily', 'fontSize', 'color', '|', 'paragraphFormat', 'align',
                'formatOL', 'formatUL', , '-', 'insertImage', 'specialCharacters',
                'insertHR', '|', 'selectAll', 'clearFormatting', '|', 'wirisEditor',
                'undo', 'redo'],
            imageEditButtons: ['wirisEditor', 'imageDisplay', 'imageAlign',
                'imageInfo', 'imageRemove'],
            htmlAllowedTags: ['.*'],
            htmlAllowedAttrs: ['.*']
        });

        //Remove froala license
        $('a[href^="https://www.froala.com/wysiwyg-editor?k=u"]').remove();

        $('.answer-textarea').froalaEditor({
            toolbarButtons: ['wirisEditor'],
            quickInsertTags: [],
            placeholderText: ''
        });

        $('.answer-item .fr-counter').remove();
    });

    $('.fa-check-circle').click(function () {
        var check = $(this);
        if (check.css('color') === 'rgb(0, 128, 0)') {
            check.css('color', '#ddd');
            check.siblings('.is-correct').val('false');
        } else {
            check.css('color', 'green');
            check.siblings('.is-correct').val('true');
        }
    });
</script>