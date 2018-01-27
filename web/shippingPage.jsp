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
<script>
    function active() {
        document.getElementById("theButton").disabled = false;
    }
</script>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagamento</title>
    </head>
    <body>
        <%
            if (request.getMethod().equals("GET")) {
                response.sendRedirect("errorPage1.jsp");
            }
        %>
        <c:if test="${user.typeOfAccount != 'S' && user.typeOfAccount != 'R' && user.typeOfAccount != 'A' }">
            <jsp:forward page="errorPage.jsp" />
        </c:if>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center" style="font-size: 35px">Pagamento </div>
                        <div class="panel-body text-center">

                            <form action="AddToSells" method="POST">
                                <div class="col" style="padding-top: 15px;">
                                    <label for="cardID"><span class="glyphicon glyphicon-credit-card"></span> Numero Carta: </label>
                                    <input type="text" name="cardID" required="true">
                                </div>
                                <div class="col" style="padding-top: 15px;">
                                    <label for="pin"><span class="glyphicon glyphicon-lock"></span> Pin: </label>
                                    <input type="text" name="pin" required="true">
                                </div>
                                <div class="col" style="padding-top: 15px;">
                                    <label for="month"><span class="glyphicon glyphicon-calendar"></span> Data di Scadenza: </label>
                                    <select name="month" required="true">
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
                                    <select name="year" required="true">
                                        <option value="2018">2018</option>
                                        <option value="2019">2019</option>
                                        <option value="2020">2020</option>
                                        <option value="2021">2021</option>
                                        <option value="2022">2022</option>
                                        <option value="2023">2023</option>
                                    </select>
                                </div>
                                <div class="col" style="padding-top: 15px;">
                                    <label for="indirizzo"><span class="glyphicon glyphicon-home"></span> Indirizzo: </label>
                                    <input type="text" name="indirizzo" required="true">
                                </div>
                                <div class="col" style="padding-top: 15px;">
                                    <label for="citta"><span class="glyphicon glyphicon-home"></span> Città: </label>
                                    <input type="text" name="citta" required="true">
                                </div>
                                <div class="col" style="padding-top: 15px;">
                                    <label for="CAP"><span class="glyphicon glyphicon-home"></span> CAP: </label>
                                    <input type="text" name="CAP" required="true">
                                </div>
                                <div class="col" style="padding-top: 15px;">
                                    <button type="submit" class="btn btn-success" value="Completa acquisto"><span class="glyphicon glyphicon-send"></span> Conferma Acquisto</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center" style="font-size: 35px">Ritiro in Negozio</div>
                        <div class="panel-body text-center">

                            <form action="AddToSells" method="POST">
                                <c:forEach items="${cart.list}" var="row">
                                    <c:if test="${!empty row.shopName && row.shopName != 'null'}">
                                        <div class="row">
                                            <input type="radio" name="location" onclick="active()" value="${row.shopName}"> <c:out value="${row.shopName}" />, <c:out value="${row.shopAddress}" />
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <div class="row">
                                    <p style="font-size: 20px"> Pagherai direttamente al negozio! </p>
                                    <input type="submit" id="theButton" class="btn btn-success" value="Completa acquisto" disabled="disabled">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
