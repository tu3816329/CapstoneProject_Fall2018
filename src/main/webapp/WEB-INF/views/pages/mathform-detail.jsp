<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>

<style>
	#forms {
		opacity: 0
	}

	#forms .btn {
		border-radius: 0;
		background: #ab0800;
		color: white;
		float: right;
	}
	
	.fa-pencil-square-o {
		float: right;
		color: #ab0800;
		font-size: 20px
	}
	
	.mf-detail {
		margin-bottom: 10px;
		padding: 1em
	}

	.mf-detail h4, .mf-detail span {
		font-weight: bold;
	}

	.mf-detail>span {
		font-size: 1.2em;
	}
	
	#add-mathform {
		margin-top: 10px;
		border: none;
		background: #ab0800;
		border-radius: 0;
		color: white;
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
		<a class="btn" href="add-exercise?mathformId=${MATHFORM.id}">Thêm bài tập</a>
		<span>Nội dung</span>${MATHFORM.mathformContent}
	</div>
	<input type="hidden" value="${MATHFORM.id}" class="m-id">
	<input type="hidden" value="${MATHFORM.mathformTitle}" class="m-title">
</div>
<div class="lds-dual-ring"></div>

<script>
    $(document).ready(function() {
		$('.lds-dual-ring').css('display', 'block');
		$('h2.w3_inner_tittle').text($('.m-title').val());
		$('.w3l_agileits_breadcrumbs_inner>ul').append($('<li>')
													.append('Chapter ')
													.append('<span>«</span>')
												)
												.append($('<li>')
													.append('Công thức ')
													.append('<span>«</span>')
												)
												.append($('<li>')
													.append('Dạng bài')
												);
		getMathformDetails();
		
		setTimeout(function() {
			$('.lds-dual-ring').css('display','none');
			$('#forms').css('opacity', '1');
		}, 1000);
    });

	function getMathformDetails() {
		var mathformId = $('.m-id').val();
		$.ajax ({
			type: 'GET',
			url: 'get-exercises-by-mathform?mathformId=' + mathformId,
			dataType: 'json',
			contentType: 'application/json',
			success: function(res) {
				if(res.length !== 0) {
					$('.mf-detail').append('<br/><span>Một số bài tập thực hành</span>');
				} else {
					$('.mf-detail').append('<br/><p>Chưa có bài tập nào</p>');
				}
				for(var i = 0; i < res.length; i++) {
					$('.mf-detail')
						.append('<br/><h5><a href="edit-exercise?exId=' + res[i].id + 
								'"><span>Bài ' + (i + 1) + 
								'</span>: ' + res[i].topic + '</a></h5>'
						)
						.append('<p><span>Đáp án</span>: ' + res[i].answer + '</p>');
				}
			},
			error: function(res) {
				alert('Some errors occured while loading mathform data');
			}
		});
	}
</script>