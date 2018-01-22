<%-- 
    Document   : business
    Created on : 20-gen-2018, 22.25.35
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Prodotto"%>
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<sql:query dataSource = "${snapshot}" var = "result">
    SELECT S.*, C.ADDRESS FROM SHOPS S, USERS U, SHOP_COORDINATE S1, COORDINATES C WHERE S.ID_OWNER = U.ID AND S1.ID_SHOP = S.ID AND C.ID = S1.ID_COORDINATE AND U.ID = ${user.id}
</sql:query>
<sql:query dataSource = "${snapshot}" var = "products">
    SELECT P.* FROM PRODUCTS P, SHOPS S, USERS U WHERE P.ID_SHOP = S.ID AND S.ID_OWNER = U.ID AND U.ID = ${user.id}
</sql:query>
<!DOCTYPE html>
<c:if test="${user.typeOfAccount != 'S'}">
    <jsp:forward page="errorPage.jsp" />
</c:if>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Il mio business</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <h1>Oggetto acquistato!</h1>
            <div class="row">
                <div class="col-md-6">
                    <div class="jumbotron">
                        <h1> Il tuo negozio </h1>
                        <div class="row">
                            <h1> <c:out value="${result.rows[0].name}" /> </h1>
                            <p> <input id="ratingOverall" type="number" class="rating" value="${result.rows[0].global_value}" data-size="xs" data-readonly="true" min="0" max="5" data-step="0.1">
                                <a href="<c:out value="mappa.jsp?map=${result.rows[0].id}" />">Vedi il negozio</a>
                            <p> Indirizzo: <c:out value="${result.rows[0].address}" /> </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="jumbotron">
                        <h1> I tuoi prodotti </h1>
                        <c:forEach items="${products.rows}" var="row">
                                <div class="row">
                                        <div class="row">
                                            <b> <c:out value="${row.name}" />, <c:out value="${row.platform}" /> </b>
                                        </div>
                                        <div class="row">
                                            <p> € <c:out value="${row.price}" /> <a href="prodotto.jsp?prodotto=${row.id}">Vedi Prodotto</a></p>
                                        </div>
                                        <br>
                                    </div>  
                                
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
