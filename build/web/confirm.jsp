<%-- 
    Document   : confirm
    Created on : 5-nov-2017, 13.21.03
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Conferma registrazione</title>
        <sql:query dataSource="${snapshot}" var="theuser" scope="page"
                   sql="select * from USERS where USERNAME = ?" >
            <sql:param value="${param.u}" />
        </sql:query>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <div class="jumbotron">
                <c:choose>
                        
                    <c:when test = "${theuser.rows[0].username != param.u}">
                        <h1> Utente non trovato </h1>
                    </c:when>

                    <c:when test = "${theuser.rows[0].active}">
                        <h1> Utente già attivo </h1>
                    </c:when>
                    
                    <c:when test = "${theuser.rows[0].hash != param.h}">
                        <h1> Errore </h1>
                    </c:when>

                    <c:otherwise>
                        <h1> Utente attivato adesso! </h1>
                        <sql:update dataSource="${snapshot}" sql="UPDATE USERS SET ACTIVE = true WHERE username=?">
                            <sql:param value="${param.u}" />
                        </sql:update>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </body>
</html>
