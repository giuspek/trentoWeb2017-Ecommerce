<%-- 
    Document   : shippingPage
    Created on : 28-dic-2017, 12.09.52
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="beans.Carrello"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <div class="jumbotron">


                <h2> Scegli il metodo di pagamento </h2>
                <div class="row">
                    <div class="col-md-6">
                        <form action="AddtoSells" method="POST">
                            <h3> Spedizione online </h3>
                            <div class="row">
                                <label for="cardID"> Numero carta </label>
                                <input type="text" name="cardID">
                            </div>
                            <div class="row">
                                <label for="pin"> Pin </label>
                                <input type="text" name="pin">
                            </div>
                            <div class="row">
                                <label for="month"> Data di scadenza </label>
                                <select name="month">
                                    <option value="1">01</option>
                                    <option value="2">02</option>
                                    <option value="3">03</option>
                                    <option value="4">04</option>
                                    <option value="5">05</option>
                                    <option value="6">06</option>
                                    <option value="7">07</option>
                                    <option value="8">08</option>
                                    <option value="9">09</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                                <select name="year">
                                    <option value="2018">2018</option>
                                    <option value="2019">2019</option>
                                    <option value="2020">2020</option>
                                    <option value="2021">2021</option>
                                    <option value="2022">2022</option>
                                    <option value="2023">2023</option>
                                </select>
                            </div>
                            <div class="row">
                                <label for="indirizzo"> Indirizzo </label>
                                <input type="text" name="indirizzo">
                            </div>
                            <div class="row">
                                <label for="citta"> Città </label>
                                <input type="text" name="citta">
                            </div>
                            <div class="row">
                                <label for="CAP"> CAP </label>
                                <input type="text" name="CAP">
                            </div>
                            <input type="submit" class="btn btn-warning" value="Completa acquisto">

                        </form>
                    </div>
                    <div class="col-md-6">   
                        <form action="AddToSells" method="POST">
                            <h3>Ritira in negozio </h3>
                            <c:forEach items="${cart.list}" var="row">
                                <c:if test="${!empty row.shopName}">
                                    <div class="row">
                                        <input type="radio" value="${row.shopName}"> <c:out value="${row.shopName}" />, <c:out value="${row.shopAddress}" />
                                    </div>
                                </c:if>

                            </c:forEach>
                            <div class="row">
                                <p> Pagherai direttamente al negozio! </p>
                                <input type="submit" class="btn btn-warning" value="Completa acquisto">
                            </div>


                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
