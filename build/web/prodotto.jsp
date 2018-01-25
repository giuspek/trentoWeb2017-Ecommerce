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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
            SELECT R.*, U.username FROM REVIEWS R, USERS U WHERE R.ID_CREATOR = U.ID AND ID_PRODUCT = ${param.prodotto} ORDER BY DATE_CREATION, R.ID DESC
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

            <div class="row">

                <div class="col-lg-3">
                    <h1 class="my-4">Risultati</h1>

                </div>

                <div class="col-lg-9">

                    <div class="card mt-4">
                        <c:choose>
                            <c:when test="${empty result.rows[0].path}">
                                <img class="card-img-top img-fluid pull-left" src="img/noimg.jpg" width="280" height="280" alt="Image not available">
                            </c:when>
                            <c:otherwise>
                                <img class="card-img-top img-fluid pull-left" src="${result.rows[0].path}" width="280" height="280" alt="Image not available">               
                            </c:otherwise>
                        </c:choose>
                        <div class="card-body" style="padding-left: 300px">

                            <h1 class="card-title"><c:out value="${result.rows[0].name}" />  <span class="badge badge-info"><c:out value="${result.rows[0].first_genre}" /></span></h1>
                            <h2>€ <c:out value="${result.rows[0].price}" /></h2>
                            <h5>Venduto da:<c:out value="${result.rows[0].shopName}" /> </h5>

                            <span class="glyphicon glyphicon-home"></span>

                            <a href="mappa.jsp?map=<c:out value='${result.rows[0].id_shop}' />" 
                               style="text-decoration: none;    
                               color: #000000;" >	
                                Vai al Negozio
                            </a>

                            <br>

                            <br>

                            <input id="ratingOverall" type="number" class="rating" value="${rating.rows[0].media}" data-size="xs" data-readonly="true" min="0" max="5" data-step="0.1">
                            <form action="addCart" method="POST">
                                <input type="submit" class="btn btn-success" value="Compra">
                                <input type="number" name="quantita" min="1" step="1" default='1'/>
                                <input type="hidden" name="nomeProdotto" value="${result.rows[0].name}" />
                                <input type="hidden" name="prezzoProdotto" value="${result.rows[0].price}" />
                                <input type="hidden" name="deposit" value="${result.rows[0].deposit}" />
                                <input type="hidden" name="shopName" value="${result.rows[0].shopName}" />
                                <input type="hidden" name="shopAddress" value="${result.rows[0].address}" />
                                <input type="hidden" name="idProduct" value="${result.rows[0].id}" />
                                <input type="hidden" name="path" value="${result.rows[0].path}" />
                            </form>

                            <c:if test="${user.id == result.rows[0].shopSeller}">
                                <form action="UploadPhoto?idPhoto=${param.prodotto}" method="POST" ENCTYPE="multipart/form-data">
                                    <p> <u>Aggiorna immagine: </u></p>
                                    <input class="btn btn-primary" name="myFile" type="file" accept=".jpg" required="required">
                                    <input class="btn btn-success" type="submit" value="Aggiorna foto">
                                </form> 
                            </c:if>
                        </div>
                    </div>
                    <!-- /.card -->

                    <br><br>


                    <div class="card card-outline-secondary my-4">
                        <div class="card-header"><h3>Recensioni</h3></div>
                        <c:forEach items="${reviews.rows}" var="row">
                            <div class="card-body">
                                <p><b><c:out value="${row.name}"/></b> <c:out value="${row.description}" /></p>
                                <br>
                                <p> Qualità del prodotto </p> <input id="ratingQuality" type="number" class="rating" value="${row.quality}" data-size="xs" data-readonly="true">
                                <br>
                                <p> Servizio </p> <input id="ratingService" type="number" class="rating" value="${row.service}" data-size="xs" data-readonly="true">
                                <br>
                                <p> Rapporto qualità/prezzo </p> <input id="ratingMoney" type="number" class="rating" value="${row.value_for_money}" data-size="xs" data-readonly="true">
                                <small class="text-muted">Posted by <c:out value="${row.username}" /> on <c:out value="${row.date_creation}" /></small>
                                <hr>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
