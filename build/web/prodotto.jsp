<%-- 
    Document   : prodotto.jsp
    Created on : 6-ott-2017, 14.30.34
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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <sql:query dataSource = "${snapshot}" var = "result">
            SELECT * from PRODUCTS WHERE id = ${param.prodotto}
        </sql:query>
        <title>
            <c:out value="${result.rows[0].name}" />
        </title>
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
                            <p> Rating: 3/5 </p>
                            <p> Numero di recensioni: 0 </p>

                            <a href="mappa.jsp?map=<c:out value="${result.rows[0].id_shop}" />">Guarda la mappa</a>


                            <p> € <c:out value="${result.rows[0].price}" /> </p>
                            <p> </p>
                            <button class="btn btn-success">
                                Aggiungi al carrello
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
