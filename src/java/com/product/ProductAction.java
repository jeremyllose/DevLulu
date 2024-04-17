/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.product;

import com.inventorylist.ItemAction;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Cesar
 */
public class ProductAction extends HttpServlet {
    
    Connection con;
    byte[] key;
    String cypher;
    
    public void init(ServletConfig config) throws ServletException {
            super.init(config);
            ServletContext context = getServletContext();
            
            String pkey = context.getInitParameter("publicKey");
            this.key = pkey.getBytes();
            this.cypher = context.getInitParameter("cypher");
            
            try {	
                    Class.forName(context.getInitParameter("driver"));
                    
                    String username = context.getInitParameter("username");
                    String password = context.getInitParameter("password");
                    String url = context.getInitParameter("url");
                    
                    con = DriverManager.getConnection(url, username, password);
                    
            } catch (SQLException sqle){
                    System.out.println("SQLException error occured - " 
                            + sqle.getMessage());
            } catch (ClassNotFoundException nfe){
                    System.out.println("ClassNotFoundException error occured - " 
                    + nfe.getMessage());
            }
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        String action = request.getParameter("button");
        
        if (action.equals("disable")) 
        {
            String[] itemIds = request.getParameterValues("selectProduct");
            if(itemIds != null)
            {
                for (String itemId : itemIds) 
                {
                    disableUser(itemId);
                }
            }
            session.setAttribute("productMessage", "Items Successfully Disabled");
            response.sendRedirect("ProductRedirect");
        }
        else if (action.equals("Enable")) 
        {
            String product = request.getParameter("enable");
            
            enableUser(product);
            
            session.setAttribute("productMessage", "Item Successfully Enabled");
            response.sendRedirect("ProductRedirect");
        }
        else if (action.equals("save")) 
        {
            String[] products = request.getParameterValues("products");
            String[] quantites = request.getParameterValues("qty");
            int start = 0;
            
            for (String product : products)
            {
                updateProduct(product , Integer.parseInt(quantites[start]));
                start++;
            }
            
            session.setAttribute("productMessage", "Item Quantities Saved");
            response.sendRedirect("ProductRedirect");
        }
        else if(action.substring(0, action.indexOf(" ")).equals("edit"))
        {
            String arr[] = action.split(" ", 2);
            String theRest = arr[1];
            session.setAttribute("productCode", theRest);
            response.sendRedirect("EditProductRedirect");
        }
    }
    
    public void disableUser(String product)throws SQLException
    {
        String query = "UPDATE PRODUCT SET DISABLED = TRUE WHERE PRODUCT_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, product);
        ps.executeUpdate();
    }
    
    public void updateProduct(String product, int quantity)throws SQLException
    {
        String query = "UPDATE PRODUCT SET QUANTITY = ? WHERE PRODUCT_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, quantity);
        ps.setString(2, product);
        ps.executeUpdate();
    }
    
    public void enableUser(String user)throws SQLException
    {
        String query = "UPDATE PRODUCT SET DISABLED = FALSE WHERE PRODUCT_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, user);
        ps.executeUpdate();
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
            Logger.getLogger(ProductAction.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ProductAction.class.getName()).log(Level.SEVERE, null, ex);
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
