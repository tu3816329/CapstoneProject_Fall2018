<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
    .form-title {
        display: grid;
        height: 30px;
        grid-template-columns: 10% 88%;
        grid-column-gap: 2%;
    }

    label {
        color: black;
        font-weight: bold;
        font-size: 15px;
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

    #save-lesson {
        margin-top: 10px;
		border: none;
		background: #0084ff;
		border-radius: 0;
		color: white
    }
</style>

<input type="file" id="uploadImg" style="display: none">

<div class="content-header">
    <h3 class="content-title">Add lesson</h3>
</div>
<form:form method="post" action="save-new-lesson" modelAttribute="lesson" acceptCharset="UTF-8">
    <div class="form-title">
        <label for="lessonTitle">Title</label>
        <form:input path="lessonTitle" id="lessonTitle" />
    </div><br>
    <label for="input">Content</label>
    <form:textarea path="lessonContent" id="input" />
    <form:hidden path="chapterId.id" />
    <input type="submit" value="Save" class="btn content-button" id="save-lesson">
</form:form>

<script>
    $(document).ready(function () {
        // Validation
        $('form').submit(function (e) {
            var lessonTitle = $('#lessonTitle').val().trim();
            var lessonContent = $('#input').val().replace(
                    /<br>|<p>|<h1>|<h2>|<h3>|<h4>|<h5>|<h6>|&nbsp;|<\/p>|<\/h1>|<\/h2>|<\/h3>|<\/h4>|<\/h5>|<\/h6>/g, ''
                ).trim();
            if (lessonTitle === '' || lessonTitle === null) {
                e.preventDefault();
                $('.form-title>span').remove();
                $('form>span').remove();
                $('.fr-wrapper').removeAttr('style');
                $('.fr-counter').removeAttr('style');
                $('#lessonTitle').css('border', '1px solid red');
                $('.form-title').append('<span></span><span style="color: red; margin-top: 5px">Title field is required</span>')
            } else if (lessonContent === '' || lessonContent === null) {
                e.preventDefault();
                $('.form-title>span').remove();
                $('form>span').remove();
                $('label[for="input"]').next('br').remove();
                $('#lessonTitle').removeAttr('style');
                $('<br><span style="color: red; margin-top: 5px">Content is required</span>').insertAfter($('label[for="input"]'));
                $('.fr-wrapper').css('border', '2px solid red');
                $('.fr-counter').css('border-bottom', '2px solid red');
                $('.fr-counter').css('border-right', '2px solid red');
            }
        });

        // Upload image
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
            height: 400,
            iframe: true,
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
        $('a[href^="https://www.froala.com/wysiwyg-editor?k=u"]').remove();
    });
</script>