<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>

<html>

<head>
    <title>
        <tiles:getAsString name="title" />
    </title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="keywords" content="Esteem Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />

    <!-- MathJax -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/latest.js?config=TeX-MML-AM_CHTML"
        async></script>

    <!-- Jquery -->
    <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/jquery-3.2.1.min.js"></script>
    <!-- Editable table -->
    <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/jquery/mindmup-editabletable.js"></script>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/bootstrap-3.3.7/dist/css/bootstrap.min.css">
    <script src="${pageContext.servletContext.contextPath}/resources/bootstrap-3.3.7/dist/js/bootstrap.min.js"></script>

    <!-- Loading.io -->
    <link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/resources/loading/loading.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/resources/loading/loading-btn.css" />

    <style>
        @font-face {
            font-family: 'Roboto-Bold';
            src: url('resources/fonts/roboto/Roboto-Regular.ttf');
        }
        html {
            font-family: 'Roboto-Bold';
            height: 100%;
        }

        body {
            margin: 0;
            height: 100%;
        }

        ::-webkit-scrollbar {
            background-color: #fff;
            width: 5px;
            height: 5px;
        }

        ::-webkit-scrollbar-track {
            background-color: #ccc;
        }

        ::-webkit-scrollbar-thumb {
            background-color: #0084ff;
            border-radius: 10px;
            width: 5px;
        }

        a {
            text-decoration: none !important;
            user-select: none;
            -webkit-user-select: none;
        }

        ul {
            list-style-type: none;
        }

        li {
            user-select: none;
            -webkit-user-select: none;
            margin-top: 5px;
        }

        .btn {
            padding: 10px 20px;
        }

        /* Container */
        #container {
            display: grid;
            grid-template-columns: 320px auto;
            overflow-y: auto;
        }

        /* Content */
        #content {
            padding: 20px;
            background: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            min-height: 650px;
        }

        #content>* {
            display: none;
        }

        .content-header {
            display: grid;
            grid-template-columns: 75% 25%;
            margin-bottom: 20px;
        }

        .content-title {
            text-transform: uppercase;
            margin: auto 0;
        }

        .content-button {
            margin-top: 10px;
            background: #0084ff;
            color: white;
        }

        .content-button:hover {
            background: #0084ff;
            color: white;
        }

        .content-button:focus {
            color: white;
        }

        /* Search bar */
        #search-bar {
            margin: auto;
            border-radius: 5px;
            border: 1px solid darkgray;
            padding: 10px;
            width: 100%;
        }

        /* Froala license */
        a[href="https://www.froala.com/wysiwyg-editor?k=u"] {
            display: none !important;
            position: absolute;
            top: -99999999px;
        }

        /* Handsontable */
        .handsontable th {
            font-weight: bold
        }

        /* Loading gif */
        #loading-img {
            position: fixed;
            top: 50%;
            left: calc(50% + 160px);
            transform: translateY(-50%) translateX(-50%);
            z-index: 99;
        }

        /* File */
        input[type="file"] {
            display: none !important;
        }
    </style>
</head>

<body>
    <tiles:insertAttribute name="header" ignore="true" />
    <div id="container">
        <div id="side-menu">
            <tiles:insertAttribute name="menu" />
        </div>
        <div id="content">
            <img style="display: block" id="loading-img" src="${pageContext.servletContext.contextPath}/resources/gif/loading.gif">
            <tiles:insertAttribute name="body" />
        </div>
    </div>

    <!-- Froala Editor -->
    <!-- Include external CSS. -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet"
        type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/codemirror.min.css">
    <!-- Include Editor style. -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.8.5/css/froala_editor.pkgd.min.css" rel="stylesheet"
        type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.8.5/css/froala_style.min.css" rel="stylesheet"
        type="text/css" />
    <!-- Include Editor JS files. -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.8.5/js/froala_editor.pkgd.min.js"></script>

    <!-- Wiris -->
    <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/wiris/wiris.js"></script>
    <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/wiris/WIRISplugins.js"></script>
    <tiles:insertAttribute name="js" />
</body>

<script>
    $(document).ready(function () {
        var headerHeight = $('#header').outerHeight();
        $('#side-menu').css('margin-top', headerHeight + 'px');
        $('#content').css({
            'margin': (headerHeight + 35) + 'px 30px 30px 350px',
            'left': 0
        });
        $('#content').css('width', ($('#container').outerWidth() - $('#side-menu').outerWidth() - 60) + 'px');
    });
</script>

</html>