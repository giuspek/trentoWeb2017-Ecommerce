/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import beans.Utente;
import java.io.IOException;
import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Registration extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NoSuchAlgorithmException {
        
        //Configurazioni iniziali per la mail
        HttpSession s = request.getSession();
        Utente u = (Utente) s.getAttribute("user");
        Connection con = (Connection) getServletContext().getAttribute("db");
        final String host = "smtp.gmail.com";
        final String port = "465";
        final String username = "giuseppespallitta@gmail.com";
        final String password = "qyeomjyhpyokjqzv";
        Properties props = System.getProperties();
        props.setProperty("mail.smtp.host", host);
        props.setProperty("mail.smtp.port", port);
        props.setProperty("mail.smtp.socketFactory.port", port);
        props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.setProperty("mail.smtp.auth", "true");
        props.setProperty("mail.smtp.starttls.enable", "true");
        props.setProperty("mail.debug", "true");
        Session session = Session.getInstance(props, new Authenticator() {

            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        // Controlla se esiste già un account con quella mail
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement("SELECT * FROM Users WHERE email = ?"); //con is a Connection object
            ps.setString(1, request.getParameter("mail1"));
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
        ResultSet rs = null;
        try {
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (rs == null) {
            response.sendRedirect("register.jsp");
        }

        
        // Crea valore hash di conferma
        MessageDigest md = MessageDigest.getInstance("MD5");
        String hashable=request.getParameter("nickname") + "2" + request.getParameter("cognome") + "?0" + request.getParameter("pass1");
        if (Charset.isSupported("CP1252")) {
            md.update(hashable.getBytes(Charset.forName("CP1252")));
        } else {
            md.update(hashable.getBytes(Charset.forName("ISO-8859-1")));
        }
        byte[] bytes = md.digest();
        StringBuilder str = new StringBuilder();
        for (int i = 0; i < bytes.length; i++) {
            str.append(Integer.toHexString((bytes[i] & 0xFF) | 0x100).substring(1, 3));
        }
        hashable=str.toString();

        
        // Aggiungi account non attivo aspettando mail di conferma
        ps = con.prepareStatement("INSERT INTO USERS VALUES(DEFAULT,?,?,?,?,?,?,DEFAULT,?)");
        ps.setString(1, request.getParameter("nome"));
        ps.setString(2, request.getParameter("cognome"));
        ps.setString(3, request.getParameter("username"));
        ps.setString(4, "R");
        ps.setString(5, request.getParameter("mail1"));
        ps.setString(6, request.getParameter("pass1"));
        ps.setString(7, hashable);
        ps.executeUpdate(); 

        
        //Invia mail per confermare la registrazione
        Message msg = new MimeMessage(session);
        try {
            msg.setFrom(new InternetAddress("giuseppespallitta@gmail.com"));
            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(request.getParameter("mail1"), false));

            msg.setSubject("Completa registrazione");
            String content="<h1> Benvenuto su True Guappo </h1> <p> Apri questo link per confermare </p> <a href=\"http://localhost:8084/TrueGuappo/confirm.jsp?u=" + request.getParameter("username") + "&h=" + hashable + "\"> Attiva account </a>";
            msg.setContent(content, "text/html; charset=utf-8");
            msg.setSentDate(new Date());
            Transport.send(msg);
        } catch (MessagingException me) {
//TODO: log the exception
            me.printStackTrace(System.err);
        }
        response.sendRedirect("waitingconfirm.jsp");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Search.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Registration.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Search.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Registration.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
