<%-- 
    Document   : changeProfile
    Created on : 3-dic-2017, 13.37.00
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page errorPage = "errorPage.jsp" %>

<!DOCTYPE html>
<c:if test="${user.typeOfAccount != 'S' && user.typeOfAccount != 'A'  && user.typeOfAccount != 'R' }">
    <jsp:forward page="errorPage.jsp" />
</c:if>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <div class="jumbotron">
                <c:choose>
                    <c:when test="${(empty user.username)  || (user.username != param.n) }">
                        <c:redirect url="errorPage.jsp" />
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <h1> Cambia i tuoi dati </h1>
                        </div>
                        <form action="ChangeProfile" method="POST">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <label for="nome">
                                            Nuovo nome
                                        </label>
                                        <input class="form-control" type="text" id="name" name="name" required="required">
                                    </div>
                                    <div class="col-md-4">
                                        <label for="cognome">
                                            Nuovo cognome
                                        </label>
                                        <input class="form-control" type="text" id="surname" name="surname" required="required">
                                    </div>
                                    <div class="col-md-4">
                                        <input type="submit" class="btn btn-success" value="Cambia dati">
                                        <input type="hidden" name="id" value="${user.id}">
                                    </div>
                                </div>

                            </div>  
                        </form>

                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html>
