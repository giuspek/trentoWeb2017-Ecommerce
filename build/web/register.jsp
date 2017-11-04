<%-- 
    Document   : register
    Created on : 29-lug-2017, 19.03.05
    Author     : Giuseppe
--%>

<%@page import="beans.Utente"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<!DOCTYPE html>
<script type="text/javascript">
    $(document).ready(function(){
    $("#privacy").click(function(){
        document.getElementById("confirm").disabled=false;
        

    });
});
</script>
<html>
    <head>
        <title>Guappo</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    </head>
    <body style="background-color:#a0522d">
        <% if( ( (Utente) session.getAttribute("user")).getFirstName() != null)
            response.sendRedirect("homepage.jsp");
        %>
        <jsp:include page="navbar.jsp"/>
        <form action="Registration">
            <div class="form-group">
                <div class="container">
                    <div class="jumbotron">
                        <div class="row">
                            <div class="col-md-6">
                                <label for="nome">
                                    Nome
                                </label>
                                <input class="form-control" type="text" id="nome" name="nome" required="required">
                            </div>
                            <div class="col-md-6">
                                <label for="cognome">
                                    Cognome
                                </label>
                                <input class="form-control" type="text" id="cognome" name="cognome" required="required">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label for="mail1">
                                    Indirizzo mail
                                </label>
                                <input class="form-control" type="text" id="mail1" name="mail1" required="required">
                            </div>
                            <div class="col-md-6">
                                <label for="mail2">
                                    Conferma mail
                                </label>
                                <input class="form-control" type="text" id="mail2" name="mail2" required="required">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label for="pass1">
                                    Password
                                </label>
                                <input class="form-control" type="password" id="pass1" name="pass1" required="required">
                            </div>
                            <div class="col-md-6">
                                <label for="pass2">
                                    Conferma password
                                </label>
                                <input class="form-control" type="password" id="pass2" name="pass2" required="required">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <p> <input type="checkbox" id="privacy" name="privacy" > Accetto le <a href="normative.html"> normative sulla privacy </a> conformi al 2017</p>
                            </div>
                        </div>
                        <input class="btn btn-success" id="confirm" type="submit" value="Conferma" disabled="true">
                        <input class="btn btn-danger" type="reset" value="Annulla">
                        
                    </div>
                </div>
            </div>
        </form>
        
    </body>
</html>

