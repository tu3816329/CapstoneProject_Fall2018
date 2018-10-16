<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
	form {
		opacity: 0;
	}

	.form-item {
		display: block;
		margin-bottom: 10px;
		display: grid;
		grid-template-columns: 20% 50%;
		grid-column: 5%;
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

<form:form method="post" action="upgrade-version" modelAttribute="version">
	<div class="form-item">
		<label for="currentVersion">Phiên bản hiện tại</label>
		<input id="currentVersion" type="text" disabled="disabled" 
				value="${latest.databaseVersion} - ${latest.versionName}">
	</div>
	<div class="form-item">
		<label for="databaseVersion">Số phiên bản</label>
		<form:input path="databaseVersion"/>
	</div>
	<div class="form-item">
		<label for="versionName">Version name</label>
		<form:input path="versionName"/>
	</div>
	<button class="btn" id="upgrade" value="Upgrade">Nâng cấp</button>
</form:form>
<div class="lds-dual-ring"></div>

<script>
	$(document).ready(function() {
		$('.lds-dual-ring').css('display', 'block');
		$('h2.w3_inner_tittle').text('Nâng cấp');
		$('.w3l_agileits_breadcrumbs_inner>ul')
			.append($('<li>')
				.append('Phiên bản')
        	);
		setTimeout(function() {
			$('.lds-dual-ring').css('display','none');
			$('form').css('opacity', '1');
		}, 1000);
	});
</script>