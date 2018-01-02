
<%@page import="beans.Utente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--  Scripts-->
<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script src="js/materialize.js"></script>
<script src="js/init.js"></script>

<!-- CSS  -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
<link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!DOCTYPE html>
<html>
<head>
	<title>Guappo</title>
</head>
<body>
	<% if( ( (Utente) session.getAttribute("user")).getFirstName() != null)
			response.sendRedirect("homepage.jsp");
	%>
	<jsp:include page="navbar.jsp"/>

	<div id="login-page" class="row">
		<div class="col s10 offset-s1 z-depth-4 card-panel">
			<form class="login-form" action="Login" method="POST">
				<div class="row margin">
					<div class="row">
						<div class="input-field col s12 center">
							<h4>Login</h4>
						</div>
					</div>
					<div class="input-field col s6 m6 l6">
						<i class="material-icons prefix" style="top: 10px;">portrait</i>
						<input placeholder="Username"id="usrname" name="usrname" type="text">
					</div>
					<div class="input-field col s6 m6 l6">
						<i class="material-icons prefix" style="top: 10px;">lock_outline</i>
						<input placeholder="Password" id="password" type="password" name="password">
					</div>
				</div>
				<div class="row">
					<div class="col s12 m12 l12 ml-2 mt-3">
						<input type="checkbox" id="remember-me" />
						<label for="remember-me">Remember me</label>
					</div>
				</div>
				<div class="row">
					<button class="btn waves-effect col s6 m6 l6" type="submit" name="action" value="Conferma">Login</button>
					<button class="btn waves-effect red lighten-1 col s6 m6 l6"type="reset" value="Annulla">Cancel</button>
				</div>
				<div class="row">
					<div class="input-field col s6 m6 l6">
						<p class="margin medium-small"><a href="register.jsp">Register Now!</a></p>
					</div>
					<div class="input-field col s6 m6 l6">
						<p class="margin right-align medium-small"><a href="forgetPassword.jsp">Forgot password ?</a></p>
					</div>
				</div>
			</form>
      </div>
		</div>
	</div>

	<footer>


	</footer>

</body>
</html>
