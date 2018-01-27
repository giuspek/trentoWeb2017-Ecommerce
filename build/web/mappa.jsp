<%-- 
    Document   : mappa
    Created on : 14-ott-2017, 22.19.05
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
<link href="css/star-rating.css" media="all" rel="stylesheet" type="text/css" />
<script src="js/star-rating.js" type="text/javascript"></script>
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<sql:query dataSource = "${snapshot}" var = "result">
    SELECT * FROM SHOPS WHERE ID = ${param.map}
</sql:query>
<sql:query dataSource = "${snapshot}" var = "coordinates">
    SELECT * FROM COORDINATES WHERE ID = (SELECT ID_COORDINATE FROM SHOP_COORDINATE WHERE ID_SHOP = ${param.map})
</sql:query>
<sql:query dataSource = "${snapshot}" var = "reviews" maxRows="5">
    SELECT R.*, cast(R.date_creation as Date) as date,P.name as nameProduct,P.id as idProduct, U.username FROM REVIEWS R, USERS U, PRODUCTS P WHERE R.ID_CREATOR = U.ID AND ID_PRODUCT = P.ID AND P.ID_SHOP = ${param.map} ORDER BY R.DATE_CREATION DESC, R.ID 
</sql:query>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            #map {
                height: 400px;
                width: 100%;
            }
        </style>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">

            <div class="row">

                <div class="col-lg-3">
                    <h1> Negozio </h1>
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

                            <h1 class="card-title"><c:out value="${result.rows[0].name}" />  </h1>
                            <p> <c:out value="${result.rows[0].description}" /> </p>
                            <p> <input id="ratingOverall" type="number" class="rating" value="${result.rows[0].global_value}" data-size="xs" data-readonly="true" min="0" max="5" data-step="0.1">
                            <p> Indirizzo: <c:out value="${coordinates.rows[0].address}" /> </p>
                            <c:if test="${result.rows[0].deposit == 'T'}">
                                <p> Puoi anche ritirare in negozio la merce! </p>
                            </c:if>

                            <span class="glyphicon glyphicon-home"></span>

                            <a href="<c:out value="${result.rows[0].web_site_URL}" />" 
                               style="text-decoration: none;    
                               color: #000000;" >	
                                Vai al Sito Web
                            </a>

                            <br><br>

                            <c:if test="${user.id == result.rows[0].shopSeller}">
                                <form action="UploadPhotoShop?idPhoto=${param.map}" method="POST" ENCTYPE="multipart/form-data">
                                    <p> <u>Aggiorna immagine: </u></p>
                                    <input class="btn btn-primary" name="myFile" type="file" accept=".jpg" required="required">
                                    <input class="btn btn-success" type="submit" value="Aggiorna foto">
                                </form> 
                            </c:if>

                            <br><br><br><br><br><br><br><br>
                            
                        </div>
                                    <div id="map"></div>
                            <script>
                                function initMap() {
                                    var uluru = {lat: ${coordinates.rows[0].latitude}, lng: ${coordinates.rows[0].longitude}};
                                    var map = new google.maps.Map(document.getElementById('map'), {
                                        zoom: 4,
                                        center: uluru
                                    });
                                    var marker = new google.maps.Marker({
                                        position: uluru,
                                        map: map
                                    });
                                }
                            </script>
                            <script async defer
                                    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDYXsnbH8Seqck98_bvR9m7BPIIjuIlCBY&callback=initMap">
                            </script>
                    </div>
                    <br><br>


                    <div class="card card-outline-secondary my-4">
                        <div class="card-header"><h3>Recensioni</h3></div>
                        <c:forEach items="${reviews.rows}" var="row">
                            <div class="card-body">
                                <p><u><a href="prodotto.jsp?prodotto=<c:out value='${row.idProduct}' />" > <c:out value="${row.nameProduct}"/></a></u></p>
                                <p><b><c:out value="${row.name}"/></b> <c:out value="${row.description}" /></p>
                                <br>
                                <p> Qualità del prodotto </p> <input id="ratingQuality" type="number" class="rating" value="${row.quality}" data-size="xs" data-readonly="true">
                                <br>
                                <p> Servizio </p> <input id="ratingService" type="number" class="rating" value="${row.service}" data-size="xs" data-readonly="true">
                                <br>
                                <p> Rapporto qualità/prezzo </p> <input id="ratingMoney" type="number" class="rating" value="${row.value_for_money}" data-size="xs" data-readonly="true">
                                <small class="text-muted">Posted by <c:out value="${row.username}" /> on <c:out value="${row.date}" /></small>
                                <hr>
                            </div>
                        </c:forEach>
                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
