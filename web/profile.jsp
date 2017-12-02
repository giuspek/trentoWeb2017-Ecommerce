<%-- 
    Document   : profile
    Created on : 2-dic-2017, 22.53.58
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profilo</title>
    </head>
    <body>
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
                    <form action="changeUsername.jsp" method="GET">
                        <input type="submit" value="Cambia username" class="btn btn-primary">
                    </form> 
                    <form action="changeName.jsp" method="GET">
                        <input type="submit" value="Cambia nome/cognome" class="btn btn-primary">
                    </form> 
                </div>
            </div>
        </div> 
    </body>
</html>
