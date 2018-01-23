<%-- 
    Document   : homepage
    Created on : 30-mag-2017, 17.19.21
    Author     : Giuseppe

<img src="img/header-1.jpg" class="center-block" alt="HomePage" style="bottom:-70px">
   
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Guappo-HomePage</title>
        
    </head>
    <body>
        
        <jsp:include page="navbar.jsp"/>
        
        <div class="bg">
        
            <div class="container">
                <div class="row justify-content-md-center">
                    <form action="risultati3.jsp" method="GET" class="form-inline" style="padding-top: 5px">
                        <div class="col">
                            <select class="form-control" id="filter" name="filter" onchange="applyFilter(this.value)">
                                 <option disabled >Filtra i risultati</option>
                                <option value="name" default>Ricerca per nome</option>
                                <option value="first_genre">Ricerca per categoria</option>
                            </select>
                        </div>
                        <div class="col">
                            <input class="form-control " type="search" id="oggetto" name="oggetto" placeholder="Search" aria-label="Search">
                        </div>
                        <input type="hidden" name="filter" value="name">
                        <input type="hidden" name="orderparam" value="price">
                        <div class="col">
                            <button class="btn btn-outline-success " type="submit"><span class="glyphicon glyphicon-search"></span> Search</button>
                        </div>
                    </form>    
                </div>
            </div> 
        
        </div>    
        <style>
        .bg {
            /* The image used */
            background-image: url("img/header-1.jpg");

            /* Full height */
            height: 100%; 

            /* Center and scale the image nicely */
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
        }                
        </style>
               
    </body>
</html>
