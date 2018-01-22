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
            <div class="jumbotron">
                <div class="row">
                    <div class="col-md-4">
                        <img src="${result.rows[0].path}" height="280" width="250" class="img-rounded" alt="Nessuna foto del prodotto disponibile">
                        <c:if test="${user.id == result.rows[0].id_owner}">
                            <form action="UploadPhotoShop?idPhoto=${param.map}" method="POST" ENCTYPE="multipart/form-data">
                                <p> <u>Aggiorna immagine: </u></p>
                                <input name="myFile" type="file" accept=".jpg" required="required">
                                <input type="submit" value="Aggiorna foto">
                            </form> 
                        </c:if>
                    </div>
                    <div class="col-md-8">
                        <div class="row">
                            <h1> <c:out value="${result.rows[0].name}" /> </h1>
                            <p> <input id="ratingOverall" type="number" class="rating" value="${result.rows[0].global_value}" data-size="xs" data-readonly="true" min="0" max="5" data-step="0.1">
                            <a href="<c:out value="${result.rows[0].web_site_URL}" />"> Visita il sito web del negozio</a>
                            <p> Indirizzo: <c:out value="${coordinates.rows[0].address}" /> </p>
                            <c:if test="${result.rows[0].deposit == 'T'}">
                                <p> Puoi anche ritirare in negozio la merce! </p>
                            </c:if>
                        </div>
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
            </div>
        </div>
    </body>
</html>
