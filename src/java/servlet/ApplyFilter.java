/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Giuseppe
 */
public class ApplyFilter extends HttpServlet {

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
            throws ServletException, IOException {
        String a=request.getParameter("filtro");
        String b=request.getParameter("oggetto");
        String c=request.getParameter("order");
        if(!(request.getParameter("region").isEmpty()) && !(request.getParameter("rangePrice").isEmpty())){
            String d=request.getParameter("region");
            if(request.getParameter("rangePrice").equals("low"))
                response.sendRedirect("risultati2.jsp?&orderparam="+c+"&filter="+a+"&oggetto="+b+"&region="+d+"&da=0&a=30");
            else if(request.getParameter("rangePrice").equals("mid"))
                response.sendRedirect("risultati2.jsp?&orderparam="+c+"&filter="+a+"&oggetto="+b+"&region="+d+"&da=30&a=70");
            else
                response.sendRedirect("risultati2.jsp?&orderparam="+c+"&filter="+a+"&oggetto="+b+"&region="+d+"&da=70&a=4000");
        }
        else if(!(request.getParameter("region").isEmpty())){
            String d=request.getParameter("region");
            response.sendRedirect("risultati2.jsp?&orderparam="+c+"&filter="+a+"&oggetto="+b+"&region="+d);
        }
        else if(!(request.getParameter("rangePrice").isEmpty())){
            if(request.getParameter("rangePrice").equals("low"))
                response.sendRedirect("risultati2.jsp?&orderparam="+c+"&filter="+a+"&oggetto="+b+"&da=0&a=30");
            else if(request.getParameter("rangePrice").equals("mid"))
                response.sendRedirect("risultati2.jsp?&orderparam="+c+"&filter="+a+"&oggetto="+b+"&da=30&a=70");
            else
                response.sendRedirect("risultati2.jsp?&orderparam="+c+"&filter="+a+"&oggetto="+b+"&da=70&a=4000");
        }else{
            response.sendRedirect("risultati2.jsp?&orderparam="+c+"&filter="+a+"&oggetto="+b);
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
        processRequest(request, response);
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
