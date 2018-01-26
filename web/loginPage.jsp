<%-- 
    Document   : index
    Created on : 14-set-2017, 16.38.10
    Author     : Giuseppe
--%>

<%@page import="beans.Utente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
        <div class="container">
            <c:if test="${param.e == '3'}" >
                <div class="alert alert-danger">
                    <strong>Login non effettuato</strong> Username/password non trovati
                </div>
            </c:if>
            <c:if test="${param.e == '4'}" >
                <div class="alert alert-danger">
                    <strong>Login non effettuato</strong> Conferma il tuo account tramite link nella mail!
                </div>
            </c:if>
            <c:if test="${param.e == 'c'}" >
                <div class="alert alert-success">
                    <strong>Account confermato!</strong> Usa il form per accedere al tuo nuovo account.
                </div>
            </c:if>
            <div class="panel panel-default">

                <div class="panel-heading">Login</div>
                <div class="panel-body">
                    <div class="form-horizontal">
                        <form action="Login" method="POST">
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="usrname"><span class="glyphicon glyphicon-user"></span> Username:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="usrname" name="usrname" placeholder="Enter username">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="password"><span class="glyphicon glyphicon-lock"></span> Password:</label>

                                <div class="col-sm-10">
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter password">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">

                                    <button type="submit" class="btn btn-success pull-left"><span class="glyphicon glyphicon-send"></span> Submit</button>
                                    <button class="btn btn-danger pull-left" type="reset" onclick="window.location.href = '<%=request.getHeader("Referer")%>'">Annulla </button>

                                </div>
                            </div>
                        </form>
                        <form action="forgetPassword.jsp" method="GET">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" class="btn btn-warning pull-right"><span class="glyphicon glyphicon-send"></span> Hai dimenticato la password?</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
