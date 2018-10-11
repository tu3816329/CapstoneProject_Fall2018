<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>

<html>
    <head>
        <title><tiles:getAsString name="title" /></title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="keywords"
              content="Esteem Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
        
        <!-- MathJax -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/latest.js?config=TeX-MML-AM_CHTML" async></script>

        <!-- Jquery -->
		<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/jquery-3.2.1.js"></script>
		<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/jquery-3.2.1.min.js"></script>
    	
        <script type="application/x-javascript">
            addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
            function hideURLbar(){ window.scrollTo(0,1); } 

        </script>
        <!-- //custom-theme -->
        <link href="<c:url value='/resources/static/css/bootstrap.css' />" rel="stylesheet" type="text/css"
              media="all" />
        <link href="<c:url value='/resources/static/css/component.css' />" rel="stylesheet" type="text/css"
              media="all" />
        <link href="<c:url value='/resources/static/css/style_grid.css' />" rel="stylesheet" type="text/css"
              media="all" />
        <link href="<c:url value='/resources/static/css/style.css' />" rel="stylesheet" type="text/css" media="all" />
        <!-- font-awesome-icons -->
        <link href="<c:url value='/resources/static/css/font-awesome.css' />" rel="stylesheet">
        <!-- //font-awesome-icons -->
        <link
            href="//fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800"
            rel="stylesheet">
    </head>
    <body>

        <div class="wthree_agile_admin_info">
            <header id="header">
                <tiles:insertAttribute name="header" ignore="true" />
            </header>

            <!-- /inner_content-->
            <div class="inner_content">
                <!-- /inner_content_w3_agile_info-->

                <!-- breadcrumbs -->
                <div class="w3l_agileits_breadcrumbs">
                    <div class="w3l_agileits_breadcrumbs_inner">
                        <ul>
                        </ul>
                    </div>
                </div>
                <!-- //breadcrumbs -->
                <div class="inner_content_w3_agile_info two_in">
                    <h2 class="w3_inner_tittle"></h2>
                    <!--/forms-->
                    <div class="forms-main_agileits">
                        <!--/forms-inner-->
                        <div class="forms-inner">
                            <!--/set-2-->
                            <div class="wthree_general graph-form agile_info_shadow">
                                <!-- <h3 class="w3_inner_tittle two">General Form</h3> -->

                                <section id="site-content" style="position: relative">
                                    <tiles:insertAttribute name="body" />
                                </section>
                            </div>
                            <!--//set-2-->
                        </div>
                        <!--//forms-inner-->
                    </div>
                    <!--//forms-->
                </div>
                <!-- //inner_content_w3_agile_info-->
            </div>
            <!-- //inner_content-->

            <%-- <footer id="footer" style="">
                <tiles:insertAttribute name="footer" />
            </footer> --%>

        </div>




        <!-- js -->

        <script type="text/javascript" src="<c:url value='/resources/static/js/jquery-2.1.4.min.js' />"></script>
        <script src="<c:url value='/resources/static/js/modernizr.custom.js' />"></script>

        <script src="<c:url value='/resources/static/js/classie.js' />"></script>
        <script src="<c:url value='/resources/static/js/gnmenu.js' />"></script>
        <!-- <script>
            new gnMenu(document.getElementById('gn-menu'));
        </script> -->

        <!-- //js -->
        <script src="<c:url value='/resources/static/js/screenfull.js' />"></script>
        <script>
            $(function () {
                $('#supported').text('Supported/allowed: ' + !!screenfull.enabled);

                if (!screenfull.enabled) {
                    return false;
                }

                $('#toggle').click(function () {
                    screenfull.toggle($('#container')[0]);
                });
            });
        </script>
        <script src="<c:url value='/resources/static/js/jquery.nicescroll.js' />"></script>
        <script src="<c:url value='/resources/static/js/scripts.js' />"></script>

        <script type="text/javascript" src="<c:url value='/resources/static/js/bootstrap-3.1.1.min.js' />"></script>
        <!-- Froala Editor -->
        <!-- Include external CSS. -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" 
        rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/codemirror.min.css">
        <!-- Include Editor style. -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.8.5/css/froala_editor.pkgd.min.css" 
        rel="stylesheet" type="text/css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.8.5/css/froala_style.min.css" 
        rel="stylesheet" type="text/css" />
        <!-- Include Editor JS files. -->
        <script type="text/javascript" 
        src="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.8.5/js/froala_editor.pkgd.min.js"></script>

        <!-- Wiris -->
        <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/wiris/wiris.js"></script>
        <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/wiris/WIRISplugins.js"></script>
        <tiles:insertAttribute name="js"/>
    </body>
</html>