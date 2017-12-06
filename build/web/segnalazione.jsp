<%-- 
    Document   : segnalazione
    Created on : 4-dic-2017, 11.38.20
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Segnala anomalia</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <h1>Segnala anomalia per: <c:out value="${param.nameProduct}" /></h1>
            <form action="CreateAnomaly" method="POST" id="anomalyForm">
                <div class="jumbotron">
                    <div class="row">
                        <p> Tipologia problema </p>
                        <select name="type">
                            <option value="anomalia1">Prodotto non arrivato</option>
                            <option value="anomalia2">Difetti nel prodotto</option>
                            <option value="anomalia3">Prodotto diverso da quello descritto</option>
                            <option value="anomalia4">Altro</option>
                        </select>
                    </div>
                    <div class="row">
                        <p> Descrizione del problema </p>
                        <textarea name="description" form="anomalyForm" rows="8" cols="150" ></textarea>
                    </div>
                    <div class="row">
                        <input type="submit" class="btn btn-warning" value="Invia segnalazione">
                        <input type="hidden" name="sell" value="${param.sell}">
                    </div>
                </div>
            </form>

        </div>

    </body>
</html>
