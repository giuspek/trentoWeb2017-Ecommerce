<%-- 
    Document   : forgetPassword
    Created on : 24-set-2017, 16.31.50
    Author     : Giuseppe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Recupera password</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading" style="font-size: 30px">Recupera Password</div>
                <div class="panel-body">
                    <div class="form-horizontal">
                        <form action="resetPassword" method="POST">
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="mail"><span class="glyphicon glyphicon-lock"></span> Email:</label>
                                <div class="col-sm-10">
                                    <input type="password" class="form-control" id="mail" name="mail" placeholder="Inserisci Email">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" class="btn btn-success pull-left"><span class="glyphicon glyphicon-send"></span> Submit</button>
                                    <button class="btn btn-danger pull-left" type="reset" onclick="window.location.href = '<%=request.getHeader("Referer")%>'">Annulla </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
