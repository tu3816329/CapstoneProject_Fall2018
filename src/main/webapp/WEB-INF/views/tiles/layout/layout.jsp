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
    <style>
        html {
            font-family: sans-serif;
        }

        body {
            margin: 0;
        }

        a {
            text-decoration: none;
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

        /* Header */
        #header {
            background: #0084ff;
            width: 100%;
            display: grid;
            grid-template-columns: 20% 16%;
            grid-column-gap: 64%;
        }

        .sticky {
            position: fixed;
            top: 0;
            width: 100%;
        }

        #left-column {
            padding: 15px 30px;
        }

        #right-column {
            display: grid;
            grid-template-columns: 50% 50%;
        }

        .right-item {
            padding: 15px 10px;
            text-align: center;
            font-size: 14px;
            display: flex;
        }

        .right-item:first-child {
            background: #2170ba;
        }

        .right-item>a {
            margin: auto;
        }

        #app-name {
            margin: 0;
        }

        #app-name>a {
            font-size: 23px;
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 1px;
            text-shadow: 4px 4px 2px rgb(26, 30, 32);
        }

        #header a {
            color: white;
            font-weight: bold;
        }

        /* Container */
        #container {
            display: grid;
            grid-template-columns: 25% 75%;
        }

        /* Side menu */
        #data-explorer {
            font-size: 18px;
            padding-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }

        #side-menu {
            padding: 15px 30px;
        }

        #side-menu a {
            color: #0084ff;
        }

        .side-menu-item {
            margin-bottom: 20px;
        }

        .side-menu-item>a {
            font-size: 18px;
        }

        /* Tree menu */
        #tree-menu {
            padding: 0 15px 15px 15px;
            margin: 0;
            display: none;
            margin-bottom: 10px;
            border-bottom: 1px solid #ddd;
            white-space: nowrap;
            overflow-x: scroll;
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

        /* Content */
        #content {
            padding: 15px 20px;
        }

        .content-header {
            display: grid;
            grid-template-columns: 75% 25%;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }

        .content-title {
            text-transform: uppercase;
        }

        .content-button {
            margin-top: 10px;
            border: none;
            background: #0084ff;
            border-radius: 0;
            color: white;
            cursor: pointer;
            font-size: 17px;
        }

        /* Search bar */
        #search-bar {
            margin: auto;
            border-radius: 5px;
            border: 1px solid darkgray;
            padding: 10px;
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

</html>