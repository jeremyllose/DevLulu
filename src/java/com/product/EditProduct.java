/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.product;

import com.inventorylist.ItemAction;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
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
public class EditProduct extends HttpServlet {

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
        String productCode = (String) session.getAttribute("productCode");
        
        String getProductDescription = request.getParameter("productDescription");
        float getProductPrice = Float.parseFloat(request.getParameter("productPrice"));
        
        updateProduct(getProductDescription, getProductPrice, productCode);
        
        String[] itemCodes = request.getParameterValues("itemCode");
        String[] itemQuantities = request.getParameterValues("updateItemQuantity");
        int start = 0;
        
        if (itemCodes != null && itemQuantities != null)
        {
            for (String itemCode : itemCodes) 
            {
                updateBillOFMaterial(Integer.parseInt(itemQuantities[start]), productCode, itemCode);
                start++;
            }
        }
        
        String[] itemAdds = request.getParameterValues("itemsAdd");
        String[] addQuantity = request.getParameterValues("itemQuantity");
        start = 0;
        
        if (itemAdds != null)
        {
            for(String addItem : itemAdds)
            {
                addBill(productCode, addItem, Integer.parseInt(addQuantity[start]));
                start++;
            }
        }
        
        String[] itemsRemoved = request.getParameterValues("itemRemove");
        
        if (itemsRemoved != null)
        {
            if(itemsRemoved.length == countDB(productCode))
            {
                session.setAttribute("productMessage", "Item Must at Least have 1 item");
            }
            else
            {
                for (String itemRemove : itemsRemoved) 
                {
                    RemoveBillOFMaterial(productCode, itemRemove);
                }
                session.setAttribute("productMessage", "Item Successfully Edited");
            }
        }
        else
        {
            session.setAttribute("productMessage", "Item Successfully Edited");
        }
        
        
        response.sendRedirect("EditProductRedirect");
    }
    
    public int countDB(String productCode) throws SQLException
    {
        Statement stmt = con.createStatement();
        String query = "select count(*) from BILLOFMATERIALS WHERE PRODUCT_CODE = '"+ productCode +"'";
        ResultSet rs = stmt.executeQuery(query);
        rs.next();
        int count = rs.getInt(1);
        return count;
    }
    
    public void updateProduct(String desc, float price, String productCode)throws SQLException
    {
        String query = "UPDATE PRODUCT SET PRODUCT_DESCRIPTION = ?, PRODUCT_PRICE = ? WHERE PRODUCT_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, desc);
        ps.setFloat(2, price);
        ps.setString(3, productCode);
        ps.executeUpdate();
        ps.close();
    }
    
    public void updateBillOFMaterial(int quantity, String productCode, String itemCode)throws SQLException
    {
        String query = "UPDATE BILLOFMATERIALS SET QUANTITY = ? WHERE PRODUCT_CODE = ? AND ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setInt(1, quantity);
        ps.setString(2, productCode);
        ps.setString(3, itemCode);
        ps.executeUpdate();
        ps.close();
    }
    
    public void RemoveBillOFMaterial(String productCode, String itemCode)throws SQLException
    {
        String query = "DELETE FROM BILLOFMATERIALS WHERE PRODUCT_CODE = ? AND ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, productCode);
        ps.setString(2, itemCode);
        ps.executeUpdate();
        ps.close();
    }
    
    public void addBill(String productCode, String itemCode, int quantity)throws SQLException
    {
        String query = "INSERT INTO BILLOFMATERIALS (PRODUCT_CODE, ITEM_CODE, QUANTITY) "
                + "VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, productCode);
        ps.setString(2, itemCode);
        ps.setInt(3, quantity);
        ps.executeUpdate();
        ps.close();
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
            Logger.getLogger(EditProduct.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(EditProduct.class.getName()).log(Level.SEVERE, null, ex);
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
