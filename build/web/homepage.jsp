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
<script type="text/javascript">
    function prova() {
        if (document.getElementById('theButton').checked) {
            $("#extraFilter").show();
        } else {
            $("#extraFilter").hide();
        }
    }
    ;
    function applyFilter2(x){
        if(x === "first_genre")
            $("#oggetto2").autocomplete({
                source: categorie,
                minLength: 3,
                limit: 10
            });
        else{
           $("#oggetto2").autocomplete({
                source: lista,
                minLength: 3,
                limit: 10
            }); 
        }
    }

    $(document).ready(function () {
        $("#extraFilter").hide();
        
        $("#oggetto2").autocomplete({
            source: lista,
            minLength: 3,
            limit: 10
        });

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
    });
</script>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Guappo</title>

    </head>
    <body>

        <jsp:include page="navbar.jsp"/>
        <div class="container">

            <div class="row">

                <div class="col-lg-3" style="padding-top: 20px;">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="font-size: 35px">Ricerca</div>
                        <div class="panel-body">

                            <form class="form" action="ApplyFilter" method="POST">
                                <div class="col" style="padding-top: 0px;">
                                    <select class="form-control" id="filter" name="filtro" onchange="applyFilter2(this.value)">
                                        <option disabled >Filtra i risultati</option>
                                        <option value="name" default>Ricerca per nome</option>
                                        <option value="first_genre">Ricerca per categoria</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <div class="col" style="padding-top: 15px;">
                                        <input class="form-control " type="search" id="oggetto2" name="oggetto" placeholder="Search" aria-label="Search">
                                    </div>
                                </div>
                                <hr>
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
                                        <button class="btn btn-outline-success " id="sender" type="submit" value="Conferma"><span class="glyphicon glyphicon-search"></span> Search</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9" style="padding-top: 20px;">
                    <div class="thumbnail">
                        <img src="img/homepage.jpg" alt="Guappo" style="width:100%">
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
