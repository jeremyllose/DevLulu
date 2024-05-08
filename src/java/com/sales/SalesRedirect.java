/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.sales;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
public class SalesRedirect extends HttpServlet {

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
        try 
        {
            if (con != null) 
            {
                HttpSession session = request.getSession();
                String action = request.getParameter("button");
                request.setAttribute("addsValue", deliveryValue() + otheAddsValue());
                Statement stmt = con.createStatement();
                
                String sort = (String) session.getAttribute("sSort");
                if(sort == null)
                {
                    sort = "ORDER BY TOTAL DESC";
                    session.setAttribute("sSort", sort);
                }
                
                if (action == null || action.isEmpty()) 
                {
                    if (session.getAttribute("salesPgNum") == null) 
                    {
                        session.setAttribute("salesPgNum", 1);
                    }
                } 
                else 
                {
                    int pageNumber = Integer.parseInt(action);
                    session.setAttribute("salesPgNum", pageNumber);
                }
                
                ResultSet records = stmt.executeQuery("SELECT ITEM.ITEM_CODE, ITEM.ITEM_NUM, ITEM.ITEM_DESCRIPTION, PRICING.TRANSFER_COST, PRICING.UNIT_PRICE, TRANSACTIONS.DELIVERY, TRANSACTIONS.OTHERADDS, (TRANSFER_COST * DELIVERY) + ((TRANSFER_COST * OTHERADDS)) AS TOTAL FROM ITEM \n" +
"INNER JOIN INVENTORY ON ITEM.ITEM_CODE = INVENTORY.ITEM_CODE\n" +
"INNER JOIN TRANSACTIONS ON ITEM.ITEM_CODE = TRANSACTIONS.ITEM_CODE\n" +
"INNER JOIN PRICING ON ITEM.ITEM_CODE = PRICING.ITEM_CODE\n" +
"INNER JOIN STOCKHISTORY ON ITEM.ITEM_CODE = STOCKHISTORY.ITEM_CODE\n" +
"INNER JOIN GEN_CLASS ON ITEM.GEN_ID = GEN_CLASS.GEN_ID\n" +
"INNER JOIN SUB_CLASS ON ITEM.SUB_ID = SUB_CLASS.SUB_ID\n" +
"INNER JOIN UNIT_CLASS ON PRICING.UNIT_ID = UNIT_CLASS.UNIT_ID\n" +
"WHERE ITEM.DISABLED = FALSE " + sort
                + " OFFSET "+ (((int) session.getAttribute("salesPgNum") - 1) * 10) +" ROWS FETCH NEXT 10 ROWS ONLY");
                
                request.setAttribute("sales", records);
                session.setAttribute("salesPages", countPages());
                request.getRequestDispatcher("sales.jsp").forward(request,response);
                
                records.close();
                stmt.close();
            }
        } 
        catch (SQLException sqle)
        {
                response.sendRedirect("error.jsp");
        } 
    }
    
    public int countPages() throws SQLException
    {
        Statement stmt = con.createStatement();
        String query = "SELECT CEIL(COUNT(*) / 10.0) AS total_pages "
                + "FROM ITEM WHERE ITEM.DISABLED = FALSE";
        ResultSet rs = stmt.executeQuery(query);
        rs.next();
        int count = rs.getInt(1);
        return count;
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
