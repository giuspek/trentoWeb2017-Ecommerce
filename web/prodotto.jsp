<%-- 
    Document   : prodotto.jsp
    Created on : 6-ott-2017, 14.30.34
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Prodotto"%>
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<jsp:useBean id="cart" class="beans.Carrello" scope="session" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<link href="css/star-rating.css" media="all" rel="stylesheet" type="text/css" />
<script src="js/star-rating.js" type="text/javascript"></script>
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <sql:query dataSource = "${snapshot}" var = "result">
            SELECT P.*, S.name as shopName, S.id_owner AS shopSeller, S.deposit, C.address from PRODUCTS P, SHOPS S, SHOP_COORDINATE X, COORDINATES C WHERE P.id = ${param.prodotto} AND P.ID_SHOP = S.ID AND S.ID = X.ID_SHOP AND X.ID_COORDINATE = C.ID
        </sql:query>
        <sql:query dataSource = "${snapshot}" var = "reviews">
            SELECT R.*, U.username FROM REVIEWS R, USERS U WHERE R.ID_CREATOR = U.ID AND ID_PRODUCT = ${param.prodotto} ORDER BY DATE_CREATION DESC
        </sql:query>
        <sql:query dataSource = "${snapshot}" var = "rating">
            SELECT AVG(CAST(GLOBAL_VALUE AS FLOAT)) AS media FROM REVIEWS WHERE ID_PRODUCT = ${param.prodotto} GROUP BY ID_PRODUCT
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
                        <img src="${result.rows[0].path}" height="280" width="250" class="img-rounded">
                        <c:if test="${user.id == result.rows[0].shopSeller}">
                            <form action="UploadPhoto" method="POST" ENCTYPE="multipart/form-data">
                                <p> <u>Aggiorna immagine: </u></p>
                                <input name="myFile" type="file" accept=".jpg">
                                <input type="submit" value="Aggiorna foto">
                            </form> 
                        </c:if>
                    </div>
                    <div class="col-md-8">
                        <div class="row">
                            <h1><c:out value="${result.rows[0].name}" /> <span class="badge badge-info"><c:out value="${result.rows[0].first_genre}" /></span></h1>
                            <div class="row">
                                <input id="ratingOverall" type="number" class="rating" value="${rating.rows[0].media}" data-size="xs" data-readonly="true" min="0" max="5" data-step="0.1">
                            </div>
                            <div class="row">
                                <p> Venditore: <c:out value="${result.rows[0].shopName}" /> 
                            </div>
                            
                            <div class="row">
                                <a href="mappa.jsp?map=<c:out value="${result.rows[0].id_shop}" />">Guarda la mappa</a>
                            </div>

                            <p> € <c:out value="${result.rows[0].price}" /> </p>
                            <p> </p>
                            <form action="addCart" method="POST">
                                <input class="btn btn-success" type="submit">
                                Aggiungi al carrello
                                </input>
                                <input type="hidden" name="nomeProdotto" value="${result.rows[0].name}" />
                                <input type="hidden" name="prezzoProdotto" value="${result.rows[0].price}" />
                                <input type="hidden" name="deposit" value="${result.rows[0].deposit}" />
                                <input type="hidden" name="shopName" value="${result.rows[0].shopName}" />
                                <input type="hidden" name="shopAddress" value="${result.rows[0].address}" />
                                <input type="hidden" name="idProduct" value="${result.rows[0].id}" />

                                <input type="number" name="quantita" min="1" step="1" />
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="jumbotron">
                <h2>Recensioni </h2>
                    <c:forEach items="${reviews.rows}" var="row">
                    <p> ------------------------------------------------------------------------------------------------ <p>
                        <div class="row">
                            <h3><b><c:out value="${row.name}"/></b></h3>
                            <p> <c:out value="${row.username}" /> --- <c:out value="${row.date_creation}" /> </p>
                        </div>
                        <div class="row">
                            <p> Qualità del prodotto </p> <input id="ratingQuality" type="number" class="rating" value="${row.quality}" data-size="xs" data-readonly="true">
                        </div>
                        <div class="row">
                            <p> Servizio </p> <input id="ratingService" type="number" class="rating" value="${row.service}" data-size="xs" data-readonly="true">                      
                        </div>
                        <div class="row">
                            <p> Rapporto qualità/prezzo </p> <input id="ratingMoney" type="number" class="rating" value="${row.value_for_money}" data-size="xs" data-readonly="true">                           
                        </div>
                        <div class="row">
                            <p> Descrizione: <c:out value="${row.description}" /> </p>
                        </div>
                    </c:forEach>
            </div>
        </div>
    </body>
</html>
