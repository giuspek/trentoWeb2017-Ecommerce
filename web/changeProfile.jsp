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
            <div class="panel panel-primary">
                <div class="panel-heading">Cambia dati</div>
                <div class="panel-body">
                    <div class="form-horizontal">
                        <form action="ChangeProfile" method="POST">
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="name"><span class="glyphicon glyphicon-user"></span> Nome:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter first name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="surname"><span class="glyphicon glyphicon-lock"></span> Cognome:</label>

                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="surname" name="surname" placeholder="Enter last name">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" class="btn btn-success pull-left"><span class="glyphicon glyphicon-send"></span> Submit</button>
                                    <button class="btn btn-danger pull-left" type="reset" onclick="window.location.href = '<%=request.getHeader("Referer")%>'">Annulla </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
