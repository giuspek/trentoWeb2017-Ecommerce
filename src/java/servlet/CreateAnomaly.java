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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class CreateAnomaly extends HttpServlet {

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
        ResultSet rs = null;
        int idVendita = 0, idVenditore = 0;

        ps = con.prepareStatement("SELECT U.ID FROM USERS U, SELLS S, PRODUCTS P, SHOPS T WHERE S.ID = ? AND S.ID_PRODUCT = P.ID AND P.ID_SHOP = T.ID AND T.ID_OWNER = U.ID");
        ps.setInt(1, Integer.parseInt(request.getParameter("sell")));
        rs = ps.executeQuery();

        if (rs.next()) {
            idVenditore = rs.getInt("id");
            ps = con.prepareStatement("INSERT INTO ANOMALIES VALUES (DEFAULT,?,?,?,?,?,?,null,null)");

            ps.setString(1, request.getParameter("type"));
            ps.setString(2, request.getParameter("description"));
            ps.setBoolean(3, false);
            ps.setInt(4, Integer.parseInt(request.getParameter("sell")));
            ps.setInt(5, u.getId());
            ps.setInt(6, idVenditore);

            ps.executeUpdate();
            response.sendRedirect("changeProfileOK.jsp");
        } else {
            response.sendRedirect("errorPage.jsp");
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CreateAnomaly.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CreateAnomaly.class.getName()).log(Level.SEVERE, null, ex);
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
