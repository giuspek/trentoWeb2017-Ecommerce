<%-- 
    Document   : register
    Created on : 29-lug-2017, 19.03.05
    Author     : Giuseppe
--%>

<%@page import="beans.Utente"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<script type="text/javascript">
    function app() {
        document.getElementById("confirm").disabled = false;
    }
    function app2() {
        document.getElementById("confirm").disabled = true;
    }
    $(document).ready(function () {
        $("#privacy").click(function () {
            document.getElementById("confirm").disabled = false;


        });
    });

</script>
<c:if test="${user.typeOfAccount == 'S' || user.typeOfAccount == 'A'  || user.typeOfAccount == 'R' }">
    <jsp:forward page="errorPage.jsp" />
</c:if>
<html>
    <head>
        <title>Guappo</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>

    <body>
        <% if (((Utente) session.getAttribute("user")).getFirstName() != null) {
                response.sendRedirect("homepage.jsp");
            }
        %>
        <jsp:include page="navbar.jsp"/>
        <div class="container">
            <c:if test="${param.e == '1'}" >
                <div class="alert alert-danger">
                    <strong>Registrazione non effettuata</strong> Le mail o le password nei campi non coincidono!
                </div>
            </c:if>
            <c:if test="${param.e == '2'}" >
                <div class="alert alert-danger">
                    <strong>Registrazione non effettuata</strong> L'indirizzo mail è gia stato usato
                </div>
            </c:if>
            <c:if test="${param.e == '3'}" >
                <div class="alert alert-danger">
                    <strong>Registrazione non effettuata</strong> L'username è gia stato usato
                </div>
            </c:if>
            <c:if test="${param.e == 'c'}" >
                <div class="alert alert-success">
                    <strong>Registrazione effettuata</strong> Attiva il tuo tramite link nella mail.
                </div>
            </c:if>
            <div class="panel panel-default">
                <div class="panel-heading">Registrati</div>
                <div class="panel-body">
                    <form class="form-horizontal" action="Registration" method="POST">
                        <div class="form-group">
                            <label class="control-label col-sm-2" for="nome"><span class="glyphicon glyphicon-user"></span> Nome:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="nome" name="nome" placeholder="Enter First Name" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-2" for="cognome"><span class="glyphicon glyphicon-user"></span> Cognome:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="cognome" name="cognome" placeholder="Enter Last Name" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-2" for="username"><span class="glyphicon glyphicon-user"></span> Username:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="username" name="username" placeholder="Enter Username" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-2" for="mail1"><span class="glyphicon glyphicon-user"></span> Mail:</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" id="mail1" name="mail1" placeholder="Enter Mail" required>
                            </div>
                        </div><div class="form-group">
                            <label class="control-label col-sm-2" for="mail2"><span class="glyphicon glyphicon-user"></span> Conferma mail:</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" id="mail2" name="mail2" placeholder="Confirm Mail" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-2" for="pass1"><span class="glyphicon glyphicon-lock"></span> Password:</label>

                            <div class="col-sm-10">
                                <input type="password" class="form-control" pattern="[A-Za-z0-9]{8,}" id="pass1" name="pass1" placeholder="Enter password" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-2" for="pass2"><span class="glyphicon glyphicon-lock"></span> Conferma Password:</label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" pattern="[A-Za-z0-9]{8,}" id="pass2" name="pass2" placeholder="Confirm password" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button id="confirm" type="submit" class="btn btn-success pull-left" disabled="true" ><span class="glyphicon glyphicon-send"></span> Submit</button>
                                <!-- Trigger the modal with a button -->
                                <button type="button" id="button" class="btn btn-primary btn pull-right" data-toggle="modal" data-target="#myModal">Accetta le condizioni</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Condizioni d'uso</h4>
                    </div>
                    <div class="modal-body">
                        <p>Gentile utente, ai sensi dell'art. 13 del D. Lgs. 196/2003 La informiamo che Guappo Srl (da qui in avanti
                            “Guappo”), procederà al trattamento dei dati da Lei forniti nel rispetto della normativa in materia di tutela
                            del trattamento dei dati personali. Il conferimento dei dati è facoltativo e la negazione dell’autorizzazione
                            al trattamento dei dati non ci consentirà l’erogazione dei servizi richiesti (ad esempio newsletter,
                            disponibilità merce dei singoli punti vendita, promozioni dedicate agli utenti registrati ecc.).<br>
                            <b>Tipi di dati:</b> i dati personali trattati sono esclusivamente quelli da Lei forniti volontariamente all’atto
                            della registrazione sul sito www.guappo.it. Le comunicazioni verranno inviate prevalentemente via
                            email.<br>
                            <b>Finalita' del trattamento:</b> I dati saranno trattati per finalità statistiche, commerciali, promozionali,
                            pubblicitarie, di marketing e di profilazione;<br>
                            <b>Modalità del trattamento:</b> i dati potranno essere trattati, per il perseguimento delle finalità di cui sopra,
                            in forma cartacea o con strumenti elettronici, in Italia o all’estero, compresi i paesi non appartenenti
                            all’Unione Europea. I dati potranno essere comunicati da Guappo a suoi partner commerciali.
                        </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" onclick="app()" class="btn btn-success" data-toggle="modal" data-target="#myModal">YES</button>
                        <button type="button" onclick="app2()" class="btn btn-danger" data-toggle="modal" data-target="#myModal">NO</button>
                    </div>
                </div>
            </div>
        </div>
    </body>

</html>

