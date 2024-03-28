/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.variance;

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

/**
 *
 * @author Cesar
 */
public class SaveVariance extends HttpServlet {

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
                String[] begginingValues = request.getParameterValues("beg");
                String[] endValues = request.getParameterValues("end");
                int start = 0;
                Statement stmt = con.createStatement();
                String query = "SELECT * FROM ITEM "
                        + "INNER JOIN INVENTORY ON ITEM.ITEM_CODE = INVENTORY.ITEM_CODE "
                        + "INNER JOIN PRICING ON ITEM.ITEM_CODE = PRICING.ITEM_CODE "
                        + "INNER JOIN STOCKHISTORY ON ITEM.ITEM_CODE = STOCKHISTORY.ITEM_CODE "
                        + "INNER JOIN TRANSACTIONS ON ITEM.ITEM_CODE = TRANSACTIONS.ITEM_CODE "
                        + "WHERE ITEM.DISABLED = FALSE ORDER BY ITEM_NUM";
                ResultSet rs = stmt.executeQuery(query);
                
                while(rs.next())
                {
                    editBegItem(Integer.parseInt(begginingValues[start]), rs.getString("item_code"));
                    editEndItem(Integer.parseInt(endValues[start]), rs.getString("item_code"));
                    start++;
                }
                response.sendRedirect("VariancePageRedirect");
                
                rs.close();
                stmt.close();
            }
        } 
        catch (SQLException sqle)
        {
                response.sendRedirect("error.jsp");
        }
    }
    
    public void editBegItem(int beg, String itemCode)throws SQLException
    {
        String query = "UPDATE STOCKHISTORY SET BEGINNING_QUANTITY = ? WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, beg);
        ps.setString(2, itemCode);
        ps.executeUpdate();
        ps.close();
    }
    
    public void editEndItem(int beg, String itemCode)throws SQLException
    {
        String query = "UPDATE STOCKHISTORY SET END_QUANTITY = ? WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, beg);
        ps.setString(2, itemCode);
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
