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
public class ChangeUsername extends HttpServlet {

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
       
        HttpSession s=request.getSession();
        Utente u=(Utente) s.getAttribute("user");
        Connection con = (Connection) getServletContext().getAttribute("db");
        PreparedStatement ps=null;
        try {
            ps = con.prepareStatement("SELECT * FROM USERS WHERE USERNAME = ?"); //con is a Connection object
            ps.setString(1, request.getParameter("nick1"));
        }
        catch (SQLException ex) {
            response.sendRedirect("errorPage.jsp");
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
        ResultSet rs=null;
         try {
             rs = ps.executeQuery();
        } catch (SQLException ex) {
            response.sendRedirect("loginPage.jsp");
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
         
         
        try {
            if (rs.next()){
                 response.sendRedirect("errorPage.jsp");
            }
            else{
                ps = con.prepareStatement("UPDATE USERS SET USERNAME = ? WHERE USERNAME = ?");
                ps.setString(1, request.getParameter("nick1"));
                ps.setString(2, u.getUsername());
                ps.executeUpdate();
                u.setUsername(request.getParameter("nick1"));
                s.setAttribute("user", u);
                response.sendRedirect("changeProfileOK.jsp");
            }
        } catch (SQLException ex) {
            response.sendRedirect("loginPage.jsp");
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ChangeUsername.class.getName()).log(Level.SEVERE, null, ex);
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
