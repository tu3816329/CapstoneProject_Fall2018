<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Jquery -->
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/jquery-3.2.1.js"></script>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/jquery-3.2.1.min.js"></script>

<!-- MathJax -->
<script type="text/javascript" 
		src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/latest.js?
			config=TeX-MML-AM_CHTML" async></script>
					
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Froala Editor -->
<!-- Include external CSS. -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/codemirror.min.css">
<!-- Include Editor style. -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.8.5/css/froala_editor.pkgd.min.css" rel="stylesheet" type="text/css" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.8.5/css/froala_style.min.css" rel="stylesheet" type="text/css" />

<!-- Include Editor JS files. -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.8.5/js/froala_editor.pkgd.min.js"></script>

<!-- Wiris -->
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/wiris/wiris.js"></script>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/wiris/WIRISplugins.js"></script>

<script>
	//Display categories by selected division
	$(".div-drop-menu").find("a").click(function (e) {
		e.preventDefault();
		$(".div-btn").text($(this).text() + " ").append($('<span class="caret">'));
		$(".cat-btn").text("Chọn loại ").append($('<span class="caret">'));
	
		$.ajax({
			url : 'get-categories-by-division?divId=' + $(this).attr('href'),
			type : 'GET',
			contentType : 'application/json',
			dataType: 'json',
			success: function(res) {
				$(".cat-drop-menu").empty();
				for(var i = 0; i < res.length; i++) {
					$(".cat-drop-menu").append($('<li>')
						.append($('<a href="' + res[i].id + '">')
							.append(res[i].categoryName)
						)
					)
				}
				$(".cat-drop-menu").append($('<li>')
					.append($('<a href="add-cateogry">')
						.append("Thêm loại...")
					)
				)
	
				$(".cat-drop-menu").find('a').click(function (e) {
					e.preventDefault();
					$("#catId").val($(this).attr('href'));
					$(".cat-btn").text($(this).text() + " ").append($('<span class="caret">'));
					$("#btnSave").css('display', 'inline-block');
				});
			},
			error: function(res) {
				alert('Some errors occured');
			}
		});
	});
	
	//Save formula
	$("#btnSave").click(function () {
		if ($.trim($('#input').val())) {
			var input = $('#input').val();
			var data = {
					'id' : 0,
					'detail' : input
			};
			$.ajax({
				url : 'save-formula?catId=' + $("#catId").val(),
				type : 'POST',
				dataType : 'json',
				contentType : 'application/json',
				data : JSON.stringify(data),
				success: function(res) {
					if(res.status === 'success') {
						alert("Saved!");
					} else {
						alert('Save formula fail');
					}
				},
				error: function(res) {
					alert('Save formula fail');
				}
			});
		}
	});
	
	$(document).ready(function () {

		$.FroalaEditor.DefineIcon('image', {NAME: 'uploadImg'});
	    $.FroalaEditor.RegisterCommand('insertImage', {
	    	title: 'Hello',
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
					    	'<img width="150px" src="' + reader.result + '">', false);
			    }
			    reader.readAsDataURL(file);
	    	}
		});
		
		//initialize editor
		$('#input').froalaEditor({
			height: 150,
			width: 700,
			iframe: true,
			toolbarButtons : ['fullscreen', 'bold', 'italic', 'underline', 'strikeThrough', 
				'|', 'fontFamily', 'fontSize', 'color', '|', 'paragraphFormat', 'align', 
				'formatOL', 'formatUL', , '-', 'insertImage', 'specialCharacters', 'insertHR', '|', 'selectAll', 
				'clearFormatting', '|', 'wirisEditor', 'undo', 'redo'],
		    imageEditButtons: ['wirisEditor', 'imageDisplay', 'imageAlign', 'imageInfo', 'imageRemove'],
		    // Allowed tags
		    htmlAllowedTags:   ['.*'],
		    htmlAllowedAttrs: ['.*'], 
		});

		$('a[href^="https://www.froala.com/wysiwyg-editor?k=u"]').remove();
	});
	
	$("#btnUpload").click(function () {
		$(this).hide();
		$("#imgDiv").css("display","block");
	});
	
	$("#cancelAddImg").click(function () {
		$("#btnUpload").show();
		$("#imgDiv").css("display","none");
		$("#imgUrl").val('');
	});
	
	$("#addImg").click(function () {
		var imgUrl = $("#imgUrl").val();
		var xhr = new XMLHttpRequest();
		xhr.onload = function() {
			var reader = new FileReader();
		    reader.onloadend = function() {
		    	$('#input').froalaEditor('html.insert', 
				    	'<img width="150px" src="' + reader.result + '">', false);
		    }
		    reader.readAsDataURL(xhr.response);
		};
		xhr.open('GET', imgUrl);
		xhr.responseType = 'blob';
		xhr.send();
		$("#cancelAddImg").click();
	});

	$('#input').on('froalaEditor.image.uploaded', function (e, editor, response) {
		
	});
</script>