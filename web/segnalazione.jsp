<%-- 
    Document   : segnalazione
    Created on : 4-dic-2017, 11.38.20
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Segnala Anomalia</title>
        <sql:query dataSource="${snapshot}" var="result" scope="page"
                   sql="select S.ID_BUYER AS value from SELLS S where S.ID = ?" >
            <sql:param value="${param.sell}"/>
        </sql:query>
    </head>
    <body>
        <c:if test="${empty param.nameProduct || empty param.sell || user.id != result.rows[0].value}">
            <c:redirect url="errorPage.jsp" />
        </c:if>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <div class="col">
                <div class="panel panel-default">
                    <div class="panel-heading text-center" style="font-size: 35px">Segnala Anomalia per: <c:out value="${param.nameProduct}"/> 
                    </div>
                    <div class="panel-body">
                        <form action="CreateAnomaly" method="POST" id="anomalyForm">
                            <div class="form-group">
                                <div class="col" style="padding-top: 15px;">
                                    <label> Tipologia problema: </label>
                                    <select name="type">
                                        <option value="anomalia1">Prodotto non arrivato</option>
                                        <option value="anomalia2">Difetti nel prodotto</option>
                                        <option value="anomalia3">Prodotto diverso da quello descritto</option>
                                        <option value="anomalia4">Altro</option>
                                    </select>
                                </div>
                                <div class="col" style="padding-top: 15px;">
                                    <textarea class="form-control" name="description" form="anomalyForm" rows="10" cols="4	0" placeholder="Descrizione del Problema (obbligatoria)" ></textarea>
                                </div>
                                <div class="col" style="padding-top: 15px;">
                                    <button type="submit" class="btn btn-success" value="Invia segnalazione"><span class="glyphicon glyphicon-send"></span> Invia segnalazione </button>
                                    <input type="hidden" name="sell" value="${param.sell}">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
