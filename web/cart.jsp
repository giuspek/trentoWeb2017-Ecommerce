<%-- 
    Document   : cart
    Created on : 29-nov-2017, 23.25.33
    Author     : Giuseppe
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="beans.Elemento"%>
<%@page import="beans.Carrello"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<jsp:useBean id="cart" class="beans.Carrello" scope="session" />
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <h1>Carrello: <jsp:getProperty name="cart" property="number" /> </h1>
            <c:forEach items="${cart.list}" var="row">
                <div class="jumbotron">
                    <div class="row">
                        <div class="col-md-3">
                            <img src="img/Ansia.png" width="150" height="100" class="img-rounded">
                        </div>
                        <div class="col-md-9">
                            <div class="row">
                                <b> <c:out value="${row.name}" /> </b>
                            </div>
                            <div class="row">
                                <p> € <c:out value="${row.price}" /> </p>
                            </div>
                            <div class="row">
                                <p> N. <c:out value="${row.quantity}" />  -- ID : <c:out value="${row.id}" /> <p>
                            </div>
                            <div class="row">
                                <form action="EliminateFromCart" method="POST">
                                    <input type="submit"class="btn btn-danger" value="Elimina dal carrello"/>
                                    <input type="hidden" name="itemID" value="${row.id}">
                                </form>
                            </div>
                        </div>  
                    </div>
                </div>
         
        </c:forEach>
            <hr>
            <c:if test="${(empty user.id)}">
            <div class="container">
                <div class="jumbotron">
                    <p> Non puoi ancora acquistare: prima <a href="register.jsp"> registrati </a> o <a href="loginPage.jsp" > accedi. </a>
                </div>
            </div>
        </c:if>
            <c:if test="${!(empty user.id) && (cart.number > 0)}">
            <div class="container">
                <div class="jumbotron">
                    <form action="shippingPage.jsp">
                        <input type="submit" class="btn btn-success" value="Vai alla pagina di pagamento" />
                    </form>
                </div>
            </div>
        </c:if>
        <c:if test="${!(empty user.id) && (cart.number == 0)}">
            <div class="container">
                <div class="jumbotron">
                    <h1> Il tuo carrello è vuoto! </h1>
                </div>
            </div>
        </c:if>
        </div>
    </body>
</html>
