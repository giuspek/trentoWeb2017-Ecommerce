<%-- 
    Document   : addedObject
    Created on : 1-dic-2017, 15.09.00
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <h1>Oggetto acquistato!</h1>

            <div class="row">
                <div class="col-md-6">
                    <div class="jumbotron">
                        <h1> Ti serve altro? </h1>
                        <p> Usa la barra di ricerca in altro per comprare altri prodotti! </p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="jumbotron">
                        <h1> Hai finito gli acquisti? </h1>
                        <form action="cart.jsp" method="GET">
                            <input class="btn btn-primary" type="submit" value="Vai al carrello">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
