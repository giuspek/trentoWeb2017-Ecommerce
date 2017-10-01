<%-- 
    Document   : risultati
    Created on : 27-set-2017, 15.23.13
    Author     : Giuseppe
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Prodotto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp"/>
        <sql:query dataSource = "${snapshot}" var = "result">
            SELECT * from PRODUCTS WHERE LOWER(${param.filter}) LIKE LOWER('%${param.oggetto}%')
        </sql:query>
        <div class="container">
            <h1> Risultati: </h1>
        </div>
        <c:forEach items="${result.rows}" var="row">
            <div class="container">
                <div class="jumbotron">
                   <div class="row">
                    <div class="col-md-3">
                        <img src="img/Ansia.png" width="150" height="100">
                    </div>
                    <div class="col-md-9">
                        <div class="row">
                            <b> <c:out value="${row.name}" /> </b>
                        </div>
                        <div class="row">
                            <c:out value="${row.description}" />
                        </div>
                        <div class="row">
                            <a href="#">Vedi Prodotto</a>
                        </div>
                    </div>  
                   </div>
                </div>
            </div>
        </c:forEach>
    </body>
</html>
