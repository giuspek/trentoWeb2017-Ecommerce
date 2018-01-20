<%-- 
    Document   : risultati2
    Created on : 5-ott-2017, 11.32.00
    Author     : Giuseppe
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Prodotto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<link href="css/star-rating.css" media="all" rel="stylesheet" type="text/css" />
<script src="js/star-rating.js" type="text/javascript"></script>
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>

<script type="text/javascript">
    $(document).ready(function () {
        $("#priceorder").click(function () {
            $("#order").val("price ASC");
            document.getElementById("ordertext").textContent = "Per prezzo";

        });
        $("#revieworder").click(function () {
            $("#order").val("global_value DESC");
            document.getElementById("ordertext").textContent = "Per rating";
        });
        $("#nameorder").click(function () {
            $("#order").val("name");
            document.getElementById("ordertext").textContent = "Per nome";
        });
        $("#sender").click(function () {
            $("#oggetto").val(findGetParameter("oggetto"));
            $("#filtro").val(findGetParameter("filter"));
        });

        function findGetParameter(parameterName) {
            var result = null,
                    tmp = [];
            var items = location.search.substr(1).split("&");
            for (var index = 0; index < items.length; index++) {
                tmp = items[index].split("=");
                if (tmp[0] === parameterName)
                    result = decodeURIComponent(tmp[1]);
            }
            return result;
        }
    });
</script>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Risultati</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <sql:query dataSource = "${snapshot}" var = "result">
            SELECT * from PRODUCTS WHERE LOWER(${param.filter}) LIKE LOWER('%${param.oggetto}%') ORDER BY ${param.orderparam}
        </sql:query>
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <form action="ApplyFilter" method="POST">
                        <div class="jumbotron">
                            <div class="row">
                                <h1> Filtri per la ricerca: </h1>
                            </div>
                            <div class="row">
                                <div class="dropdown">
                                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                        <span id="ordertext">Ordina per</span> <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">
                                        <li><a href="#" id="priceorder" >Per prezzo</a></li>
                                        <li><a href="#" id="revieworder">Per rating</a></li> 
                                        <li><a href="#" id="nameorder">Per nome</a></li>
                                    </ul>
                                </div>
                            </div>
                            <input type="hidden" id="order" name="order" value="name">
                            <input type="hidden" id="oggetto" name="oggetto" value="${param.oggetto}">
                            <input type="hidden" id="filtro" name="filtro" value="price">
                            <div class="row">
                                <input class="btn btn-success" id="sender" type="submit" value="Conferma">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md-9">

                    <c:forEach items="${result.rows}" var="row">
                        <div class="jumbotron">
                            <div class="row">
                                <div class="col-md-3">
                                    <img src="<c:out value="${row.path}" /> " width="150" height="100" class="img-rounded" alt="Nessuna foto del prodotto disponibile">
                                </div>
                                <div class="col-md-9">
                                    <div class="row">
                                        <b> <c:out value="${row.name}" /> </b>
                                    </div>
                                    <div class="row">
                                        <p> € <c:out value="${row.price}" /> </p>
                                    </div>
                                    <div class="row">
                                        <input id="ratingOverall" type="number" class="rating" value="${row.global_value}" data-size="xs" data-readonly="true" min="0" max="5" data-step="0.1">
                                    </div>
                                    <div class="row">
                                        <a href="prodotto.jsp?prodotto=${row.id}">Vedi Prodotto</a>
                                    </div>
                                </div>  
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </body>
</html>
