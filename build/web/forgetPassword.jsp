<%-- 
    Document   : forgetPassword
    Created on : 24-set-2017, 16.31.50
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Guappo - Recupera password</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="row">
            <div class="container">
                <div class="col-md-6">
                    <form action="resetPassword" method="POST">
                        <div class="form-group">

                            <div class="jumbotron">
                                <h1> Hai dimenticato la password? </h1>
                                <p> Non preoccuparti! Inserisci la tua mail e ti spediremo un link per riaggiornare la tua password: </p>
                                <div class="row">
                                    <div class="col-md-2"> </div>
                                    <div class="col-md-8">
                                        <span class="usericon">
                                            <input type="text" name="mail" class="form-control" placeholder="E-mail...">
                                        </span>
                                    </div>
                                </div>
                                <div class="row"> </div>
                                <div class="row">
                                    <div class="col-md-4"> </div>
                                    <div class="col-md-3">
                                        <input type="submit" class="btn btn-warning form-control" value="Continua">
                                    </div>
                                </div>

                            </div>
                        </div>
                    </form>

            </div>
                <div class="col-md-6">
                    <img src="img/Ansia.png" height="500" width="500">
                </div>
            </div>
        </div>
    </body>
</html>
