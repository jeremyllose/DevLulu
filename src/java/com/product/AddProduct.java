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
public class AddProduct extends HttpServlet {

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
        
        
        String getProductType = request.getParameter("productType");
        String getProductDescription = request.getParameter("productDescription");
        float getProductPrice = Float.parseFloat(request.getParameter("productPrice"));
        
        String[] itemIds = request.getParameterValues("items");
        String[] itemQuantity = request.getParameterValues("itemQuantity");
        
        String beginning = "";
        if(getProductType.equals("ML") || getProductType.equals("DS"))
        {
            beginning = "PD";
        }
        else
        {
            beginning = "BV";
        }
        
        String baseName = beginning + "-" + getProductType + "-";
        int start = 1;
        String formattedLength = String.format("%04d", start);
        String name = baseName + formattedLength;
        
        while (checkCode(name))
        {
                    start++;
                    formattedLength = String.format("%04d", start);
                    name = baseName + formattedLength;
        }
        
        if(check(getProductDescription))
        {
            session.setAttribute("productMessage", "Product Already Exists");
            response.sendRedirect("AddProductRedirect");
        }
        else if(itemIds == null)
        {
            session.setAttribute("productMessage", "Product Must require at least 1 Item");
            response.sendRedirect("AddProductRedirect");
        }
        else
        {
        addProduct(name, getProductDescription, getProductPrice);
        
        for (String itemId : itemIds) 
        {
            try 
            {
                addBill(name, itemId, Integer.parseInt(itemQuantity[start]));
                start++;
            }
            catch (SQLException ex) 
            {
                Logger.getLogger(ItemAction.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        session.setAttribute("productMessage", "Product Successfully Added");
        response.sendRedirect("ProductRedirect");
        }
    }
    
    public void addProduct(String productCode, String productDescription, float productPrice)throws SQLException
    {
        String query = "INSERT INTO PRODUCT (PRODUCT_CODE, PRODUCT_DESCRIPTION, PRODUCT_PRICE) "
                + "VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, productCode);
        ps.setString(2, productDescription);
        ps.setFloat(3, productPrice);
        ps.executeUpdate();
        ps.close();
    }
    
    public void addBill(String productCode, String itemCode, int itemQuantity)throws SQLException
    {
        String query = "INSERT INTO BILLOFMATERIALS (PRODUCT_CODE, ITEM_CODE, QUANTITY) "
                + "VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, productCode);
        ps.setString(2, itemCode);
        ps.setInt(3, itemQuantity);
        ps.executeUpdate();
        ps.close();
    }
    
    public boolean check(String desc) throws SQLException
    {
        String query = "SELECT 1 FROM PRODUCT WHERE LOWER(PRODUCT_DESCRIPTION) = LOWER(?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, desc);
        ResultSet resultSet = ps.executeQuery();
        
        return resultSet.next();
    }
    
    public boolean checkCode(String pkey) throws SQLException
    {
        String query = "SELECT 1 FROM PRODUCT WHERE PRODUCT_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, pkey);
        ResultSet resultSet = ps.executeQuery();
        
        return resultSet.next();
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
            Logger.getLogger(AddProduct.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AddProduct.class.getName()).log(Level.SEVERE, null, ex);
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
