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
import java.util.ArrayList;
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
public class SuppliesRedirectPage extends HttpServlet {

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
        session.setAttribute("itemPgNum", null);
        request.setAttribute("addsValue", deliveryValue() + otheAddsValue());
        
        String action = request.getParameter("button");
        
        if (action == null || action.isEmpty()) 
        {
            if (session.getAttribute("suppliesPgNum") == null) 
            {
                session.setAttribute("suppliesPgNum", 1);
            }
        } 
        else 
        {
            int pageNumber = Integer.parseInt(action);
            session.setAttribute("suppliesPgNum", pageNumber);
        }
        
        String genClassClause = (String) session.getAttribute("genSortS");
                if (genClassClause == null) 
                {
                    StringBuilder sb = new StringBuilder();
                    for (String genClass : retrieveAllGenIdsAsArray())
                    {
                        sb.append("'").append(genClass).append("'");
                        sb.append(",");
                    }
                    genClassClause = sb.toString().substring(0, sb.length() - 1);
                }
                
                String subClassClause = (String) session.getAttribute("subSortS");
                if (subClassClause == null) 
                {
                    StringBuilder sb = new StringBuilder();
                    for (String subClass : retrieveAllSubIdsAsArray())
                    {
                        sb.append("'").append(subClass).append("'");
                        sb.append(",");
                    }
                    subClassClause = sb.toString().substring(0, sb.length() - 1);
                }
        
        Statement stmt = con.createStatement();
        String query = "SELECT * FROM ITEM\n" +
                "INNER JOIN INVENTORY ON ITEM.ITEM_CODE = INVENTORY.ITEM_CODE\n" +
                "INNER JOIN TRANSACTIONS ON ITEM.ITEM_CODE = TRANSACTIONS.ITEM_CODE\n" +
                "INNER JOIN PRICING ON ITEM.ITEM_CODE = PRICING.ITEM_CODE\n" +
                "INNER JOIN STOCKHISTORY ON ITEM.ITEM_CODE = STOCKHISTORY.ITEM_CODE\n" +
                "INNER JOIN GEN_CLASS ON ITEM.GEN_ID = GEN_CLASS.GEN_ID\n" +
                "INNER JOIN SUB_CLASS ON ITEM.SUB_ID = SUB_CLASS.SUB_ID \n" +
                "INNER JOIN UNIT_CLASS ON PRICING.UNIT_ID = UNIT_CLASS.UNIT_ID\n" +
                "WHERE ITEM.DISABLED = FALSE AND"
                + "(ITEM.GEN_ID IN ("+ genClassClause +") OR ITEM.GEN_ID IS NULL) AND "
                                + "(ITEM.SUB_ID IN ("+ subClassClause +") OR ITEM.SUB_ID IS NULL) "
                + "ORDER BY ITEM_NUM "
                + "OFFSET "+ (((int) session.getAttribute("suppliesPgNum") - 1) * 10) +" ROWS FETCH NEXT 10 ROWS ONLY";
        
                ResultSet rs = stmt.executeQuery(query);
                request.setAttribute("deliveries", rs);
                
                session.setAttribute("suppliesPages", countPages(genClassClause, subClassClause));
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
    
    public int countPages(String genClassClause, String subClassClause) throws SQLException
    {
        Statement stmt = con.createStatement();
        String query = "SELECT CEIL(COUNT(*) / 10) AS total_pages "
                + "FROM ITEM WHERE ITEM.DISABLED = FALSE AND"
                + "(ITEM.GEN_ID IN ("+ genClassClause +") OR ITEM.GEN_ID IS NULL) AND "
                                + "(ITEM.SUB_ID IN ("+ subClassClause +") OR ITEM.SUB_ID IS NULL) ";
        ResultSet rs = stmt.executeQuery(query);
        rs.next();
        int count = rs.getInt(1);
        return count;
    }
    
    public String[] retrieveAllGenIdsAsArray() throws SQLException 
    {
        ArrayList<String> genIds = new ArrayList<String>();
        Statement stmt = con.createStatement();
        String query = "SELECT GEN_ID FROM GEN_CLASS";
        ResultSet rs = stmt.executeQuery(query);
        while(rs.next())
        {
            genIds.add(rs.getString("GEN_ID"));
        }
        return genIds.toArray(new String[genIds.size()]);
    }
    
    public String[] retrieveAllSubIdsAsArray() throws SQLException 
    {
        ArrayList<String> genIds = new ArrayList<String>();
        Statement stmt = con.createStatement();
        String query = "SELECT SUB_ID FROM SUB_CLASS";
        ResultSet rs = stmt.executeQuery(query);
        while(rs.next())
        {
            genIds.add(rs.getString("SUB_ID"));
        }
        return genIds.toArray(new String[genIds.size()]);
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
            Logger.getLogger(SuppliesRedirectPage.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SuppliesRedirectPage.class.getName()).log(Level.SEVERE, null, ex);
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