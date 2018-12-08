<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
	.form-item {
		display: block;
		margin-bottom: 10px;
		display: grid;
		grid-template-columns: 20% 50% 30%;
	}

	label {
        color: black;
        font-weight: bold;
        font-size: 15px;
        padding: 0;
        text-align: left;
        padding-top: 4px;
	}

	input {
        border: 1px solid #ccc;
        color: #555;
        padding: 5px;
	}

	#upgrade {
		margin-top: 10px;
		border: none;
		background: #0084ff;
		border-radius: 0;
		color: white;
	}

	span.error {
		color: red;
		margin-left: 10px;
	}
</style>

<div class="content-header">
	<h3 class="content-title">Release new version</h3>
</div>
<form:form method="post" action="upgrade-version" modelAttribute="version">
	<div class="form-item">
		<label for="currentVersion">Current version</label>
		<input id="currentVersion" type="text" disabled="disabled" value="${latest.id} - ${latest.versionName}">
	</div>
	<div class="form-item">
		<label for="versionName">Version name</label>
		<form:input path="versionName" />
		<span class="error"></span>
	</div>
	<button class="btn content-button" id="upgrade" value="Upgrade">Save</button>
</form:form>

<script>
	$(window).on('load', function () {
		$('#loading-img').fadeOut();
		$('#content').children().not('style, script').css('display', 'block');
		$('.content-header').css('display', 'grid');
	});

	// Validation
	$('form').submit(function (e) {
		$('#versionName').removeAttr('style');
		var versionName = $('#versionName').val().trim();
		if (versionName === '' || versionName === null) {
			e.preventDefault();
			$('#versionName').css('border', '1px solid red');
			$('span.error:eq(1)').text('Please input version name');
		}
	});
</script>