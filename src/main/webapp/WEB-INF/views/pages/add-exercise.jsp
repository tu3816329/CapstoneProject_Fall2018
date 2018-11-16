<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
    label {
        font-weight: bold;
        font-size: 15px;
    }

    input {
        border: 1px solid #ccc;
        color: #555;
        padding: 5px;
    }

	#save-exercise {
		margin-top: 10px;
		background: #0084ff;
		border-radius: 0;
        color: white;
        display: block;
    }
</style>

<div class="content-header">
    <h3 class="content-title">Add exercise</h3>
</div>
<form:form action="save-new-exercise" method="post" modelAttribute="exercise">
    <label for="input">Problem</label>
    <form:textarea path="topic" id="input" /><br>
    <label for="answer" style="margin-top: 20px">Answer</label>
    <form:textarea rows="1" path="answer" id="answer" />
    <form:hidden path="mathformId.id" />
    <button type="submit" class="btn btn-default ld-ext-right content-button" id="save-exercise">
        Save <div class="ld ld-ring ld-spin"></div>
    </button>
</form:form>
<input type="file" id="uploadImg" style="display: none">

<script>
    // $(document).on('click', '#save-exercise', function() {
        
    // });

    $(document).ready(function () {
        // Validation
        $('form').submit(function (e) {
            $('#save-exercise').prop('disabled', true);
            $('#save-exercise').addClass('disabled running');
            var problem = $('#input').val().replace(
                /<br>|<p>|<h1>|<h2>|<h3>|<h4>|<h5>|<h6>|&nbsp;|<\/p>|<\/h1>|<\/h2>|<\/h3>|<\/h4>|<\/h5>|<\/h6>/g, ''
            ).trim();
            var answer = $('#answer').val().replace(
                /<br>|<p>|<h1>|<h2>|<h3>|<h4>|<h5>|<h6>|&nbsp;|<\/p>|<\/h1>|<\/h2>|<\/h3>|<\/h4>|<\/h5>|<\/h6>/g, ''
            ).trim();
            if (problem === '' || problem === null) {
                e.preventDefault();
                $('#save-exercise').removeAttr('disabled');
                $('#save-exercise').removeClass('disabled').removeClass('running');
                $('form>span').remove();
                $('label[for="input"]').next('br').remove();
                $('.fr-wrapper:eq(1)').removeAttr('style');
                $('.fr-counter:eq(1)').removeAttr('style');
                $('<br><span style="color: red; margin-top: 5px">Problem is required</span>').insertAfter($('label[for="input"]'));
                $('.fr-wrapper').first().css('border', '2px solid red');
                $('.fr-counter').first().css('border-bottom', '2px solid red');
                $('.fr-counter').first().css('border-right', '2px solid red');
            } else if (answer === '' || answer === null) {
                e.preventDefault();
                $('#save-exercise').removeAttr('disabled');
                $('#save-exercise').removeClass('disabled').removeClass('running');
                $('form>span').remove();
                $('label[for="answer"]').next('br').remove();
                $('.fr-wrapper').first().removeAttr('style');
                $('.fr-counter').first().removeAttr('style');
                $('<br><span style="color: red; margin-top: 5px">Answer is required</span>').insertAfter($('label[for="answer"]'));
                $('.fr-wrapper:eq(1)').css('border', '2px solid red');
                $('.fr-counter:eq(1)').css('border-bottom', '2px solid red');
                $('.fr-counter:eq(1)').css('border-right', '2px solid red');
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
            height: 250,
            quickInsertTags: [''],
            // quickInsertButtons : [],
            toolbarButtons: ['fullscreen', 'bold', 'italic', 'underline', 'strikeThrough',
                '|', 'fontFamily', 'fontSize', 'color', '|', 'paragraphFormat', 'align',
                'formatOL', 'formatUL', , '-', 'insertImage', 'specialCharacters',
                'insertHR', '|', 'selectAll', 'clearFormatting', '|', 'wirisEditor',
                'undo', 'redo'],
            imageEditButtons: ['wirisEditor', 'imageDisplay', 'imageAlign',
                'imageInfo', 'imageRemove'],
            htmlAllowedTags: ['.*'],
            htmlAllowedAttrs: ['.*'],
        });

        $('#answer').on('froalaEditor.initialized', function (e, editor) {
            $('#loading-img').fadeOut();
            $('#content').children().not('style, script').css('display', 'block');
            $('.content-header').css('display', 'grid');
        });

        $('#answer').froalaEditor({
            toolbarButtons: ['wirisEditor'],
            quickInsertTags: [],
            placeholderText: '',
            htmlAllowedTags: ['.*'],
            htmlAllowedAttrs: ['.*']
        });
    });
</script>