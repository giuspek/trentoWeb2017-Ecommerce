<%-- 
    Document   : writeReview
    Created on : 3-dic-2017, 14.31.42
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<link href="css/star-rating.css" media="all" rel="stylesheet" type="text/css" />
<script src="js/star-rating.js" type="text/javascript"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page errorPage = "errorPage.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Scrivi recensione</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <c:choose>
            <c:when test="${empty param.sell}" >
                <c:redirect url="errorPage.jsp" />
            </c:when>
            <c:otherwise>
                <div class="container">
                    <h1>Recensione per: <c:out value="${param.nameProduct}" /></h1>
                    <form action="CreateReview" method="POST" id="mainForm">
                        <div class="form-group">

                            <div class="jumbotron">
                                <div class="row">
                                    <p> Qualità del prodotto <input name="ratingQuality" type="number" class="rating" min="0" max="5" step="1"> </p>
                                </div>
                                <div class="row">
                                    <p> Qualità del servizio <input name="ratingService" type="number" class="rating" min="0" max="5" step="1"> </p>
                                </div>
                                <div class="row">
                                    <p> Rapporto qualità/prezzo <input name="ratingPrice" type="number" class="rating" min="0" max="5" step="1"> </p>
                                </div>
                                <div class="row">
                                    <p> Valore globale <input name="overall" id="overall" type="number" class="rating" min="0" max="5" step="1"> </p>
                                </div>
                                <hr>
                                <div class="row">
                                    <p> Titolo recensione* </p>
                                    <input type="text" name="title" maxlength="25">
                                </div>
                                <div class="row">
                                    <p> Descrizione </p>
                                    <textarea name="description" form="mainForm" rows="8" cols="150"></textarea>
                                    
                                </div>
                                <div class="row">
                                    <input type="submit" class="btn btn-warning" value="Invia recensione">
                                    <input type="hidden" name="sell" value="${param.sell}">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>
