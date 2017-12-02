<%-- 
    Document   : ordini
    Created on : 2-dic-2017, 19.33.43
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<jsp:useBean id="user" scope="session" class="beans.Utente"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>I miei ordini</title>
        <sql:query dataSource="${snapshot}" var="theproducts" scope="page"
                   sql="select P.name, P.price,S.id, S.date, S.reviewed from PRODUCTS P, SELLS S where P.ID = S.ID_PRODUCT AND P.ID IN (SELECT ID_PRODUCT FROM SELLS WHERE ID_BUYER = ?)" >
            <sql:param value="${user.id}"/>
        </sql:query>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
        <h1>I miei ordini <c:out value="${user.id}" /></h1>
        <c:forEach items="${theproducts.rows}" var="row">
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
                            <p> Acquistato il: <c:out value="${row.date}" />  -- ID : <c:out value="${row.id}" /> <p>
                        </div>
                        <div class="row">
                            <c:if test="${!(row.reviewed)}" >
                                <form action="makeReview.jsp" method="POST">
                                    <input type="submit" value="Valuta il prodotto" class="btn btn-primary">
                                    <input type="hidden" name="sell" value="${row.id}">
                                    <input type="hidden" name="nameProduct" value="${row.name}">
                                </form>
                            </c:if>
                        </div>
                    </div>  
                </div>
            </div>
        
        </c:forEach>
       </div>
    </body>
</html>
