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
<link rel="stylesheet" type="text/css" href='css/notice.css'>
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<jsp:useBean id="user" scope="session" class="beans.Utente"/>
<!DOCTYPE html>
<c:if test="${user.typeOfAccount != 'S' && user.typeOfAccount != 'R' }">
    <jsp:forward page="errorPage.jsp" />
</c:if>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Le mie notifiche</title>
        <c:choose>
            <c:when test="${user.typeOfAccount == 'S'}">
                <sql:query dataSource="${snapshot}" var="theproducts" scope="page"
                           sql="SELECT A.*, P.name, U.first_name, U.last_name FROM ANOMALIES A, SELLS S, PRODUCTS P, USERS U WHERE ID_SELLER = ? AND A.ID_SELL = S.ID AND S.ID_PRODUCT = P.ID AND S.ID_BUYER = U.ID" >
                    <sql:param value="${user.id}"/>
                </sql:query>
            </c:when>
            <c:otherwise>
                <sql:query dataSource="${snapshot}" var="theproducts" scope="page"
                           sql="SELECT A.*, P.name, S1.name AS nomeNegozio, S1.id AS idNegozio FROM ANOMALIES A, SELLS S, PRODUCTS P, SHOPS S1 WHERE A.ID_BUYER = ? AND A.ID_SELL = S.ID AND S.ID_PRODUCT = P.ID AND P.ID_SHOP = S1.ID" >
                    <sql:param value="${user.id}"/>
                </sql:query>
            </c:otherwise>
        </c:choose>



    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <c:forEach items="${theproducts.rows}" var="row">
                <c:choose>
                    <c:when test="${!(row.managed)}">
                        <div class="notice notice-warning">
                            <b> Ticket n. <c:out value="${row.id}" /> </b>: <a href="prodotto.jsp?prodotto=<c:out value="${row.id}" /> " > <c:out value="${row.name}" /> </a> </b>
                            <c:choose>
                                <c:when test="${user.typeOfAccount == 'R'}" >
                                    , venduto da <a href="mappa.jsp?map=<c:out value="${row.idNegozio}" /> " > <c:out value="${row.nomeNegozio}" /></a>
                                </c:when>
                                <c:when test="${user.typeOfAccount == 'S'}" >
                                    , comprato da <c:out value="${row.first_name}" /> <c:out value="${row.last_name}" />
                                </c:when>
                            </c:choose>
                            <p> <b> <u>Tipologia</u> </b>:
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
                                <c:out value="${row.price}" /> 
                            <p>  <c:out value="${row.description}" />   <p>
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
                    </c:when>
                    <c:when test="${row.solution == 0 && user.typeOfAccount == 'S'}">
                        <div class="notice notice-success">
                            <b> Ticket n. <c:out value="${row.id}" /> </b>: <a href="prodotto.jsp?prodotto=<c:out value="${row.id}" /> " > <c:out value="${row.name}" /> </a> </b>
                            <c:choose>
                                <c:when test="${user.typeOfAccount == 'R'}" >
                                    , venduto da <a href="mappa.jsp?map=<c:out value="${row.idNegozio}" /> " > <c:out value="${row.nomeNegozio}" /></a>
                                </c:when>
                                <c:when test="${user.typeOfAccount == 'S'}" >
                                    , comprato da <c:out value="${row.first_name}" /> <c:out value="${row.last_name}" />
                                </c:when>
                            </c:choose>
                            <p> <b> <u>Tipologia</u> </b>:
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
                                <c:out value="${row.price}" /> 
                            <p>  <c:out value="${row.description}" />   <p>
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
                    </c:when>
                    <c:when test="${row.solution == 0 && user.typeOfAccount == 'R'}">
                        <div class="notice notice-danger">
                            <b> Ticket n. <c:out value="${row.id}" /> </b>: <a href="prodotto.jsp?prodotto=<c:out value="${row.id}" /> " > <c:out value="${row.name}" /> </a> </b>
                            <c:choose>
                                <c:when test="${user.typeOfAccount == 'R'}" >
                                    , venduto da <a href="mappa.jsp?map=<c:out value="${row.idNegozio}" /> " > <c:out value="${row.nomeNegozio}" /></a>
                                </c:when>
                                <c:when test="${user.typeOfAccount == 'S'}" >
                                    , comprato da <c:out value="${row.first_name}" /> <c:out value="${row.last_name}" />
                                </c:when>
                            </c:choose>
                            <p> <b> <u>Tipologia</u> </b>:
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
                                <c:out value="${row.price}" /> 
                            <p>  <c:out value="${row.description}" />   <p>
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
                    </c:when>
                    <c:when test="${row.solution != 0 && user.typeOfAccount == 'S'}">
                        <div class="notice notice-danger">
                            <b> Ticket n. <c:out value="${row.id}" /> </b>: <a href="prodotto.jsp?prodotto=<c:out value="${row.id}" /> " > <c:out value="${row.name}" /> </a> </b>
                            <c:choose>
                                <c:when test="${user.typeOfAccount == 'R'}" >
                                    , venduto da <a href="mappa.jsp?map=<c:out value="${row.idNegozio}" /> " > <c:out value="${row.nomeNegozio}" /></a>
                                </c:when>
                                <c:when test="${user.typeOfAccount == 'S'}" >
                                    , comprato da <c:out value="${row.first_name}" /> <c:out value="${row.last_name}" />
                                </c:when>
                            </c:choose>
                            <p> <b> <u>Tipologia</u> </b>:
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
                                <c:out value="${row.price}" /> 
                            <p>  <c:out value="${row.description}" />   <p>
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
                    </c:when>
                    <c:otherwise>
                        <div class="notice notice-success">
                            <b> Ticket n. <c:out value="${row.id}" /> </b>: <a href="prodotto.jsp?prodotto=<c:out value="${row.id}" /> " > <c:out value="${row.name}" /> </a> </b>
                            <c:choose>
                                <c:when test="${user.typeOfAccount == 'R'}" >
                                    , venduto da <a href="mappa.jsp?map=<c:out value="${row.idNegozio}" /> " > <c:out value="${row.nomeNegozio}" /></a>
                                </c:when>
                                <c:when test="${user.typeOfAccount == 'S'}" >
                                    , comprato da <c:out value="${row.first_name}" /> <c:out value="${row.last_name}" />
                                </c:when>
                            </c:choose>
                            <p> <b> <u>Tipologia</u> </b>:
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
                                <c:out value="${row.price}" /> 
                            <p>  <c:out value="${row.description}" />   <p>
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
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>

    </body>
</html>
