/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.inventorylist;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Cesar
 */
public class EditItem extends HttpServlet {

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
            throws ServletException, IOException {
        try {
            String getItemCode = request.getParameter("itemCode");
            String getItemDescription = request.getParameter("itemDescription");
            float getTransferCost = Float.parseFloat(request.getParameter("transferCost"));
            String getGC = request.getParameter("gc");
            String getSC = request.getParameter("sc");
            String getUOM = request.getParameter("uom");
            String getVat = request.getParameter("vat");
            boolean isChecked = getVat != null && getVat.equals("on");
            
            String query = "UPDATE ITEMS SET "
                    + "ITEM_DESCRIPTION = ?, TRANSFER_COST = ?, "
                    + "GEN_ID = ?, SUB_ID =?, "
                    + "UOM = ?, "
                    + "VAT = ?"
                    + "WHERE ITEM_CODE = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, getItemDescription);
            ps.setFloat(2, getTransferCost);
            ps.setString(3, getGC);
            ps.setString(4, getSC);
            ps.setString(5, getUOM);
            ps.setBoolean(6, isChecked);
            ps.setString(7, getItemCode);
            ps.executeUpdate();
            
            unitPrice(isChecked, getItemCode, getTransferCost);
            
            response.sendRedirect("ItemList");
        } catch (SQLException ex) {
            Logger.getLogger(EditItem.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void unitPrice(boolean vat, String itemCode, float transferCost)throws SQLException
    {
        float percent = transferCost * (0.01f * 10.7f);
        float unit = transferCost - percent;
        String query = "UPDATE ITEMS SET UNIT_PRICE = ? WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        if(vat == true)
        {
            ps.setFloat(1, unit);
        }
        else
        {
            ps.setObject(1, null);
        }
        ps.setString(2, itemCode);
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
