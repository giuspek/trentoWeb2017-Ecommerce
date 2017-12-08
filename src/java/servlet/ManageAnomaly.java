/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

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

/**
 *
 * @author Giuseppe
 */
public class ManageAnomaly extends HttpServlet {

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

         
        if (request.getParameter("anomaly") == null) {
            
            response.sendRedirect("errorPage.jsp");
        } else {
            
            Connection con = (Connection) getServletContext().getAttribute("db");
            
            PreparedStatement ps = null;
            ResultSet rs = null;
            
            if ("rejected".equals(request.getParameter("choice"))) {
                
                ps = con.prepareStatement("UPDATE ANOMALIES SET MANAGED = true, SOLUTION = 0, REJECTION = ? WHERE ID = ?");
                ps.setString(1, request.getParameter("description"));
                ps.setInt(2, Integer.parseInt(request.getParameter("anomaly")));
                ps.executeUpdate();
                response.sendRedirect("changeProfileOK.jsp");
                
            } else if ("approved".equals(request.getParameter("choice"))) {
                 
                int i = 0;
                if (request.getParameter("rimborso") != null) {
                    i++;
                }
                if (request.getParameter("resend") != null) {
                    i += 2;
                }
                if (request.getParameter("reputation") != null) {
                    i += 4;
                }
                if (i == 0) {
                    response.sendRedirect("errorPage.jsp");
                } else {
                    ps = con.prepareStatement("UPDATE ANOMALIES SET MANAGED = true, SOLUTION = ? WHERE ID = ?");
                    ps.setInt(1, i);
                    ps.setInt(2, Integer.parseInt(request.getParameter("anomaly")));
                    ps.executeUpdate();
                    response.sendRedirect("changeProfileOK.jsp");
                }
                
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ManageAnomaly.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ManageAnomaly.class.getName()).log(Level.SEVERE, null, ex);
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
