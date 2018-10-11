<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>

<div class="w3_agileits_top_nav">
    <ul id="gn-menu" class="gn-menu-main">
        <!-- /nav_agile_w3l -->
        <li>
            <nav class="gn-menu-wrapper gn-open-all">
                <div class="gn-scroller scrollbar1">
                    <ul class="gn-menu agile_menu_drop">
	                    <li>
                            <a href="${pageContext.servletContext.contextPath}">
                                <i class="fa fa-home" aria-hidden="true"></i> Trang chủ
	                        </a>
                        </li>
                        <li>
                            <a href="show-categories">
                                <i class="fa fa-tags" aria-hidden="true"></i> Danh mục chapter
                            </a>
                        </li>
                        <li>
                            <a href="show-questions">
                                <i class="fa fa-question" aria-hidden="true"></i> Quiz
                            </a>
                        </li>
                        <li>
                            <a href="show-versions">
                                <i class=" fa fas fa-info" aria-hidden="true"></i> Phiên bản
                            </a>
                        </li>
                        <li>
                            <a href="show-feedbacks">
                                <i class="fa fa-users" aria-hidden="true"></i> Phản hồi
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </li>
        <!-- //nav_agile_w3l -->
        <li class="second logo" style="float: left !important"><h1>
            <a href="${pageContext.servletContext.contextPath}">
                <i class="fa fa-graduation-cap" aria-hidden="true" ></i>Math Formulas 
            </a>
        </h1></li>
    </ul>
    <!-- //nav -->

</div>
<div class="clearfix"></div>
<!-- //w3_agileits_top_nav-->
