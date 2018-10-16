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
        background: #ab0800;
        border-radius: 0;
        color: white
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

<input type="hidden" value="${lesson.categoryId.divisionId.divisionName}" id="divName">
<input type="hidden" value="${lesson.categoryId.categoryName}" id="catName">
<input type="file" id="uploadImg" style="display: none">
<form:form method="post" action="save-edit-lesson" modelAttribute="lesson" acceptCharset="UTF-8" style="opacity: 0">
    <form:hidden path="id"/>
    
    <div class="form-title">
        <label for="lessonTitle">CHỦ ĐỀ</label>
        <form:input path="lessonTitle" id="lessonTitle"/>
    </div>
    <label for="input">NỘI DUNG</label>
    <form:textarea path="lessonContent" id="input"/>
    
    <input type="submit" value="Lưu Thay Đổi" class="btn" id="save-lesson">
</form:form>
<div class="lds-dual-ring"></div>

<script>
        $(document).ready(function () {
            $('.lds-dual-ring').css('display', 'block');
            var divisionName = $('#divName').val();
            var categoryName = $('#catName').val();
            $('h2.w3_inner_tittle').text('Sửa công thức');
            $('.w3l_agileits_breadcrumbs_inner>ul')
                .append($('<li>')
                    .append(divisionName + ' ')
                    .append('<span>«</span>')
                )
                .append($('<li>')
                    .append(categoryName + ' ')
                    .append('<span>«</span>')
                )
                .append('<li>Sửa Công Thức</li>');
    
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
                height: 400,
                iframe: true,
                quickInsertTags: [''],
                // quickInsertButtons : [],
                toolbarButtons : ['fullscreen', 'bold', 'italic', 'underline', 'strikeThrough', 
                        '|', 'fontFamily', 'fontSize', 'color', '|', 'paragraphFormat', 'align', 
                        'formatOL', 'formatUL', , '-', 'insertImage', 'specialCharacters', 
                        'insertHR', '|', 'selectAll', 'clearFormatting', '|', 'wirisEditor', 
                        'undo', 'redo'],
                imageEditButtons: ['wirisEditor', 'imageDisplay', 'imageAlign', 
                                        'imageInfo', 'imageRemove'],
                htmlAllowedTags:   ['.*'],
                htmlAllowedAttrs: ['.*'],
            });
            $('a[href^="https://www.froala.com/wysiwyg-editor?k=u"]').remove();
            $('.fr-box').css('zoom', '0.8');

            setTimeout(function() {
                $('.lds-dual-ring').css('display','none');
                $('form').css('opacity', '1');
		    }, 1000);

            setInterval(function() {
                $('.wrs_modal_dialogContainer').css('zoom','0.8');
            }, 1000);
        });
    </script>