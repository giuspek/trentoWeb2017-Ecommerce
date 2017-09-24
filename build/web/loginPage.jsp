<%-- 
    Document   : index
    Created on : 14-set-2017, 16.38.10
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Guappo</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    </head>
    <body>
        <jsp:include page="navbar.jsp"/>
        <form action="Login" method="POST">
            <div class="form-group">
                <div class="container">
                    <div class="jumbotron">
                        <div class="row">
                            <div class="col-md-6">
                                <label for="username">
                                    Username
                                </label>
                                <input class="form-control" type="text" id="username" name="username">
                            </div>
                            <div class="col-md-6">
                                <label for="password">
                                    Password
                                </label>
                                <input class="form-control" type="password" id="password" name="password">
                            </div>
                        </div>
                        <p> </P>
                        <div class="row">
                            <a href="forgetPassword.jsp" >Hai dimenticato la password?</a>
                        </div>
                        <p> </p>
                        <div class="row">
                            <input class="btn btn-success" type="submit" value="Conferma">
                            <input class="btn btn-danger" type="reset" value="Annulla">
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
