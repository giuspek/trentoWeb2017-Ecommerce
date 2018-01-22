<%-- 
    Document   : index
    Created on : 14-set-2017, 16.38.10
    Author     : Giuseppe
--%>

<%@page import="beans.Utente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
    <head>
        <title>Guappo</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    </head>
    <body>
        <% if (((Utente) session.getAttribute("user")).getFirstName() != null) {
                response.sendRedirect("errorPage.jsp");
            }
        %>
        <jsp:include page="navbar.jsp"/>
        <form action="Login" method="POST">
            <div class="form-group">
                <div class="container">
                    <c:if test="${param.e == '1'}" >
                        <div class="alert alert-danger">
                            <strong>Login non effettuato</strong> Username/password non trovati
                        </div>
                    </c:if>
                    <div class="jumbotron">
                        <div class="row">
                            <div class="col-md-6">
                                <label for="username">
                                    Username
                                </label>
                                <input class="form-control" type="text" id="usrname" name="usrname">
                            </div>
                            <div class="col-md-6">
                                <label for="password">
                                    Password
                                </label>
                                <input class="form-control" type="password" id="password" name="password">
                            </div>
                        </div>
                        <p> </P>
                        <div class="row">
                            <a href="forgetPassword.jsp" >Hai dimenticato la password?</a>
                        </div>
                        <p> </p>
                        <div class="row">
                            <input class="btn btn-success" type="submit" value="Conferma">
                            <input class="btn btn-danger" type="reset" value="Annulla">
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
