<%-- 
    Document   : navbar
    Created on : 29-lug-2017, 19.04.17
    Author     : Giuseppe
--%>
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-inverse">
    <div class="navbar-header">
        <a class="navbar-brand"> Guappo </a>
    </div>
    <div class="col-md-3 col-sm-3">
        <form class="navbar-form">
            <div class="input-group">
                <div class="input-group-btn search-panel">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                        <span id="search_concept">Filter by</span> <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#contains">Per oggetto</a></li>
                        <li><a href="#its_equal">Per categoria</a></li>
                        <li><a href="#greather_than">Greather than ></a></li>
                        <li><a href="#less_than">Less than < </a></li>
                        <li class="divider"></li>
                        <li><a href="#all">Anything</a></li>
                    </ul>
                </div>

                <input type="text" class="form-control" name="x" placeholder="Search term...">
                <div class="input-group-btn search-panel">
                <button class="btn btn-default form-control" type="button">
                    <span class="glyphicon glyphicon-search">
                        
                    </span>
                </button>
                </div>
            </div>
        </form>
    </div>
</div>

<c:choose>


    <c:when test="${user.isSeller == true}">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">    
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Nome e Cognome<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Profilo</a></li>
                        <li><a href="#">Il vostro negozio</a></li>
                        <li><a href="Logout">Esci</a></li>
                    </ul>
                <li><a href="#">Notifiche</a></li>
                </li>
            </ul>
        </div>
    </c:when>
    <c:when test="${user.isAdmin == true}">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">    
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Nome e Cognome<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Profilo</a></li>
                        <li><a href="Logout">Esci</a></li>
                    </ul>
                <li><a href="#">Notifiche</a></li>
                </li>
            </ul>
        </div>
    </c:when>
    <c:when test="${user.isRegister == true}">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">    
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <jsp:getProperty name="user" property="firstName" /> <jsp:getProperty name="user" property="lastName" />
                        <span class="caret">   
                        </span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Profilo</a></li>
                        <li><a href="#">Segnala anomalie</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="Logout">Esci</a></li>
                    </ul>

                </li>
            </ul>
        </div>
    </c:when>
    <c:otherwise>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">    
                <li class="dropdown">
                <li><a href="register.jsp">Registrati</a></li>
                <li><a href="loginPage.jsp">Accedi</a></li>
                </li>
            </ul>
        </div>
    </c:otherwise>
</c:choose>

</nav>
