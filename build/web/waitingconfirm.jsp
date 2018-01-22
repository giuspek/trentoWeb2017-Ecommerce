<%-- 
    Document   : waitingconfirm
    Created on : 5-nov-2017, 13.39.50
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mail inviata!</title>
    </head>
    <body>
        <c:if test="${user.typeOfAccount == 'S' || user.typeOfAccount == 'R' || user.typeOfAccount == 'A'}">
            <c:redirect url="errorPage.jsp" />
        </c:if>
         <jsp:include page="navbar.jsp" />
        <div class="container">
            <div class="jumbotron">
                <h1> Mail inviata! </h1>
            </div>
        </div>
    </body>
</html>
