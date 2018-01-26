<%-- 
    Document   : notificheAdmin
    Created on : 5-dic-2017, 9.46.43
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href='css/notice.css'>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<jsp:useBean id="user" scope="session" class="beans.Utente"/>
<!DOCTYPE html>
<script>
    var checkboxes = $("input[type='checkbox']");
    
    function app(){
        console.log("aa");
        $('#bottone').attr('disabled', $('.cbox:checked').length === 0);  
    }
    
    $(document).ready(function () {
        checkboxes.click(function() {
    $("#bottone").attr("disabled", );
    });
    
});
</script>
<c:if test="${user.typeOfAccount != 'A' }">
    <jsp:forward page="errorPage.jsp" />
</c:if>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Le mie notifiche</title>
        <sql:query dataSource="${snapshot}" var="theproducts" scope="page"
                   sql="SELECT A.*, P.name, U.first_name, U.last_name, S1.name AS nomeNegozio FROM ANOMALIES A, SELLS S, PRODUCTS P, SHOPS S1, USERS U WHERE A.MANAGED = false AND A.ID_SELL = S.ID AND S.ID_PRODUCT = P.ID AND S1.ID = P.ID_SHOP AND U.ID = S.ID_BUYER" >
        </sql:query>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <h1>Le mie notifiche</h1> 
            <c:forEach items="${theproducts.rows}" var="row">
                <div class="notice notice-warning">
                    <b> Ticket n. <c:out value="${row.id}" /> per la vendita n. <c:out value="${row.id_sell}" />: <c:out value="${row.name}" /> </b>
                    <b>, venduto da <a href="mappa.jsp?map=<c:out value="${row.idNegozio}" /> " > <c:out value="${row.nomeNegozio}" /></a> </b>
                    <b>, comprato da <c:out value="${row.first_name}" /> <c:out value="${row.last_name}" /> </b>
                    <br><br>
                    <p><u> Tipologia:</u>
                            <c:choose>
                                <c:when test="${row.type == 'anomalia1'}" >
                                Prodotto non arrivato
                            </c:when>
                            <c:when test="${row.type == 'anomalia2'}" >
                                Difetti nel prodotto
                            </c:when>
                            <c:when test="${row.type == 'anomalia3'}" >
                                Prodotto diverso da quello descritto
                            </c:when>
                            <c:when test="${row.type == 'anomalia4'}" >
                                Altro
                            </c:when>
                        </c:choose>
                        <c:out value="${row.price}" /> </p>
                    <p> <u>Descrizione:</u> <c:out value="${row.description}" />   <p>
                    <div class="row">
                        <div class="col-md-6">
                            <form action="ManageAnomaly" method="POST">
                                <h4><b> Rigetta anomalia </b></h4>
                                <textarea name="description" rows="8" cols="70"></textarea>
                                <input type="submit" class="btn btn-warning" value="Rigetta anomalia">
                                <input type="hidden" name="choice" value="rejected">
                                <input type="hidden" name="anomaly" value="${row.id}">
                            </form>
                        </div>
                        <div class="col-md-6">
                            <h4><b> Gestisci anomalia</b> </h4>
                            <form action="ManageAnomaly" method="POST">
                                <input class="cbox" type="checkbox" id="rimborso" name="rimborso" onclick="app()"> Gestire pratica di rimborso<br>
                                <input class="cbox" type="checkbox" id="resend"name="resend" onclick="app()"> Rispedire il prodotto<br>
                                <input class="cbox" type="checkbox" id="reputazione" name="reputation" onclick="app()"> Abbassa reputazione negozio<br>
                                <input type="submit" id="bottone" class="btn btn-warning" value="Gestisci anomalia" disabled>
                                <input type="hidden" name="choice" value="approved">
                                <input type="hidden" name="anomaly" value="${row.id}">
                            </form>
                        </div>
                    </div>  
                </div>
            </c:forEach>
        </div>
    </body>
</html>
