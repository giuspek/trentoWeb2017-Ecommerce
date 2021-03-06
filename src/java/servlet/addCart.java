/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import beans.Carrello;
import beans.Elemento;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Giuseppe
 */
public class addCart extends HttpServlet {

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
        String name = request.getParameter("nomeProdotto");
        double price = Double.parseDouble(request.getParameter("prezzoProdotto"));
        int quantita = Integer.parseInt(request.getParameter("quantita"));
        int idProduct = Integer.parseInt(request.getParameter("idProduct"));
        /*Elemento e = new Elemento();
        e.setName(name);
        e.setPrice(price);
        e.setQuantity(quantita);*/
        HttpSession session=request.getSession();
        Carrello cart = (Carrello) request.getSession().getAttribute("cart");
        if (cart == null) {
            //response.sendRedirect("pepepep.jsp");
            cart = new Carrello();
            
            System.out.println(cart);
            
        }
        if(request.getParameter("deposit").equals("T")){
            cart.addElement(name, price, quantita, request.getParameter("shopName"), request.getParameter("shopAddress"), idProduct);
        }
        else{
            cart.addElement(name, price, quantita, idProduct );              
        }
        session.setAttribute("cart", cart);
        response.sendRedirect("addedObject.jsp");
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
        processRequest(request, response);
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
