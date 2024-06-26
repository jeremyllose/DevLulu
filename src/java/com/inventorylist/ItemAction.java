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
            if(itemIds != null)
            {
                for (String itemId : itemIds) 
                {
                    try 
                    {
                        disableUser(itemId);
                        systemLog((String) session.getAttribute("username"), itemId, itemDescription(itemId));
                    }
                    catch (SQLException ex) 
                    {
                        Logger.getLogger(ItemAction.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
            session.setAttribute("itemMessage", "Items Disabled");
            response.sendRedirect("ItemList");
        }
        else if(action.equals("sorting"))
        {
            response.sendRedirect("AscendDescend");
        }
        else if(action.equals("sortingT"))
        {
            response.sendRedirect("ADTransfer");
        }
        else if(action.equals("sortingU"))
        {
            response.sendRedirect("ADUnit");
        }
        else if(action.substring(0, action.indexOf(" ")).equals("enable"))
        {
            String arr[] = action.split(" ", 2);
            String theRest = arr[1];
            try 
            {
                enableUser(theRest);
                systemLogEnable((String) session.getAttribute("username"), theRest, itemDescription(theRest));
            } 
            catch (SQLException ex) 
            {
                Logger.getLogger(ItemAction.class.getName()).log(Level.SEVERE, null, ex);
            }
            session.setAttribute("itemMessage", "Item "+ theRest+ " is Enabled");
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
                ResultSet record = stmt.executeQuery("SELECT * FROM ITEM "
                        + "INNER JOIN PRICING ON ITEM.ITEM_CODE = PRICING.ITEM_CODE "
                        + "INNER JOIN GEN_CLASS ON ITEM.GEN_ID = GEN_CLASS.GEN_ID "
                        + "INNER JOIN SUB_CLASS ON ITEM.SUB_ID = SUB_CLASS.SUB_ID "
                        + "INNER JOIN UNIT_CLASS ON PRICING.UNIT_ID = UNIT_CLASS.UNIT_ID "
                        + "WHERE ITEM.ITEM_CODE = '"+ theRest +"'");
                
                request.setAttribute("editRecord", record);
                
                Statement stmt1 = con.createStatement();
                ResultSet rs1 = stmt1.executeQuery("SELECT * FROM GEN_CLASS");
                request.setAttribute("genClassEdit", rs1);
                
                Statement stmt2 = con.createStatement();
                ResultSet rs2 = stmt2.executeQuery("SELECT * FROM SUB_CLASS");
                request.setAttribute("subClassEdit", rs2);
                
                Statement stmt3 = con.createStatement();
                ResultSet rs3 = stmt3.executeQuery("SELECT * FROM UNIT_CLASS");
                request.setAttribute("unitClassEdit", rs3);
                
                request.getRequestDispatcher("i-editItem.jsp").forward(request,response);
                
                record.close();
                rs1.close();
                rs2.close();
                rs3.close();
                
                stmt.close();
                stmt1.close();
                stmt2.close();
                stmt3.close();
                
            } catch (SQLException ex) {
                Logger.getLogger(ItemAction.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    public String itemDescription(String gc) throws SQLException
    {
        String result = null;
        
        String query = "SELECT ITEM_DESCRIPTION FROM ITEM WHERE ITEM_CODE= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getString("item_description");
        }
        
        return result;
    }
    
    public void systemLog(String user, String itemCode, String itemDescription)throws SQLException
    {
        String query = "INSERT INTO SYSTEMLOG (USERNAME, ITEM_CODE, \"ACTION\", \"SOURCE\", ITEM_DESCRIPTION)"
                + " VALUES (?, ?, 'DISABLED', 'INVENTORY', ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, user);
        ps.setString(2, itemCode);
        ps.setString(3, itemDescription);
        ps.executeUpdate();
        ps.close();
    }
    
    public void systemLogEnable(String user, String itemCode, String itemDescription)throws SQLException
    {
        String query = "INSERT INTO SYSTEMLOG (USERNAME, ITEM_CODE, \"ACTION\", \"SOURCE\", ITEM_DESCRIPTION)"
                + " VALUES (?, ?, 'ENABLED', 'INVENTORY', ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, user);
        ps.setString(2, itemCode);
        ps.setString(3, itemDescription);
        ps.executeUpdate();
        ps.close();
    }
    
    public void disableUser(String user)throws SQLException
    {
        String query = "UPDATE ITEM SET DISABLED = TRUE WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, user);
        ps.executeUpdate();
    }
    
    public void enableUser(String user)throws SQLException
    {
        String query = "UPDATE ITEM SET DISABLED = FALSE WHERE ITEM_CODE = ?";
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
