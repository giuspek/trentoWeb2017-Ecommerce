<%-- 
    Document   : business
    Created on : 20-gen-2018, 22.25.35
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Prodotto"%>
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<link rel="stylesheet" href="css/notice.css">
<script src="js/local.js" ></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<sql:query dataSource = "${snapshot}" var = "result">
    SELECT S.*, C.ADDRESS FROM SHOPS S, USERS U, SHOP_COORDINATE S1, COORDINATES C WHERE S.ID_OWNER = U.ID AND S1.ID_SHOP = S.ID AND C.ID = S1.ID_COORDINATE AND U.ID = ${user.id}
</sql:query>
<sql:query dataSource = "${snapshot}" var = "products">
    SELECT P.* FROM PRODUCTS P, SHOPS S, USERS U WHERE P.ID_SHOP = S.ID AND S.ID_OWNER = U.ID AND U.ID = ${user.id}
</sql:query>
<!DOCTYPE html>
<c:if test="${user.typeOfAccount != 'S'}">
    <jsp:forward page="errorPage.jsp" />
</c:if>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Il mio business</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <div class="col-lg-12 col-sm-12">
                <div class="card hovercard">
                    <div class="card-background">
                        <img class="card-bkimg" alt="" src="img/gatto.jpg">
                    </div>
                    <div class="useravatar">
                        <img alt="" src="img/gatto.jpg">
                    </div>
                    <div class="card-info"> <span class="card-title"><c:out value="${user.firstName}" /> <c:out value="${user.lastName}" /></span>

                    </div>
                </div>
                <div class="btn-pref btn-group btn-group-justified btn-group-lg" role="group" aria-label="...">
                    <div class="btn-group" role="group">
                        <button type="button" id="stars" class="btn btn-default" href="#tab1" data-toggle="tab"><span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                            <div class="hidden-xs">Informazioni</div>
                        </button>
                    </div>
                    <div class="btn-group" role="group">
                        <button type="button" id="favorites" class="btn btn-default" href="#tab2" data-toggle="tab"><span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
                            <div class="hidden-xs">Cambia dati</div>
                        </button>
                    </div>
                    <div class="btn-group" role="group">
                        <button type="button" id="shop" class="btn btn-default" href="#tab3" data-toggle="tab"><span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
                            <div class="hidden-xs">Il tuo negozio</div>
                        </button>
                    </div>
                    <div class="btn-group" role="group">
                        <button type="button" id="products" class="btn btn-default" href="#tab4" data-toggle="tab"><span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
                            <div class="hidden-xs">I tuoi prodotti</div>
                        </button>
                    </div>
                </div>

                <div class="well">
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="tab1">
                            <p><b><c:out value="${user.firstName}" /> <c:out value="${user.lastName}" /></b> </p><br>
                            <p> Nickname: <c:out value="${user.username}" /></p>
                            <p> Tipo di utente: 
                                <c:if test="${user.typeOfAccount == 'R'}">
                                    Registrato
                                </c:if>
                                <c:if test="${user.typeOfAccount == 'S'}">
                                    Venditore
                                </c:if>
                                <c:if test="${user.typeOfAccount == 'R'}">
                                    Admin
                                </c:if>
                            </p>
                        </div>
                        <div class="tab-pane fade in" id="tab2">
                            <div class="row">
                                <form action="changeUsername.jsp" method="POST">
                                    <input type="submit" value="Cambia username" class="btn btn-primary center-align">
                                    <input type="hidden" name="n" value="${user.username}">
                                </form>
                                <form action="changeProfile.jsp" method="GET">
                                    <input type="submit" value="Cambia nome/cognome" class="btn btn-primary">
                                    <input type="hidden" name="n" value="${user.username}">
                                </form> 
                            </div>
                        </div>
                        <div class="tab-pane fade in" id="tab3">
                            <div class="card mt-4">
                                <c:choose>
                                    <c:when test="${empty result.rows[0].path}">
                                        <img class="card-img-top img-fluid pull-left" src="img/noimg.jpg" width="200" height="200" alt="Image not available">
                                    </c:when>
                                    <c:otherwise>
                                        <img class="card-img-top img-fluid pull-left" src="${result.rows[0].path}" width="200" height="200" alt="Image not available">               
                                    </c:otherwise>
                                </c:choose>
                                <div class="container">
                                    <div class="card-body" style="padding-left: 300px">

                                        <h1 class="card-title"><c:out value="${result.rows[0].name}" />  </h1>
                                        <p> <input id="ratingOverall" type="number" class="rating" value="${result.rows[0].global_value}" data-size="xs" data-readonly="true" min="0" max="5" data-step="0.1">
                                        <p> Indirizzo: <c:out value="${coordinates.rows[0].address}" /> </p>
                                        <c:if test="${result.rows[0].deposit == 'T'}">
                                            <p> Puoi anche ritirare in negozio la merce! </p>
                                        </c:if>

                                        <span class="glyphicon glyphicon-home"></span>

                                        <a href="mappa.jsp?map=<c:out value="${result.rows[0].id}" />" 
                                           style="text-decoration: none;    
                                           color: #000000;" >	
                                            Vai al sito del negozio
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade in" id="tab4">
                            <div class="row">
                                <div class="container">
                                <c:forEach items="${products.rows}" var="row">
                                    
                                            <b> <c:out value="${row.name}" />, <c:out value="${row.platform}" /> </b>
                                        
                                        
                                            <p> € <c:out value="${row.price}" /> <a href="prodotto.jsp?prodotto=${row.id}">Vedi Prodotto</a></p>
                                       
                                        <br>
                                    
                                </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
