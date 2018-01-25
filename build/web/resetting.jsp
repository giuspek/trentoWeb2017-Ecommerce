<%-- 
    Document   : resetting
    Created on : 2-dic-2017, 13.34.39
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="user" scope="session" class="beans.Utente"/>

<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resetting password</title>
        <sql:query dataSource="${snapshot}" var="theuser" scope="page"
                   sql="select * from USERS where USERNAME = ?" >
            <sql:param value="${param.u}" />

        </sql:query>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <c:choose>

            <c:when test="${theuser.rows[0].username != param.u || theuser.rows[0].hash != param.h}">
                <jsp:forward page="errorPage.jsp" />
            </c:when>
            <c:otherwise>

                <div class="container">
                    <div class="jumbotron">
                        <form action="ChangePassword" method="POST">
                            <div class="form-group">
                                <div class="container">
                                    <div class="jumbotron"> 
                                        <h1> Cambia password </h1>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <label for="previousPassword">
                                                    Vecchia password
                                                </label>
                                                <input class="form-control" type="text" id="previousPassword" name="previousPassword" required="required">
                                            </div>
                                            <div class="col-md-4">
                                                <label for="newPassword1">
                                                    Cognome
                                                </label>
                                                <input class="form-control" type="password" id="newPassword1" name="newPassword1" required="required">
                                            </div>
                                            <div class="col-md-4">
                                                <label for="newPassword2">
                                                    Username
                                                </label>
                                                <input class="form-control" type="password" id="newPassword2" name="newPassword2" required="required">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <input type="submit" class="btn btn-success" value="Cambia password">
                                            <input type="hidden" name="username" value="${param.u}">
                                            <input type="hidden" name="hash" value="${param.h}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
        -----------
        <div class="container">
            <div class="panel panel-primary">
                <div class="panel-heading">Login</div>
                <div class="panel-body">
                    <div class="form-horizontal">
                        <form action="ChangePassword" method="POST">
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="previousPassword"><span class="glyphicon glyphicon-user"></span> Vecchia password:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="previousPassword" name="previousPassword" placeholder="Enter old password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="newPassword1"><span class="glyphicon glyphicon-lock"></span> Nuova Password:</label>
                                <div class="col-sm-10">
                                    <input type="password" class="form-control" pattern="[A-Za-z0-9]{8,}" id="newPassword1" name="newPassword1" placeholder="Enter new password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="newPassword2"><span class="glyphicon glyphicon-lock"></span> Conferma Nupva Password:</label>

                                <div class="col-sm-10">
                                    <input type="password" class="form-control" pattern="[A-Za-z0-9]{8,}" id="newPassword2" name="newPassword2" placeholder="Confirm new password">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <input type="submit" class="btn btn-success" value="Cambia password">
                                    <input type="hidden" name="username" value="${param.u}">
                                    <input type="hidden" name="hash" value="${param.h}">
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
