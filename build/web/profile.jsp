<%-- 
    Document   : profile
    Created on : 2-dic-2017, 22.53.58
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<c:if test="${user.typeOfAccount != 'S' && user.typeOfAccount != 'A'  && user.typeOfAccount != 'R' }">
    <jsp:forward page="errorPage.jsp" />
</c:if>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profilo</title>
    </head>
    <body>

        <jsp:include page="navbar.jsp"/>
        <div class="container">
            <h1>I miei dati personali</h1>
            <div class="jumbotron">
                <div class="row">
                    <p> Nome: <c:out value="${user.firstName}" /> </p> 
                </div>
                <div class="row">
                    <p> Cognome: <c:out value="${user.lastName}" /> </p> 
                </div>
                <div class="row">
                    <p> Username: <c:out value="${user.username}" /> </p> 
                </div>
                <div class="row">
                    <form action="changeUsername.jsp" method="POST">
                        <input type="submit" value="Cambia username" class="btn btn-primary">
                        <input type="hidden" name="n" value="${user.username}">
                    </form> 
                    <form action="changeProfile.jsp" method="GET">
                        <input type="submit" value="Cambia nome/cognome" class="btn btn-primary">
                        <input type="hidden" name="n" value="${user.username}">
                    </form> 
                </div>
            </div>
        </div> 
    </body>
</html>
