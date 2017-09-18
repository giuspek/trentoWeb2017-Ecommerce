<%-- 
    Document   : homepage
    Created on : 30-mag-2017, 17.19.21
    Author     : Giuseppe
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
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp"/>
        <div class="form-group">
            <div class="container">
                <div class="jumbotron">
                    <div class="container">
                        <div class="row">    
                            <div class="col-xs-8 col-xs-offset-2">
                                <div class="input-group">
                                    <div class="input-group-btn search-panel">
                                        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                            <span id="search_concept">Filter by</span> <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">
                                            <li><a href="#contains">Contains</a></li>
                                            <li><a href="#its_equal">It's equal</a></li>
                                            <li><a href="#greather_than">Greather than ></a></li>
                                            <li><a href="#less_than">Less than < </a></li>
                                            <li class="divider"></li>
                                            <li><a href="#all">Anything</a></li>
                                        </ul>
                                    </div>
                                    <input type="hidden" name="search_param" value="all" id="search_param">         
                                    <input type="text" class="form-control" name="x" placeholder="Search term...">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
