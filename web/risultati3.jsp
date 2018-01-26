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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="css/star-rating.css" media="all" rel="stylesheet" type="text/css" />
<script src="js/star-rating.js" type="text/javascript"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>

<script type="text/javascript">
    function prova() {
        if (document.getElementById('theButton').checked) {
            $("#extraFilter").show();
        } else {
            $("#extraFilter").hide();
        }
    }
    ;

    $(document).ready(function () {
        $("#extraFilter").hide();

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

        $('#theButton').click(function () {
            $("#extraFilter").toggle(this.checked);
            $("#region").val("");
            $("#rangePrice").val("");
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
        <c:choose>
            <c:when test="${!(empty param.da) && !(empty param.a)&& !(empty param.region)}">
                <sql:query dataSource = "${snapshot}" var = "result">
                    SELECT P.* from PRODUCTS P, SHOP_COORDINATE S, COORDINATES C  WHERE LOWER(${param.filter}) LIKE LOWER('%${param.oggetto}%') AND P.ID_SHOP = S.ID_SHOP AND S.ID_COORDINATE = C.ID AND LOWER(C.REGIONE) = LOWER('${param.region}') AND P.PRICE < ${param.a} AND P.PRICE >= ${param.da} ORDER BY ${param.orderparam}
                </sql:query>
            </c:when>
            <c:when test="${!(empty param.da) && !(empty param.a) && empty param.region}">
                <sql:query dataSource = "${snapshot}" var = "result">
                    SELECT P.* from PRODUCTS P  WHERE LOWER(${param.filter}) LIKE LOWER('%${param.oggetto}%') AND P.PRICE < ${param.a} AND P.PRICE >= ${param.da} ORDER BY ${param.orderparam}
                </sql:query>
            </c:when>
            <c:when test="${!(empty param.region)}">
                <sql:query dataSource = "${snapshot}" var = "result">
                    SELECT P.* from PRODUCTS P, SHOP_COORDINATE S, COORDINATES C  WHERE LOWER(${param.filter}) LIKE LOWER('%${param.oggetto}%') AND P.ID_SHOP = S.ID_SHOP AND S.ID_COORDINATE = C.ID AND LOWER(C.REGIONE) = LOWER('${param.region}') ORDER BY ${param.orderparam}
                </sql:query>
            </c:when>
            <c:otherwise>
                <sql:query dataSource = "${snapshot}" var = "result">
                    SELECT * from PRODUCTS WHERE LOWER(${param.filter}) LIKE LOWER('%${param.oggetto}%') ORDER BY ${param.orderparam}
                </sql:query>
            </c:otherwise>
        </c:choose>
        <div class="container">
            <div class="col-lg-3" style="padding-top: 20px;">
                <div class="panel panel-default">
                    <div class="panel-heading" style="font-size: 35px">Filtri</div>
                    <div class="panel-body">
                        <form class="form" action="ApplyFilter" method="POST">
                            <div class="form-group">
                                <div class="col">
                                    <div class="dropdown">
                                        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                            <span id="ordertext">Ordina per:</span> <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">
                                            <li><a href="#" id="priceorder" >Per prezzo</a></li>
                                            <li><a href="#" id="revieworder">Per rating</a></li> 
                                            <li><a href="#" id="nameorder">Per nome</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <select class="form-control" id="region" name="region">
                                    <option default value="" >Regione:</option>
                                    <option value="abruzzo" >Abruzzo</option>
                                    <option value="basilicata">Basilicata</option>
                                    <option value="calabria" >Calabria</option>
                                    <option value="campania" >Campania</option>
                                    <option value="emilia romagna" >Emilia Romagna</option>
                                    <option value="friuli venezia giulia" >Friuli Venezia Giulia</option>
                                    <option value="lazio" >Lazio</option>
                                    <option value="liguria" >Liguria</option>
                                    <option value="lombardia">Lombardia</option>
                                    <option value="marche" >Marche</option>
                                    <option value="molise" >Molise</option>
                                    <option value="piemonte" >Piemonte</option>
                                    <option value="puglia" >Puglia</option>
                                    <option value="sardegna" >Sardegna</option>
                                    <option value="sicilia" >Sicilia</option>
                                    <option value="toscana" >Toscana</option>
                                    <option value="trentino alto adige" >Trentino alto adige</option>
                                    <option value="umbria" >Umbria</option>
                                    <option value="valle daosta" >Valle d'aosta</option>
                                    <option value="veneto" >Veneto</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <select class="form-control" id="rangePrice" name="rangePrice">
                                    <option default value="" >Fascia di prezzo</option>
                                    <option value="low" >Da €0 a €29.99</option>
                                    <option value="mid">Da €30 a €69.99</option>
                                    <option value="high" >Da €70 in su</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <div class="col">
                                    <input type="hidden" id="order" name="order" value="price">
                                    <input type="hidden" id="oggetto" name="oggetto" value="${param.oggetto}">
                                    <input type="hidden" id="filtro" name="filtro" value="name">
                                    <button class="btn btn-outline-success " id="sender" type="submit" value="Conferma"><span class="glyphicon glyphicon-search"></span> Search</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


            <div class="col-lg-9">
                <c:forEach items="${result.rows}" var="row">
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
                            <div class="row">
                                <input id="ratingOverall" type="number" class="rating" value="${row.global_value}" data-size="xs" data-readonly="true" min="0" max="5" data-step="0.1">
                            </div>
                            <button type="submit" onclick="window.location.href = 'prodotto.jsp?prodotto=${row.id}'" class="btn btn-success pull-left"><span class="glyphicon glyphicon-send"></span> Vedi prodotto</button>
                            <!-- Trigger the modal with a button -->
                            <button data-toggle="collapse" class="btn btn-primary" data-target="#demo${row.id}">Leggi descrizione</button>
                            <div id="demo${row.id}" class="collapse">
                                <p><c:out value="${row.description}" /></p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

    </body>
</html>
