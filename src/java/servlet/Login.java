/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import beans.Utente;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Giuseppe
 */
public class Login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException{
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
            //Connection con = (Connection) getServletContext().getAttribute("db");
            PreparedStatement ps=null;
            HttpSession s=request.getSession();
            Utente u=(Utente) s.getAttribute("user");
            //Utente u=
           Connection con = null;
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/guappo", "root", "root");
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        } 
        
        try {
            ps = con.prepareStatement("SELECT * FROM USERS WHERE USERNAME = ? AND PASSWORD = ?"); //con is a Connection object
            ps.setString(1, request.getParameter("usrname"));
            ps.setString(2, request.getParameter("password"));
        } catch (SQLException ex) {
            response.sendRedirect("loginPage.jsp");
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
            if (!rs.next()){
                 response.sendRedirect("loginPage.jsp");
            }
            else{
                if(rs.getBoolean(8) == true){
                    u.setId(rs.getInt(1));
                    u.setFirstName(rs.getString(2));
                    u.setLastName(rs.getString(3));
                    u.setTypeOfAccount(rs.getString(5));
                    u.setUsername(rs.getString(4));
                    u.setActive(rs.getBoolean(8));
                /**
                switch(x){
                    case 'R':
                        u.setIsRegistered(true);
                    break;
                    case 'S':
                        u.setIsSeller(true);
                    break;
                    case 'A':
                        u.setIsAdmin(true);
                    break;
                }  */
                    s.setAttribute("user", u);
                    response.sendRedirect("homepage.jsp");
                }
                else response.sendRedirect("loginPage.jsp");
            }
        } catch (SQLException ex) {
            response.sendRedirect("loginPage.jsp");
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
  
}
