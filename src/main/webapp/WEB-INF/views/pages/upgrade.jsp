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

	.error {
		color: red;
		margin-left: 10px;
	}
</style>

<div class="content-header">
	<h3 class="content-title">Upgrade version</h3>
</div>
<input type="hidden" value="${latest.databaseVersion}" id="latestDbVersion">
<form:form method="post" action="upgrade-version" modelAttribute="version">
	<div class="form-item">
		<label for="currentVersion">Current version</label>
		<input id="currentVersion" type="text" disabled="disabled" value="${latest.databaseVersion} - ${latest.versionName}">
	</div>
	<div class="form-item">
		<label for="databaseVersion">Version number</label>
		<form:input path="databaseVersion" />
		<span class="error"></span>
	</div>
	<div class="form-item">
		<label for="versionName">Version name</label>
		<form:input path="versionName" />
		<span class="error"></span>
	</div>
	<button class="btn content-button" id="upgrade" value="Upgrade">Save</button>
</form:form>

<script>
	$(document).ready(function () {
		$('h2.w3_inner_tittle').text('Upgrade');
		$('.w3l_agileits_breadcrumbs_inner>ul')
			.append($('<li>')
				.append('Upgrade version')
			);
	});

	// Validation
	$('form').submit(function (e) {
		$('#databaseVersion').removeAttr('style');
		$('#versionName').removeAttr('style');
		var databaseVersion = $('#databaseVersion').val().trim();
		var versionName = $('#versionName').val().trim();
		if (databaseVersion === '' || databaseVersion === null) {
			e.preventDefault();
			$('#databaseVersion').css('border', '1px solid red');
			$('span.error:eq(0)').text('Please input database version');
		} else if(databaseVersion < $('#latestDbVersion').val()) {
			e.preventDefault();
			$('#databaseVersion').css('border', '1px solid red');
			$('span.error:eq(0)').text('New database version must be greater than current database version');
		} else if (versionName === '' || versionName === null) {
			e.preventDefault();
			$('#versionName').css('border', '1px solid red');
			$('span.error:eq(1)').text('Please input version name');
		}
	});
</script>