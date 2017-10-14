<%-- 
    Document   : mappa
    Created on : 14-ott-2017, 22.19.05
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Prodotto"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<sql:query dataSource = "${snapshot}" var = "result">
            SELECT * FROM SHOPS WHERE ID = ${param.map}
</sql:query>
<sql:query dataSource = "${snapshot}" var = "coordinates">
            SELECT * FROM COORDINATES WHERE ID = (SELECT ID_COORDINATE FROM SHOP_COORDINATE WHERE ID_SHOP = ${param.map})
</sql:query>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <div class="jumbotron">
                <div class="row">
                    <div class="col-md-4">
                        <img src="img/Ansia.png" height="280" width="250" class="img-rounded">
                    </div>
                    <div class="col-md-8">
                        <div class="row">
                            <h1> <c:out value="${result.rows[0].name}" /> </h1>
                            <p> Rating: <c:out value="${result.rows[0].global_value}" /> </p>
                            <a href="<c:out value="${result.rows[0].web_site_URL}" />"> Visita il sito web del negozio</a>

                            <p> Latitudine: <c:out value="${coordinates.rows[0].latitude}" /> </p>
                            <p> Longitudine <c:out value="${coordinates.rows[0].longitude}" /> </p>
                            <p> Address <c:out value="${coordinates.rows[0].address}" /> </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
