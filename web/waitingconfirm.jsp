<%-- 
    Document   : waitingconfirm
    Created on : 5-nov-2017, 13.39.50
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mail inviata!</title>
    </head>
    <body>
    <c:if test="${user.typeOfAccount == 'S' || user.typeOfAccount == 'R' || user.typeOfAccount == 'A'}">
        <c:redirect url="errorPage.jsp" />
    </c:if>
    <jsp:include page="navbar.jsp" />
    <div class='container'>
        <div class="media">
            <div class="media-left">
                <img src="img/mail.png" class="media-object" height="200" width="200"> <!--style="width:60px"-->
            </div>
            <div class="media-body">
                <h2 class="media-heading">Mail inviata!</h2>
                <p>Se non la vedi nella posta, controlla nella cartella Spam.</p>
                <a href="homepage.jsp">
                    Ritorna all'homepage
                </a>
            </div>
        </div>
    </div>
</body>
</html>
