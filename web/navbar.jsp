<%-- 
    Document   : navbar
    Created on : 29-lug-2017, 19.04.17
    Author     : Giuseppe
--%>
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-default">
    <div class="col-md-3">
        <a class="navbar-brand"> U bombo </a>
    </div>
    <c:choose>


        <c:when test="${user.isSeller == true}">
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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Nome e Cognome<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">Profilo</a></li>
                            <li><a href="#">Segnala anomalie</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="Logout">Esci</a></li>
                        </ul>

                    </li>
                </ul>
            </div>
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
    </div>
</c:otherwise>
</c:choose>

</nav>
