<%@ page session="false" contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="a" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
    crossorigin="anonymous">

<style>
    /* Header */
    #header {
        background: #0084ff;
        width: 100%;
        white-space: nowrap;
        display: grid;
        grid-template-columns: 30% 16%;
        grid-column-gap: 54%;
        z-index: 999;
        position: fixed;
    }

    body {
        background: #e9e9e9;
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
        font-weight: 700;
        letter-spacing: 1px;
        text-shadow: 4px 4px 2px rgb(26, 30, 32);
    }

    #header a {
        color: white;
        font-weight: bold;
        text-transform: uppercase;
    }
</style>

<sec:authentication property="principal.username" var="username" />
<div id="header">
    <div id="left-column">
        <h2 id="app-name">
            <a style="text-decoration: none" href="${pageContext.servletContext.contextPath}/">MATH FORMULAS</a>
        </h2>
    </div>
    <div id="right-column">
        <div class="right-item">
            <a style="text-decoration: none" href="#">${username}</a>
        </div>
        <div class="right-item">
            <a style="text-decoration: none" href="${pageContext.servletContext.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> logout</a>
        </div>
    </div>
</div>