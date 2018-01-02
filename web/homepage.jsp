<%--
    Document   : homepage
    Created on : 30-mag-2017, 17.19.21
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!--  Scripts-->
<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="js/materialize.js"></script>
<script src="js/init.js"></script>

<!-- CSS  -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Guappo-Online</title>
  </head>
  <body>

  <jsp:include page="navbar.jsp"/>

  <div class="slider-adjustment">
    <div class ="slider fullscreen">
    	<ul class="slides">
    		<li>
          <img src="img/header-1.jpg">
          <div class="caption left-align white-text">
            <p class="flow-text black-text">
              <h1>GUAPPO</h1>
              <h3 class="light text-lighten-3">Shop Online</h3>
            </p>
          </div>
        </li>
    		<li>
          <img src="img/header-2.jpg">
          <div class="caption right-align white-text">
            <p class="flow-text black-text">
              <h1>GUAPPO</h1>
              <h3 class="light text-lighten-3">Shop Online</h3>
            </p>
          </div>
        </li>
        <li>
          <img src="img/header-3.jpg">
          <div class="caption center-align black-text">
            <p class="flow-text black-text">
              <h1>GUAPPO</h1>
              <h3 class="light text-lighten-3">Shop Online</h3>
            </p>
          </div>
        </li>
    	</ul>
    </div>
  </div>

  </body>
</html>
