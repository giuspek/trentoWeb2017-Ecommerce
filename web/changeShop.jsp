<%-- 
    Document   : changeProfile
    Created on : 3-dic-2017, 13.37.00
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>

<%@ page errorPage = "errorPage.jsp" %>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <sql:query dataSource = "${snapshot}" var = "result">
            SELECT S.*, C.ADDRESS FROM SHOPS S, USERS U, SHOP_COORDINATE S1, COORDINATES C WHERE S.ID_OWNER = U.ID AND S1.ID_SHOP = S.ID AND C.ID = S1.ID_COORDINATE AND U.ID = ${user.id}
        </sql:query>
    </head>
    <body>
        <%
            if (request.getMethod().equals("GET")) {
                response.sendRedirect("errorPage.jsp");
            }
        %>
        <c:if test="${user.typeOfAccount != 'S' || param.n != user.username || param.s != result.rows[0].id  }">
            <jsp:forward page="errorPageddddd.jsp" />
        </c:if>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <div class="panel panel-primary">
                <div class="panel-heading">Cambia dati negozio <c:out value="${result.rows[0].name}" /></div>
                <div class="panel-body">
                    <div class="form-horizontal">
                        <form action="ChangeShop" method="POST">
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="name"><span class="glyphicon glyphicon-user"></span> Nuovo nome negozio</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter new shop name" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="description"><span class="glyphicon glyphicon-lock"></span> Nuova descrizione:</label>

                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="description" name="description" placeholder="Enter new description" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" class="btn btn-success pull-left"><span class="glyphicon glyphicon-send"></span> Submit</button>
                                    <input type="hidden" name="id" value="${result.rows[0].id}"
                                </div>
                            </div>
                            </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>