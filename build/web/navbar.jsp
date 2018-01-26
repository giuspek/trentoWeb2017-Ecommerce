<%-- 
    Document   : navbar
    Created on : 29-lug-2017, 19.04.17
    Author     : Giuseppe
--%>
<jsp:useBean id="user" class="beans.Utente" scope="session" /> 
<jsp:useBean id="cart" class="beans.Carrello" scope="session" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<link href="http://code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css" rel="stylesheet">
<link href="css/star-rating.css" media="all" rel="stylesheet" type="text/css" />
<script src="js/star-rating.js" type="text/javascript"></script>

<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<sql:query dataSource = "${snapshot}" var = "listaOggetti">
    SELECT DISTINCT NAME from PRODUCTS
</sql:query>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

    var lista = [
    <c:forEach var = "i" begin = '0' end = "${listaOggetti.getRowCount()}">
        "${listaOggetti.rows[i].name}",
    </c:forEach>
    ];


    var categorie = [
        "ACTION",
        "SHOOTER",
        "PLATFORM",
        "TPS",
        "HORROR",
        "PICCHIADURO",
        "JRPG",
        "FPS",
        "STEALTH",
        "RACING",
        "SPORT",
        "RPG",
        "STRATEGICO"
    ];
    
    function applyFilter(x){
        if(x === "first_genre")
            $("#oggetto").autocomplete({
                source: categorie,
                minLength: 1,
                limit: 10
            });
        else{
           $("#oggetto").autocomplete({
                source: lista,
                minLength: 1,
                limit: 10
            }); 
        }
    }
        
        
        
    function applyName(){
            $("#oggetto").autocomplete({
                source: categorie,
                minLength: 1,
                limit: 10
            });
        }

    $(document).ready(function () {
        $("#pricefilter").click(function () {
            $("#filter").val("first_genre");
            document.getElementById("search_concept").textContent = "Per categoria";
            $("#oggetto").autocomplete({
                source: categorie,
                minLength: 1
            });
        });
        
        
        $("#namefilter").click(function () {
            $("#filter").val("name");
            document.getElementById("search_concept").textContent = "Per nome";
            $("#oggetto").autocomplete({
                source: lista,
                minLength: 1
            });
        });

        $("#oggetto").autocomplete({
            source: lista,
            minLength: 1,
            limit: 10
        });
    });
</script>
<nav class="navbar navbar-inverse justify-content-between">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="homepage.jsp" style="font-size: 35px">Guappo</a>
        </div>
        <c:choose>
            <c:when test="${user.typeOfAccount == 'S'}">
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <form action="risultati3.jsp" method="GET" class="form-inline" style="padding-top: 10px">
                                <select class="form-control" id="filter" name="filter" onchange="applyFilter(this.value)">
                                    <option disabled >Filtra i risultati</option>
                                    <option value="name" default>Ricerca per nome</option>
                                    <option value="first_genre">Ricerca per categoria</option>
                                </select>
                                <input class="form-control " type="search" id="oggetto" name="oggetto" placeholder="Search" aria-label="Search">
                                <input type="hidden" name="filter" value="name">
                                <input type="hidden" name="orderparam" value="price">
                                <button class="btn btn-outline-success " type="submit"><span class="glyphicon glyphicon-search"></span> Search</button>
                            </form>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#"><jsp:getProperty name="user" property="firstName" /> <jsp:getProperty name="user" property="lastName" /> <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="cart.jsp">Il mio Carrello</a></li>
                                <li><a href="business.jsp">Il mio Profilo</a></li>
                                <li><a href="ordini.jsp">I miei Ordini</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="Logout">Esci</a></li>
                            </ul>
                        </li>                     
                        <li><a href="notifiche.jsp">Notifiche</a></li>
                    </ul>
                </div>
            </c:when>
            <c:when test="${user.typeOfAccount == 'A'}">
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <form action="risultati3.jsp" method="GET" class="form-inline" style="padding-top: 10px">
                                <select class="form-control" id="filter" name="filter" onchange="applyFilter(this.value)">
                                    <option disabled >Filtra i risultati</option>
                                    <option value="name" default>Ricerca per nome</option>
                                    <option value="first_genre">Ricerca per categoria</option>
                                </select>
                                <input class="form-control " type="search" id="oggetto" name="oggetto" placeholder="Search" aria-label="Search">
                                <input type="hidden" name="filter" value="name">
                                <input type="hidden" name="orderparam" value="price">
                                <button class="btn btn-outline-success " type="submit"><span class="glyphicon glyphicon-search"></span> Search</button>
                            </form>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#"><jsp:getProperty name="user" property="firstName" /> <jsp:getProperty name="user" property="lastName" /> <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="profile.jsp">Il mio Profilo</a></li>                              
                                <li><a href="Logout">Esci</a></li>
                            </ul>
                        </li>                     
                        <li><a href="notificheAdmin.jsp">Notifiche</a></li>
                    </ul>
                </div>
            </c:when>
            <c:when test="${user.typeOfAccount == 'R' && user.active == true}">
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <form action="risultati3.jsp" method="GET" class="form-inline" style="padding-top: 10px">
                                <select class="form-control" id="filter" name="filter" onchange="applyFilter(this.value)">
                                    <option disabled >Filtra i risultati</option>
                                    <option value="name" default>Ricerca per nome</option>
                                    <option value="first_genre">Ricerca per categoria</option>
                                </select>
                                <input class="form-control " type="search" id="oggetto" name="oggetto" placeholder="Search" aria-label="Search">
                                <input type="hidden" name="filter" value="name">
                                <input type="hidden" name="orderparam" value="price">
                                <button class="btn btn-outline-success " type="submit"><span class="glyphicon glyphicon-search"></span> Search</button>
                            </form>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#"><jsp:getProperty name="user" property="firstName" /> <jsp:getProperty name="user" property="lastName" /> <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="cart.jsp">Il mio Carrello</a></li>
                                <li><a href="profile.jsp">Il mio Profilo</a></li>
                                <li><a href="ordini.jsp">I miei Ordini</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="Logout">Esci</a></li>
                            </ul>
                        </li>                     
                        <li><a href="notifiche.jsp">Notifiche</a></li>
                    </ul>
                </div>
            </c:when>
            <c:otherwise>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <form action="risultati3.jsp" method="GET" class="form-inline" style="padding-top: 10px">
                                <select class="form-control" id="filter" name="filter" onchange="applyFilter(this.value)">
                                    <option disabled >Filtra i risultati</option>
                                    <option value="name" default>Ricerca per nome</option>
                                    <option value="first_genre">Ricerca per categoria</option>
                                </select>
                                <input class="form-control " type="search" id="oggetto" name="oggetto" placeholder="Search" aria-label="Search">
                                <input type="hidden" name="orderparam" value="price">
                                <button class="btn btn-outline-success" type="submit" style="font-size: 16px"><span class="glyphicon glyphicon-search"></span> Search</button>
                            </form>
                        </li>
                        <li><a href="register.jsp" style="font-size: 20px"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
                        <li><a href="loginPage.jsp" style="font-size: 20px"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                        <li><a href="cart.jsp" style="font-size: 20px"><span class="glyphicon glyphicon-shopping-cart"></span> Carrello</a></li>
                    </ul>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</nav>
