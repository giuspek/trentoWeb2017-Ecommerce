<%-- 
    Document   : profile
    Created on : 2-dic-2017, 22.53.58
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/notice.css">
<script src="js/local.js" ></script>
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<c:if test="${user.typeOfAccount != 'S' && user.typeOfAccount != 'A'  && user.typeOfAccount != 'R' }">
    <jsp:forward page="errorPage.jsp" />
</c:if>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profilo</title>
    </head>
    <body>

        <jsp:include page="navbar.jsp"/>
        <div class="container">
            <div class="col-lg-12 col-sm-12">
                <div class="card hovercard">
                    <div class="card-background">
                        <img class="card-bkimg" alt="" src="img/mail.png">
                    </div>
                    <div class="useravatar">
                        <img alt="" src="img/mail.png">
                    </div>
                    <div class="card-info"> <span class="card-title"><c:out value="${user.firstName}" /> <c:out value="${user.lastName}" /></span>

                    </div>
                </div>
                <div class="btn-pref btn-group btn-group-justified btn-group-lg" role="group" aria-label="...">
                    <div class="btn-group" role="group">
                        <button type="button" id="stars" class="btn btn-primary" href="#tab1" data-toggle="tab"><span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                            <div class="hidden-xs">Informazioni</div>
                        </button>
                    </div>
                    <div class="btn-group" role="group">
                        <button type="button" id="favorites" class="btn btn-default" href="#tab2" data-toggle="tab"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
                            <div class="hidden-xs">Cambia dati</div>
                        </button>
                    </div>
                </div>

                <div class="well">
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="tab1">
                            <p><b><c:out value="${user.firstName}" /> <c:out value="${user.lastName}" /></b> </p><br>
                            <p> Nickname: <label><c:out value="${user.username}" /></label></p> <br>
                            <p> Tipo di utente: 
                                <c:if test="${user.typeOfAccount == 'R'}">
                                    <label>Registrato</label>
                                </c:if>
                                <c:if test="${user.typeOfAccount == 'S'}">
                                    <label>Venditore</label>
                                </c:if>
                                <c:if test="${user.typeOfAccount == 'A'}">
                                    <label>Admin</label>
                                </c:if>
                            </p>
                        </div>
                        <div class="tab-pane fade in" id="tab2">
                            <div class="row">
                                <form action="changeProfile.jsp" method="GET">
                                    <input type="submit" value="Cambia nome/cognome" class="btn btn-primary">
                                    <input type="hidden" name="n" value="${user.username}">
                                </form> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>


    </body>
</html>
