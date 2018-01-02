
<%@page import="beans.Utente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--  Scripts-->
<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="js/materialize.js"></script>
<script src="js/init.js"></script>

<!DOCTYPE html>
<script type="text/javascript">
    $(document).ready(function () {
        $("#privacy").click(function () {
            document.getElementById("confirm").disabled = false;


        });
    });
</script>
<html>
  <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
    <title>Guappo</title>
    <!-- CSS  -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
    <link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

  </head>
	<body style="background-color: white">
		<% if (((Utente) session.getAttribute("user")).getFirstName() != null) {
						response.sendRedirect("homepage.jsp");
				}
		%>
		<jsp:include page="navbar.jsp"/>

		<div id="register-page" class="row">
    	<div class="col s10 offset-s1 z-depth-4 card-panel hoverable">
      	<form action="registration" method="POST" class="login-form">


          <c:if test="${param.e == '1'}" >
              <div class="alert alert-danger">
                  <strong>Registrazione negata</strong> Le password non coincidono, riprova!
              </div>
          </c:if>
          <c:if test="${param.e == '2'}" >
              <div class="alert alert-danger">
                  <strong>Registrazione negata</strong> La mail usata è già in uso, scegline un'altra!
              </div>
          </c:if>


        	<div class="row">
          	<div class="input-field col s12 center">
            	<h4>Register</h4>
	          </div>
	        </div>
					<div class="row margin">
	          <div class="input-field col s4">
	            <i class="material-icons prefix" style="top: 10px;">person_outline</i>
	            <input placeholder="Nome" type="text" id="nome" name="nome" required="required">
            </div>
						<div class="input-field col s4">
	            <i class="material-icons prefix" style="top: 10px;">person_outline</i>
              <input placeholder="Cognome" type="text" id="cognome" name="cognome" required="required">
	          </div>
	          <div class="input-field col s4">
	            <i class="material-icons prefix" style="top: 10px;">portrait</i>
	            <input placeholder="Username" class="validate" type="text" id="username" name="username" required="required">
	          </div>
	        </div>
	        <div class="row margin">
	          <div class="input-field col s6">
	            <i class="material-icons prefix" style="top: 10px;">mail_outline</i>
	            <input placeholder="Email" class="validate" type="email" id="mail1" name="mail1" required="required">
	          </div>
						<div class="input-field col s6">
	            <i class="material-icons prefix" style="top: 10px;">mail_outline</i>
	            <input placeholder="Confirm Email" class="validate" type="text" id="mail2" name="mail2" required="required">
	          </div>
	        </div>
	        <div class="row margin">
	          <div class="input-field col s6 m6 l6">
	            <i class="material-icons prefix" style="top: 10px;">lock_outline</i>
	            <input placeholder="Password" class="validate" type="password" id="pass2" name="pass1" required="required">
	          </div>
	          <div class="input-field col s6 m6 l6">
	            <i class="material-icons prefix" style="top: 10px;">lock_outline</i>
	            <input placeholder="Confirm Password" class="validate" type="password" id="pass2" name="pass2" required="required">
	          </div>
	        </div>

					<p style="padding-left: 15px"> <input type="checkbox" id="privacy" name="privacy" >
						Accetto le <a href="#modal" class="modal-trigger"> normative sulla privacy </a> conformi al 2017
					</p>

					<div class="row">
						<button class="btn waves-effect col s6 m6 l6" type="submit" id="confirm" value="Conferma">Register Now</button>
						<button class="btn waves-effect red lighten-1 col s6 m6 l6"type="reset" value="Annulla">Cancel</button>
					  <div class="input-field col s12">
	            <p class="margin center medium-small sign-up">Already have an account? <a href="loginPage.jsp">Login</a></p>
	          </div>
	        </div>
	      </form>
	    </div>
	  </div>


	<div id="modal" class="modal modal-fixed-footer">
    <div class="modal-content">
      <h4>Normative Privacy 2017</h4>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
			<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
		</div>
    <div class="modal-footer">
      <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat ">DISAGREE</a>
    	<a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat ">AGREE</a>
    </div>
  </div>

  <footer>


	</footer>

</body>
</html>
