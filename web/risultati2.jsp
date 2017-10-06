<%-- 
    Document   : risultati2
    Created on : 5-ott-2017, 11.32.00
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
        <jsp:include page="navbar.jsp" />
        <sql:query dataSource = "${snapshot}" var = "result">
            SELECT * from PRODUCTS WHERE LOWER(${param.filter}) LIKE LOWER('%${param.oggetto}%')
        </sql:query>
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <form action="ApplyFilter" method="POST">
                        <div class="jumbotron">
                            <div class="row">
                                <h1> Filtri per la ricerca: </h1>
                            </div>
                            <div class="row">
                                <div class="dropdown">
                                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                        <span id="search_concept">Ordina:</span> <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">
                                        <li><a href="#" id="priceorder" >Per prezzo</a></li>
                                        <li><a href="#" id="revieworder">Per review</a></li>      
                                        <li><a href="#" id="nearorder">Per vicinanza</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="row">
                                <input class="btn btn-success" type="submit" value="Conferma">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md-9">
                    
                <c:forEach items="${result.rows}" var="row">
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
                                    <p> € <c:out value="${row.price}" /> </p>
                                </div>
                                <div class="row">
                                    <a href="#">Vedi Prodotto</a>
                                </div>
                            </div>  
                        </div>
                    </div>
                </c:forEach>
                </div>
            </div>
        </div>
    </body>
</html>
