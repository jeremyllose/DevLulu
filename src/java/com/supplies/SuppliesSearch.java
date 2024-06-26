/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.supplies;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
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
public class SuppliesSearch extends HttpServlet {

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
        String searchBar = request.getParameter("searchBar");
        request.setAttribute("addsValue", deliveryValue() + otheAddsValue());
        
        Statement stmt = con.createStatement();
        String query = "SELECT * FROM ITEM\n" +
                "INNER JOIN INVENTORY ON ITEM.ITEM_CODE = INVENTORY.ITEM_CODE\n" +
                "INNER JOIN TRANSACTIONS ON ITEM.ITEM_CODE = TRANSACTIONS.ITEM_CODE\n" +
                "INNER JOIN PRICING ON ITEM.ITEM_CODE = PRICING.ITEM_CODE\n" +
                "INNER JOIN STOCKHISTORY ON ITEM.ITEM_CODE = STOCKHISTORY.ITEM_CODE\n" +
                "INNER JOIN GEN_CLASS ON ITEM.GEN_ID = GEN_CLASS.GEN_ID\n" +
                "INNER JOIN SUB_CLASS ON ITEM.SUB_ID = SUB_CLASS.SUB_ID \n" +
                "INNER JOIN UNIT_CLASS ON PRICING.UNIT_ID = UNIT_CLASS.UNIT_ID\n" +
                "WHERE ITEM.DISABLED = FALSE AND "
                + "LOWER(ITEM_DESCRIPTION) LIKE LOWER('"+ searchBar +"%') OR "
                                + "LOWER(ITEM.ITEM_CODE) LIKE LOWER('"+ searchBar +"%') OR "
                                + "LOWER(ITEM.ABBREVIATION) LIKE LOWER('"+ searchBar +"%') "
                + "ORDER BY ITEM_NUM";
                ResultSet rs = stmt.executeQuery(query);
                request.setAttribute("deliveries", rs);
                
                request.getRequestDispatcher("suppliesreceived.jsp").forward(request,response);
                
                rs.close();
                stmt.close();
    }
    
    public float deliveryValue() throws SQLException
    {
        Statement stmt = con.createStatement();
        String query = "SELECT * FROM ITEM\n" +
                "INNER JOIN INVENTORY ON ITEM.ITEM_CODE = INVENTORY.ITEM_CODE\n" +
                "INNER JOIN TRANSACTIONS ON ITEM.ITEM_CODE = TRANSACTIONS.ITEM_CODE\n" +
                "INNER JOIN PRICING ON ITEM.ITEM_CODE = PRICING.ITEM_CODE\n" +
                "WHERE ITEM.DISABLED = FALSE";
        ResultSet rs = stmt.executeQuery(query);
        
        float inventoryValue = 0;
        
        while(rs.next())
        {
            int quantity = rs.getInt("delivery");
            float unitPrice = rs.getFloat("unit_price");
            inventoryValue += quantity * unitPrice;
        }
        
        rs.close();
        stmt.close();
        
        return inventoryValue;
    }
    
    public float otheAddsValue() throws SQLException
    {
        Statement stmt = con.createStatement();
        String query = "SELECT * FROM ITEM\n" +
                "INNER JOIN INVENTORY ON ITEM.ITEM_CODE = INVENTORY.ITEM_CODE\n" +
                "INNER JOIN TRANSACTIONS ON ITEM.ITEM_CODE = TRANSACTIONS.ITEM_CODE\n" +
                "INNER JOIN PRICING ON ITEM.ITEM_CODE = PRICING.ITEM_CODE\n" +
                "WHERE ITEM.DISABLED = FALSE";
        ResultSet rs = stmt.executeQuery(query);
        
        float inventoryValue = 0;
        
        while(rs.next())
        {
            int quantity = rs.getInt("otheradds");
            float unitPrice = rs.getFloat("unit_price");
            inventoryValue += quantity * unitPrice;
        }
        
        rs.close();
        stmt.close();
        
        return inventoryValue;
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
            Logger.getLogger(SuppliesSearch.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SuppliesSearch.class.getName()).log(Level.SEVERE, null, ex);
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