<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>

<style>
	.home-container {
		display: grid;
		grid-template-columns: auto auto auto;
		color: white;
		line-height: 1.42857143;
	}

	.new-data {
		padding: 20px;
		box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
	}

	.new-data:not(:first-child) {
		margin-left: 15px;
	}

	.new-data:not(:last-child) {
		margin-right: 15px;
	}

	.new-data-title {
		text-transform: uppercase;
		font-weight: bold;
	}

	ul.new-data-list {
		list-style: none;
		padding: 0;
	}

	.new-data-list-item {
		padding-top: 10px;
	}

	.new-chapter-list {
		background-color: #E91E63;
	}

	.new-lesson-list {
		background-color: #00BCD4;
	}

	.new-solution-list {
		background-color: #009688;
	}

	#versions-table th,
    #versions-table td {
        text-align: center;
    }
</style>

<div class="content-header">
	<h3 class="content-title" style="font-size: 17px; font-weight: bold">dashboard</h3>
</div>
<div class="home-container">
	<div class="new-data new-chapter-list">
		<p class="new-data-title">New chapters</p>
		<ul class="new-data-list">
			<a:if test="${not empty newchapters}">
				<a:forEach var="nc" items="${newchapters}">
					<li class=" new-data-list-item">${nc.chapterName}</li>
				</a:forEach>
			</a:if>
			<a:if test="${empty newchapters}">
				<li class="new-data-list-item">No new chapter</li>
			</a:if>
		</ul>
	</div>
	<div class="new-data new-lesson-list">
		<p class="new-data-title">New lessons</p>
		<ul class="new-data-list">
			<a:if test="${not empty newlessons}">
				<a:forEach var="nl" items="${newlessons}">
					<li class=" new-data-list-item">${nl.title}</li>
				</a:forEach>
			</a:if>
			<a:if test="${empty newlessons}">
				<li class="new-data-list-item">No new lesson</li>
			</a:if>
		</ul>
	</div>
	<div class="new-data new-solution-list">
		<p class="new-data-title">New math forms</p>
		<ul class="new-data-list">
			<a:if test="${not empty newsolutions}">
				<a:forEach var="nm" items="${newsolutions}">
					<li class=" new-data-list-item">${nm.title}</li>
				</a:forEach>
			</a:if>
			<a:if test="${empty newsolutions}">
				<li class="new-data-list-item">No new math form</li>
			</a:if>
		</ul>
	</div>
</div>
<div style="padding: 20px; margin-top: 20px; background: white; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2)">
	<table id="versions-table" class="table table-hover">
		<thead>
			<tr>
				<th>Name</th>
				<th>Status</th>
			</tr>
		</thead>
		<tbody>
			<a:forEach items="${versions}" var="v">
				<tr>
					<td>${v.versionName}</td>
					<td>
						<a:if test="${v.isCurrent eq true}">
							Activated
						</a:if>
						<a:if test="${v.isCurrent eq false}">
							Deactivated
						</a:if>
					</td>
				</tr>
			</a:forEach>
		</tbody>
	</table>
</div>

<script>
	$(window).on('load', function () {
		$('#loading-img').fadeOut();
		$('#content').css({
			"background-color" : "#e9e9e9",
			"box-shadow" : "none"
		});
		$('#content').children().not('style, script').css('display', 'block');
		$('.home-container').css('display', 'grid');
		$('.content-header').css('display', 'grid');
		// $('#versions-table').css('display', 'table');
	});
</script>