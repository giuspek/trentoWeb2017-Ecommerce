<%-- 
    Document   : resetting
    Created on : 2-dic-2017, 13.34.39
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

            <c:when test="${theuser.rows[0].username != param.u || theuser.rows[0].hash != param.h }">
                <div class="container">
                    <div class="jumbotron">
                        <h1> Errore! </h1>
                    </div>
                </div>
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
    </body>
</html>
