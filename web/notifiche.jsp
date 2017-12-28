<%-- 
    Document   : notifiche
    Created on : 4-dic-2017, 22.46.45
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<jsp:useBean id="user" scope="session" class="beans.Utente"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Le mie notifiche</title>
        <sql:query dataSource="${snapshot}" var="theproducts" scope="page"
                   sql="SELECT A.*, P.name FROM ANOMALIES A, SELLS S, PRODUCTS P WHERE ID_SELLER = ? AND A.ID_SELL = S.ID AND S.ID_PRODUCT = P.ID" >
            <sql:param value="${user.id}"/>
        </sql:query>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <h1>Le mie notifiche</h1> 
            <c:forEach items="${theproducts.rows}" var="row">
                <div class="jumbotron">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <b> Ticket n. <c:out value="${row.id}" /> </b>
                            </div>
                            <div class="row">
                                <p> Tipologia:
                                    <c:choose>
                                        <c:when test="${row.type == 'anomalia1'}" >
                                            Prodotto non arrivato
                                        </c:when>
                                        <c:when test="${row.type == 'anomalia2'}" >
                                            Difetti nel prodotto
                                        </c:when>
                                        <c:when test="${row.type == 'anomalia3'}" >
                                            Prodotto diverso da quello descritto
                                        </c:when>
                                        <c:when test="${row.type == 'anomalia4'}" >
                                            Altro
                                        </c:when>
                                    </c:choose>
                                    <c:out value="${row.price}" /> </p>
                            </div>
                            <div class="row">
                                <p>  <c:out value="${row.description}" />   <p>
                            </div>
                            <div class="row">
                                <c:choose>
                                    <c:when test="${!(row.managed)}" >
                                        <b> Non risolto </b>
                                    </c:when>
                                    <c:otherwise>
                                        <b> Risolto </b>
                                        <c:if test="${row.solution == 0}">
                                            <p> Anomalia rigettata: <c:out value="${row.rejection}" />
                                        </c:if>
                                        <c:if test="${row.solution == 1}">
                                        <p> Richiesta di rimborso accolta </p>
                                        </c:if>  
                                        <c:if test="${row.solution == 2}">
                                            <p> Richiesta rispedizione prodotto </p>
                                        </c:if>
                                        <c:if test="${row.solution == 4}">
                                            <p> Valutazione negozio diminuita </p>
                                        </c:if>
                                        <c:if test="${row.solution == 3}">
                                            <ul>
                                                <li>
                                                    Richiesta di rimborso accolta
                                                </li>
                                                <li>
                                                    Richiesta rispedizione prodotto
                                                </li>
                                            </ul>
                                        </c:if>
                                        <c:if test="${row.solution == 5}">
                                            <ul>
                                                <li>
                                                    Richiesta di rimborso accolta
                                                </li>
                                                <li>
                                                    Valutazione negozio diminuita
                                                </li>
                                            </ul>
                                        </c:if>
                                        <c:if test="${row.solution == 6}">
                                            <ul>
                                                <li>
                                                    Richiesta rispedizione prodotto
                                                </li>
                                                <li>
                                                    Valutazione negozio diminuita
                                                </li>
                                            </ul>
                                        </c:if>
                                        <c:if test="${row.solution == 7}">
                                            <ul>
                                                <li>
                                                    Richiesta di rimborso accolta
                                                </li>
                                                <li>
                                                    Richiesta rispedizione prodotto
                                                </li>
                                                <li>
                                                    Valutazione negozio diminuita
                                                </li>
                                            </ul>
                                        </c:if>
                                        </c:otherwise>
                                </c:choose>
                            </div>
                        </div>  
                    </div>
                </div>

            </c:forEach>
        </div>

    </body>
</html>
