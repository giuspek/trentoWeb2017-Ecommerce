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
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<%@ page errorPage = "errorPage.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Scrivi recensione</title>
        <sql:query dataSource="${snapshot}" var="result" scope="page"
                   sql="select S.ID_BUYER AS value from SELLS S where S.ID = ?" >
            <sql:param value="${param.sell}"/>
        </sql:query>
    </head>
    <body>

        <jsp:include page="navbar.jsp" />
        <c:choose>
            <c:when test="${empty param.sell || empty param.nameProduct || user.id != result.rows[0].value}" >
                <c:redirect url="errorPage.jsp" />
            </c:when>
            <c:otherwise>
                <div class="container">
                    <div class="col">
                        <div class="panel panel-default">
                            <div class="panel-heading text-center" style="font-size: 35px">Recensione per: <c:out value="${param.nameProduct}" />
                            </div>
                            <div class="panel-body">
                                <form action="CreateReview" method="POST" id="mainForm">
                                    <div class="form-group">
                                        <div class="col" style="padding-top: 15px;">
                                            <label> Qualità del prodotto <input name="ratingQuality" type="number" class="rating" min="0" max="5" step="1" required="required"> </label>
                                        </div>
                                        <div class="col" style="padding-top: 15px;">
                                            <label> Qualità del servizio <input name="ratingService" type="number" class="rating" min="0" max="5" step="1" required="required"> </label>
                                        </div>
                                        <div class="col" style="padding-top: 15px;">
                                            <label> Rapporto qualità/prezzo <input name="ratingPrice" type="number" class="rating" min="0" max="5" step="1" required="required"> </label>
                                        </div>
                                        <div class="col" style="padding-top: 15px;">
                                            <label> Valore globale <input name="overall" id="overall" type="number" class="rating" min="0" max="5" step="1" required="required"> </label>
                                        </div>
                                        <hr>
                                        <div class="col" style="padding-top: 15px;">
                                            <label> Titolo recensione </label>
                                            <input type="text" name="title" maxlength="25" required="required">
                                        </div>
                                        <div class="col" style="padding-top: 15px;">
                                            <textarea name="description" form="mainForm" rows="8" cols="150" required="required" class="form-control" placeholder="Descrizione Prodotto (obbligatoria)"></textarea>
                                        </div>
                                        <div class="col" style="padding-top: 15px;">
                                            <button type="submit" class="btn btn-success" value="Invia recensione"><span class="glyphicon glyphicon-send"></span> Invia recensione</button>	
                                            <input type="hidden" name="sell" value="${param.sell}">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>
