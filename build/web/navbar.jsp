<jsp:useBean id="user" class="beans.Utente" scope="session" />
<jsp:useBean id="cart" class="beans.Carrello" scope="session" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<link href="http://code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/css/materialize.min.css">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link href="css/style(nav).css" type="text/css" rel="stylesheet" media="screen,projection"/>

<sql:setDataSource var = "snapshot" driver = "org.apache.derby.jdbc.ClientDriver" url = "jdbc:derby://localhost:1527/guappo"  user = "root"  password = "root" scope="session"/>
<sql:query dataSource = "${snapshot}" var = "listaOggetti">
SELECT NAME from PRODUCTS
</sql:query>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/js/materialize.min.js"></script>
<script src="js/init.js"></script>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">

var lista = [
  <c:forEach var = "i" begin = '0' end = "${listaOggetti.getRowCount()}">
  "${listaOggetti.rows[i].name}",
  </c:forEach>
];

$(document).ready(function () {
  $("#pricefilter").click(function () {
    $("#filter").val("price");
    document.getElementById("search_concept").textContent = "Per prezzo";
  });

  $("#namefilter").click(function () {
    $("#filter").val("name");
    document.getElementById("search_concept").textContent = "Per nome";
  });

  $("#search").autocomplete({
    source: lista,
    minLength: 3
  });
});
</script>


<nav class="nav-border light-blue">

  <div class="nav-wrapper">

    <div class="row">

      <div class="col s2">
        <a id="logo-container" href="homepage.jsp" class="brand-logo left" style="padding-left: 53px; font-size: 30px;">Guappo</a>
        <a href="#" data-activates="mobile-menu" class="button-collapse"><i class="material-icons ">menu</i></a>
      </div>

      <div class="col s10 m10 l5">
        <div class="row"style="padding-left: 87px">
          <div class="left">
            <form method="GET" action="Search">
                <div class="input-field col s4" id="filter" name="filter">
                <select>
                  <option value="" disabled selected>Filtra</option>
                  <option value="1" id="namefilter">Per Nome</option>
                  <option value="2" id="pricefilter">Per Categoria</option>
                </select>
              </div>
              <div class="input-field col s8">
                <input id="search" name="search" placeholder="Cerca un Gioco" style="font-size: 20px;" type="search" required>
                <label class="label-icon" for="search"><i class="material-icons" style="font-size: 35px; left: 10px; top:-15px; position: relative;">search</i>
                </label>
                <i class="material-icons closed" style="font-size: 35px;">close</i>
              </div>
                <input type="submit" style="position: absolute; left: -9999px; width: 1px; height: 1px;" tabindex="-1" />
            </form>
          </div>
        </div>
      </div>

      <c:choose>
      <c:when test="${user.typeOfAccount == 'S'}">


      <div class="col s5 hide-on-med-and-down">
        <ul class="right"style="padding-right: 50px">
          <li>
            <a class="dropdown-button" href="#!" data-activates="dropdown1" style="font-size: 17px;">
              <jsp:getProperty name="user" property="firstName" /> <jsp:getProperty name="user" property="lastName" />

              <i class="material-icons right" style="font-size: 17px;">arrow_drop_down</i>
            </a>
          </li>
          <li><a href="notifiche.jsp" style="font-size: 17px;">Notifiche</a></li>
        </ul>
      </div>

      <ul id="dropdown1" class="dropdown-content">
        <li><a href="profile.jsp" style="font-size: 17px;">Profilo</a></li>
        <li><a href="#" style="font-size: 17px;">Il vostro negozio</a></li>
        <li><a href="cart.jsp" style="font-size: 17px;">Carrello</a></li>
        <li><a href="ordini.jsp" style="font-size: 17px;">I miei ordini</a></li>
        <li role="separator" class="divider"></li>
        <li><a href="Logout" style="font-size: 17px;">Esci</a></li>
      </ul>

      <ul id="mobile-menu" class="side-nav">
        <li><a href="profile.jsp" style="font-size: 17px;">Profilo</a></li>
        <li><a href="#">Il vostro negozio</a></li>
        <li><a href="cart.jsp" style="font-size: 17px;">Carrello</a></li>
        <li><a href="ordini.jsp" style="font-size: 17px;">I miei ordini</a></li>
        <li><a href="notifiche.jsp" style="font-size: 17px;">Notifiche</a></li>
        <li role="separator" class="divider"></li>
        <li><a href="Logout" style="font-size: 17px;">Esci</a></li>
      </ul>


      </c:when>
      <c:when test="${user.typeOfAccount == 'A'}">


      <div class="col s5 hide-on-med-and-down">
        <ul class="right"style="padding-right: 50px">
          <li>
            <a class="dropdown-button" href="#!" data-activates="dropdown1" style="font-size: 17px;">
              <jsp:getProperty name="user" property="firstName" /> <jsp:getProperty name="user" property="lastName" />
              <span class="caret"></span>
              <i class="material-icons right">arrow_drop_down</i>
            </a>
          </li>
          <li><a href="notificheAdmin.jsp" style="font-size: 17px;">Notifiche</a></li>
        </ul>
      </div>

      <ul id="dropdown1" class="dropdown-content">
        <li><a href="profile.jsp" style="font-size: 17px;">Profilo</a></li>
        <li role="separator" class="divider"></li>
        <li><a href="Logout" style="font-size: 17px;">Esci</a></li>
      </ul>

      <ul id="mobile-menu" class="side-nav">
        <li><a href="profile.jsp" style="font-size: 17px;">Profilo</a></li>
        <li><a href="notificheAdmin.jsp" style="font-size: 17px;">Notifiche</a></li>
        <li role="separator" class="divider"></li>
        <li><a href="Logout" style="font-size: 17px;">Esci</a></li>
      </ul>


      </c:when>
      <c:when test="${user.typeOfAccount == 'R' && user.active == true}">


      <div class="col s5 hide-on-med-and-down">
        <ul class="right"style="padding-right: 50px">
          <li>
            <a class="dropdown-button" href="#!" data-activates="dropdown1" style="font-size: 17px;">
              <jsp:getProperty name="user" property="firstName" /> <jsp:getProperty name="user" property="lastName" />
              <span class="caret"></span>
              <i class="material-icons right">arrow_drop_down</i>
            </a>
          </li>
        </ul>
      </div>

      <ul id="dropdown1" class="dropdown-content">
        <li><a href="profile.jsp" style="font-size: 17px;">Profilo</a></li>
        <li><a href="#" style="font-size: 17px;">Segnala anomalie</a></li>
        <li><a href="cart.jsp" style="font-size: 17px;">Carrello</a></li>
        <li><a href="ordini.jsp" style="font-size: 17px;">I miei ordini</a></li>
        <li role="separator" class="divider"></li>
        <li><a href="Logout" style="font-size: 17px;">Esci</a></li>
      </ul>

      <ul id="mobile-menu" class="side-nav">
        <li><a href="profile.jsp" style="font-size: 17px;">Profilo</a></li>
        <li><a href="# style="font-size: 17px;"">Segnala anomalie</a></li>
        <li><a href="cart.jsp" style="font-size: 17px;">Carrello</a></li>
        <li><a href="ordini.jsp" style="font-size: 17px;">I miei ordini</a></li>
        <li role="separator" class="divider"></li>
        <li><a href="Logout" style="font-size: 17px;">Esci</a></li>
      </ul>


      </c:when>
      <c:otherwise>

      <div class="col s5 hide-on-med-and-down">
        <ul class="right"style="padding-right: 50px">
          <li><a href="register.jsp" style="font-size: 17px;">Registrati</a></li>
          <li><a href="loginPage.jsp" style="font-size: 17px;">Accedi</a></li>
          <li><a href="cart.jsp" style="font-size: 17px;">Carrello</a></li>
        </ul>
      </div>

      </div>

      <ul id="mobile-menu" class="side-nav">
        <li><a href="register.jsp" style="font-size: 17px;">Registrati</a></li>
        <li><a href="loginPage.jsp" style="font-size: 17px;">Accedi</a></li>
        <li><a href="cart.jsp" style="font-size: 17px;">Carrello</a></li>
      </ul>

      </c:otherwise>
    </c:choose>

  </div>

</nav>
