<%-- 
    Document   : cart
    Created on : 29-nov-2017, 23.25.33
    Author     : Giuseppe
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="beans.Elemento"%>
<%@page import="beans.Carrello"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<jsp:useBean id="cart" class="beans.Carrello" scope="session" />
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrello</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <h1>Carrello </h1>
            <c:forEach items="${cart.list}" var="row">
                <div class="media">
                    <c:choose>
                        <c:when test="${empty row.path}">
                            <div class="media-left">
                                <img src="img/noimg.jpg" class="media-object" height="200" width="200"> <!--style="width:60px"-->
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="media-left">
                                <img src="<c:out value="${row.path}" />" class="media-object" height="200" width="200"> <!--style="width:60px"-->
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="media-body">
                        <h4 class="media-heading"><c:out value="${row.name}" /></h4>
                        <p>€ <c:out value="${row.price}" /></p>
                        <p>N. <c:out value="${row.quantity}" /></p>
                        <button type="submit" onclick="window.location.href = 'prodotto.jsp?prodotto=${row.idProduct}'" class="btn btn-success pull-left"><span class="glyphicon glyphicon-send"></span> Vedi prodotto</button>
                        <!-- Trigger the modal with a button -->
                        <form action="EliminateFromCart" method="POST">
                            <button type="submit" class="btn btn-danger pull-left"><span class="glyphicon glyphicon-send"></span> Rimuovi Prodotto</button>
                            <input type="hidden" name="itemID" value="${row.id}">
                        </form>
                    </div>
                </div>
            </c:forEach>
            <hr>
            <c:if test="${(empty user.username)}">
                <div class="container">
                    <div class="jumbotron">
                        <p> Non puoi ancora acquistare: prima <a href="register.jsp"> Registrati </a> o <a href="loginPage.jsp" > Accedi</a>
                    </div>
                </div>
            </c:if>
            <c:if test="${!(empty user.username) && (cart.number > 0)}">
                <div class="container">
                    <div class="jumbotron">
                        <form action="shippingPage.jsp" method="POST">
                            <input type="submit" class="btn btn-success" value="Vai alla pagina di pagamento" />
                        </form>
                    </div>
                </div>
            </c:if>
            <c:if test="${!(empty user.username) && (cart.number == 0)}">
                <div class="container">
                    <div class="jumbotron">
                        <h2> Il tuo carrello è vuoto! </h2>
                    </div>
                </div>
            </c:if>
        </div>
    </body>
</html>
