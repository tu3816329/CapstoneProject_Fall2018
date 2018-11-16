<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<style>
	/* Side menu */
	#side-menu {
		padding: 0 15px;
		white-space: nowrap;
		background: #fdfdfd;
		width: 320px;
		font-family: 'Roboto-Bold';
		height: 100%;
		position: fixed;
	}

	.side-menu-item {
		margin-bottom: 20px;
	}

	.side-menu-item span {
		margin: 7px 10px 7px 12px;
		color: #333;
		font-weight: bold;
	}

	.side-menu-item i {
		color: #747474;
		width: 20px;
		font-size: 20px;
	}

	.side-menu-item>a {
		font-size: 17px;
	}

	/* Tree menu */
	#tree-menu {
		padding: 0 15px 15px 15px;
		margin: 0;
		display: none;
		margin-bottom: 10px;
		white-space: nowrap;
	}

	ul.division-tree {
		padding: 0 27px;
	}

	ul.chapter-tree {
		padding: 0 32px;
	}

	ul.lesson-tree,
	ul.mathform-tree {
		padding: 0 30px;
	}

	#tree-menu li {
		color: black;
		font-size: 18px;

	}

	.nested {
		display: none;
	}

	.active {
		display: block;
	}

	#tree-menu i.fas {
		cursor: pointer;
		margin-right: 5px;
	}

	.fa-plus-square,
	.fa-minus-square {
		color: black;
		margin-right: 10px !important;
	}

	.fa-folder-open {
		color: #efec0e;
	}

	.fa-box {
		color: #317471;
	}

	.fa-book {
		color: #ffa500;
	}

	.fa-file {
		color: #2170ba;
	}

	.fa-caret-square-right {
		color: darkorchid;
	}

	#info {
		margin: 0 -15px;
		height: 135px;
		padding: 13px 15px 12px 25px;
		background: url('resources/images/user-img-background.png');
	}

	#info>.image {
		display: inline-block;
	}

	#info img {
		width: 48px;
		height: 48px;
		border-radius: 50%;
	}

	.info-container>span {
		font-size: 16px;
		color: white;
	}

	.info-container {
		position: relative;
		top: 25px;
	}

	.legal {
		border-top: 1px solid #eee;
		padding: 20px 30px;
		margin: 0 -15px;
		width: 320px;
		bottom: 0;
		position: fixed;
		background: #fdfdfd;
	}

	.menu {
		position: fixed;
		height: 500px;
		overflow: auto;
		width: 320px;
		margin: 0 -15px;
		padding: 0 15px;
	}
</style>

<sec:authentication property="principal.username" var="username" />
<div id="info">
	<div class="image">
		<img src="${pageContext.servletContext.contextPath}/resources/images/user.png">
	</div>
	<div class="info-container">
		<span>${username}</span>
	</div>
</div>
<!-- Side menu item -->
<div class="menu">
	<div class="side-menu-item" style="margin-top: 30px"><a href="${pageContext.servletContext.contextPath}/">
			<i class="fas fa-home"></i>
			<span>Home</span>
		</a></div>
	<div class="side-menu-item"><a href="show-chapters">
			<i class="fas fa-desktop"></i>
			<span>Data Management</span>
		</a></div>
	<div class="side-menu-item"><a href="show-questions">
			<i class="fas fa-question"></i>
			<span>Quiz</span>
		</a></div>
	<div class="side-menu-item"><a href="show-versions">
			<i class="fas fa-code-branch"></i>
			<span>Versions</span>
		</a></div>
	<div id="data-explorer" class="side-menu-item"><a href="#">
			<i class="fas fa-wrench"></i>
			<span>Data Explorer</span>
		</a></div>

	<!-- Tree menu -->
	<ul id="tree-menu">
		<a:forEach items="${gradetree}" var="grade">
			<li class="grade-item">
				<i class="fas fa-plus-square"> </i><i class="fas fa-folder-open"></i>
				${grade.gradeName}
				<ul class="nested division-tree">
					<a:forEach items="${divisiontree}" var="division">
						<li class="division-item">
							<i class="fas fa-plus-square"></i> <i class="fas fa-box"></i>
							${division.divisionName}
							<ul class="nested chapter-tree">
								<a:forEach items="${chaptertree}" var="chapter">
									<a:if test="${chapter.divisionId.id eq division.id and chapter.gradeId.id eq grade.id}">
										<li class="chapter-item">
											<i class="fas fa-plus-square"></i> <i class="fas fa-book"></i>
											<a href="show-lessons?chapterId=${chapter.id}">
												${chapter.chapterName}</a>
											<ul class="nested lesson-tree">
												<a:forEach items="${lessontree}" var="lesson">
													<a:if test="${lesson.chapterId.id eq chapter.id}">
														<li class="less-item">
															<i class="fas fa-plus-square"></i> <i class="fas fa-file"></i>
															<a href="show-mathforms?lessonId=${lesson.id}">
																${lesson.lessonTitle}</a>
															<ul class="nested mathform-tree">
																<a:forEach items="${mathformtree}" var="mathform">
																	<a:if test="${mathform.lessonId.id eq lesson.id}">
																		<li class="mathform-item">
																			<i class="fas fa-caret-square-right"></i>
																			<a href="mathform-detail?mathformId=${mathform.id}">
																				${mathform.mathformTitle}</a>
																		</li>
																	</a:if>
																</a:forEach>
															</ul>
														</li>
													</a:if>
												</a:forEach>
											</ul>
										</li>
									</a:if>
								</a:forEach>
							</ul>
						</li>
					</a:forEach>
				</ul>
			</li>
		</a:forEach>
	</ul>
</div>

<div class="legal">
	<div class="copyright">© 2018 - 2019 <b style="color: #2170ba">Math Formulas</b></div>
	<div class="version"><b>Version: </b> ${currentversion.versionName}</div>
</div>

<script>
	$(document).on('click', '#data-explorer', function () {
		if ($('#tree-menu').css('display') === 'none') {
			$('#tree-menu').css('display', 'block');
		} else {
			$('#tree-menu').css('display', 'none');
		}
	});

	$(document).on('click', 'i.fa-plus-square, i.fa-minus-square', function () {
		$(this).siblings('.nested').toggleClass('active');
		if ($(this).siblings('.nested').hasClass('active')) {
			$(this).attr('class', 'fas fa-minus-square');
		} else {
			$(this).attr('class', 'fas fa-plus-square');
		}
	});
</script>