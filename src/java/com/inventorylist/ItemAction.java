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
public class ItemAction extends HttpServlet {

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
        HttpSession session = request.getSession();
        String action = request.getParameter("button");
        
        if (action.equals("disable")) 
        {
            String[] itemIds = request.getParameterValues("items");
            for (String itemId : itemIds) 
            {
                try 
                {
                    disableUser(itemId);
                }
                catch (SQLException ex) 
                {
                    Logger.getLogger(ItemAction.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            response.sendRedirect("ItemList");
        }
        else if(action.substring(0, action.indexOf(" ")).equals("edit"))
        {
            try {
                String arr[] = action.split(" ", 2);
                String theRest = arr[1];
                session.setAttribute("itemCode", theRest);
                
                Statement stmt = con.createStatement();
                //Only gets the Accounts where DISABLED IS FALSE
                ResultSet record = stmt.executeQuery("SELECT * FROM ITEMS "
                        + "INNER JOIN GEN_CLASS ON ITEMS.GEN_ID = GEN_CLASS.GEN_ID "
                        + "INNER JOIN SUB_CLASS ON ITEMS.SUB_ID = SUB_CLASS.SUB_ID "
                        + "WHERE ITEM_CODE = '" + theRest + "'");
                
                request.setAttribute("editRecord", record);
                
                Statement stmt1 = con.createStatement();
                ResultSet rs1 = stmt1.executeQuery("SELECT * FROM GEN_CLASS");
                request.setAttribute("genClassEdit", rs1);
                
                Statement stmt2 = con.createStatement();
                ResultSet rs2 = stmt2.executeQuery("SELECT * FROM SUB_CLASS");
                request.setAttribute("subClassEdit", rs2);
                
                request.getRequestDispatcher("i-editItem.jsp").forward(request,response);
                
                record.close();
                rs1.close();
                rs2.close();
                
                stmt.close();
                stmt1.close();
                stmt2.close();
                
            } catch (SQLException ex) {
                Logger.getLogger(ItemAction.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    public void disableUser(String user)throws SQLException
    {
        String query = "UPDATE ITEMS SET DISABLED = TRUE WHERE ITEM_CODE = ?";
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
