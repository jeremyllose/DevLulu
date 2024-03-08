/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.supplies;

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

/**
 *
 * @author Cesar
 */
public class SaveDeliveries extends HttpServlet {
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
        String[] deliveries = request.getParameterValues("delivery");
        String[] otheradds = request.getParameterValues("others");
        int start = 0;
        
        Statement stmt = con.createStatement();
        String query = "SELECT * FROM ITEM\n" +
                "INNER JOIN INVENTORY ON ITEM.ITEM_CODE = INVENTORY.ITEM_CODE\n" +
                "INNER JOIN TRANSACTIONS ON ITEM.ITEM_CODE = TRANSACTIONS.ITEM_CODE\n" +
                "INNER JOIN PRICING ON ITEM.ITEM_CODE = PRICING.ITEM_CODE\n" +
                "INNER JOIN STOCKHISTORY ON ITEM.ITEM_CODE = STOCKHISTORY.ITEM_CODE\n" +
                "WHERE ITEM.DISABLED = FALSE ORDER BY ITEM_NUM";
        ResultSet rs = stmt.executeQuery(query);
        
        while(rs.next())
        {
            int delivery = Integer.parseInt(deliveries[start]) - previousDelivery(rs.getString("item_code"));
            int adds = Integer.parseInt(otheradds[start]) - previousOthers(rs.getString("item_code"));
            
            int endQuantity = endQuantity(rs.getString("item_code")) + delivery + adds;
            
            updateEndItem(endQuantity, rs.getString("item_code"));
            updateQuantity(endQuantity, rs.getString("item_code"));
            updateDelivery(Integer.parseInt(deliveries[start]), Integer.parseInt(otheradds[start]), rs.getString("item_code"));
            
            start++;
        }
        
        response.sendRedirect("SuppliesRedirectPage");
        
        rs.close();
        stmt.close();
    }
    
    public int previousDelivery(String itemCode) throws SQLException
    {
        int result = 0;
        
        String query = "SELECT DELIVERY FROM TRANSACTIONS WHERE ITEM_CODE=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, itemCode);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getInt("delivery");
        }
        
        return result;
    }
    
    public int previousOthers(String itemCode) throws SQLException
    {
        int result = 0;
        
        String query = "SELECT OTHERADDS FROM TRANSACTIONS WHERE ITEM_CODE=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, itemCode);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getInt("otheradds");
        }
        
        return result;
    }
    
    public int endQuantity(String itemCode) throws SQLException
    {
        int result = 0;
        
        String query = "SELECT END_QUANTITY FROM STOCKHISTORY WHERE ITEM_CODE=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, itemCode);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getInt("end_quantity");
        }
        
        return result;
    }
    
    public void updateEndItem(int end, String itemCode)throws SQLException
    {
        String query = "UPDATE STOCKHISTORY SET END_QUANTITY = ? WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, end);
        ps.setString(2, itemCode);
        ps.executeUpdate();
        ps.close();
    }
    
    public void updateQuantity(int qty, String itemCode)throws SQLException
    {
        String query = "UPDATE INVENTORY SET QUANTITY = ? WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, qty);
        ps.setString(2, itemCode);
        ps.executeUpdate();
        ps.close();
    }
    
    public void updateDelivery(int del, int adds, String itemCode)throws SQLException
    {
        String query = "UPDATE TRANSACTIONS SET DELIVERY = ?, OTHERADDS = ? WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, del);
        ps.setInt(2, adds);
        ps.setString(3, itemCode);
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
            Logger.getLogger(SaveDeliveries.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SaveDeliveries.class.getName()).log(Level.SEVERE, null, ex);
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
