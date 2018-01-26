<%-- 
    Document   : ordini
    Created on : 2-dic-2017, 19.33.43
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<jsp:useBean id="user" scope="session" class="beans.Utente"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>I miei ordini</title>
        <sql:query dataSource="${snapshot}" var="theproducts" scope="page"
                   sql="select P.name, P.price, P.path, S.id, S.date, S.reviewed, S.id_product from PRODUCTS P, SELLS S where P.ID = S.ID_PRODUCT AND S.ID_BUYER = ? ORDER BY S.DATE DESC, S.ID" >
            <sql:param value="${user.id}"/>
        </sql:query>
    </head>
    <body>
        <c:if test="${user.typeOfAccount != 'S' && user.typeOfAccount != 'R' && user.typeOfAccount != 'A'}">
            <c:redirect url="errorPage.jsp" />
        </c:if>
        <jsp:include page="navbar.jsp" />
        <div class='container'>
            <h2> I tuoi ordini </h2>
            <c:forEach items="${theproducts.rows}" var="row">
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
                        <p> Acquistato il: <c:out value="${row.date}" /><p>
                            <button type="submit" onclick="window.location.href = 'prodotto.jsp?prodotto=${row.id_product}'" class="btn btn-success pull-left"><span class="glyphicon glyphicon-send"></span> Vedi prodotto</button>
                            <c:if test="${!(row.reviewed)}" >
                            <form action="writeReview.jsp" method="POST">
                                <input type="submit" value="Valuta il prodotto" class="btn btn-primary">
                                <input type="hidden" name="sell" value="${row.id}">
                                <input type="hidden" name="nameProduct" value="${row.name}">
                            </form>
                            </c:if>
                        <form action="segnalazione.jsp" method="POST">
                            <input type="submit" value="Segnala anomalia" class="btn btn-danger">
                            <input type="hidden" name="sell" value="${row.id}">
                            <input type="hidden" name="nameProduct" value="${row.name}">
                            <input type="hidden" name="idProduct" value="${row.id_product}">
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
