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
        display: grid;
        grid-template-columns: 20% 16%;
        grid-column-gap: 64%;
        z-index: 999;
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
        <h1 id="app-name">
            <a href="${pageContext.servletContext.contextPath}">MATH FORMULAS</a>
        </h1>
    </div>
    <div id="right-column">
        <div class="right-item">
            <a href="#">${username}</a>
        </div>
        <div class="right-item">
            <a href="#"><i class="fas fa-sign-out-alt"></i> logout</a>
        </div>
    </div>
</div>

<script>
    // Sticky header
    var header = document.getElementById('header');
    var sticky = header.offsetTop;

    window.onscroll = function () {
        if (window.pageYOffset > sticky) {
            header.classList.add('sticky');
        } else {
            header.classList.remove('sticky');
        }
    };
</script>