/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import beans.Utente;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Giuseppe
 */
public class CreateReview extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        HttpSession s = request.getSession();
        Utente u = (Utente) s.getAttribute("user");
        Connection con = (Connection) getServletContext().getAttribute("db");
        PreparedStatement ps = null;
        int i = 0;
        float media = 0;
        int id = 0;
        ResultSet rs = null;
        java.sql.Date c = new java.sql.Date(Calendar.getInstance().getTime().getTime());
        String t = c.toString() + " 00:00:00.0";
        //java.sql.Date t = new java.sql.Date(today.YEAR, today.MONTH, today.DATE);

        if (request.getParameter("sell") == null) {
            response.sendRedirect("errorPage.jsp");
        } else {
            try {
                ps = con.prepareStatement("SELECT * FROM SELLS WHERE ID = ?");
                ps.setInt(1, Integer.parseInt(request.getParameter("sell")));
                rs = ps.executeQuery();
            } catch (SQLException ex) {
                response.sendRedirect("errorPage.jsp");
            }

            /* 
        Assicurati che l'utente arrivi dalla propria pagina della recensione
        (ovvero che ci sia risposta alla query precedenete) e che l'utente corrisponda
             */
            try {
                if (rs.next()) {
                    
                    /*if (Integer.parseInt(rs.getString("ID_CREATOR")) != u.getId()) {
                    response.sendRedirect("errorPage.jsp");
                } else {*/
                    int p = rs.getInt("ID_PRODUCT");
                    
                    try {
                        ps = con.prepareStatement("SELECT MAX(ID) as massimo FROM REVIEWS ");
                        rs = ps.executeQuery();
                        if (rs.next()) {
                            id = rs.getInt("massimo") + 1;
                        }
                    } catch (SQLException ex) {
                        response.sendRedirect("errorPage.jsp");
                    }
                    
                    try {
                        //Inserisci la recensione

                        ps = con.prepareStatement("INSERT INTO REVIEWS VALUES (?,?,?,?,?,?,?,?,?,?)");
                        ps.setInt(1, id);
                        ps.setInt(2, Integer.parseInt(request.getParameter("overall")));
                        ps.setInt(3, Integer.parseInt(request.getParameter("ratingQuality")));
                        ps.setInt(4, Integer.parseInt(request.getParameter("ratingService")));
                        ps.setInt(5, Integer.parseInt(request.getParameter("ratingPrice")));
                        ps.setString(6, request.getParameter("title"));
                        ps.setString(7, request.getParameter("description"));
                        ps.setString(8, t);
                        ps.setInt(9, p);
                        ps.setInt(10, u.getId());
                        ps.executeUpdate();
                        //Segna che il prodotto è stato recensito
                        ps = con.prepareStatement("UPDATE SELLS SET REVIEWED = true WHERE ID = ?");
                        ps.setInt(1, Integer.parseInt(request.getParameter("sell")));
                        ps.executeUpdate();

                        ps = con.prepareStatement("SELECT AVG(CAST(R.GLOBAL_VALUE AS FLOAT)) AS media FROM REVIEWS R, PRODUCTS P WHERE P.ID = R.ID_PRODUCT AND P.ID IN (SELECT P1.ID FROM PRODUCTS P1, SELLS S WHERE S.ID_PRODUCT = P1.ID AND S.ID = ?) GROUP BY P.ID");
                        ps.setInt(1, Integer.parseInt(request.getParameter("sell")));
                        rs = ps.executeQuery();

                        rs.next();
                        media = rs.getFloat("media");
                        ps = con.prepareStatement("UPDATE PRODUCTS SET GLOBAL_VALUE = ? WHERE ID IN (SELECT P1.ID FROM PRODUCTS P1, SELLS S WHERE S.ID_PRODUCT = P1.ID AND S.ID = ?)");
                        ps.setFloat(1, media);
                        ps.setString(2, request.getParameter("sell"));
                        ps.executeUpdate();

                        ps = con.prepareStatement("SELECT AVG(CAST(R.GLOBAL_VALUE AS FLOAT)) AS media FROM REVIEWS R, PRODUCTS P WHERE P.ID = R.ID_PRODUCT AND P.ID_SHOP IN (SELECT P1.ID_SHOP FROM PRODUCTS P1, SELLS S WHERE S.ID_PRODUCT = P1.ID AND S.ID = ?) GROUP BY P.ID_SHOP");
                        ps.setInt(1, Integer.parseInt(request.getParameter("sell")));
                        rs = ps.executeQuery();

                        rs.next();
                        media = rs.getFloat("media");
                        ps = con.prepareStatement("UPDATE SHOPS SET GLOBAL_VALUE = ? WHERE ID IN (SELECT P1.ID_SHOP FROM PRODUCTS P1, SELLS S WHERE S.ID_PRODUCT = P1.ID AND S.ID = ?)");
                        ps.setFloat(1, media);
                        ps.setString(2, request.getParameter("sell"));
                        ps.executeUpdate();
                        response.sendRedirect("prodotto.jsp?prodotto=" + p);

                    } catch (SQLException ex) {
                        response.sendRedirect("errorPage.jsp" + t);
                        Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
                    }

                }
                //}

            } catch (SQLException ex) {
                response.sendRedirect("errorPage.jsp");
                Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

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
        response.sendRedirect("errorPage.jsp");
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
            Logger.getLogger(CreateReview.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
