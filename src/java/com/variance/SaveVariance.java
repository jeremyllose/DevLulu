/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.variance;

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
                String action = request.getParameter("button");
                if (action.equals("VAByItem"))
                {
                    response.sendRedirect("VAByItem");
                }
                else if(action.equals("VAByBeg"))
                {
                    response.sendRedirect("VAByBeg");
                }
                else if(action.equals("VAByEnd"))
                {
                    response.sendRedirect("VAByEnd");
                }
                else if(action.equals("Save Changes"))
                {
                HttpSession session = request.getSession();
                String[] begginingValues = request.getParameterValues("beg");
                String[] endValues = request.getParameterValues("end");
                String[] itemCodes = request.getParameterValues("code");
                int start = 0;
                
                for(String itemCode : itemCodes)
                {
                    if((Integer.parseInt(begginingValues[start]) - itemBeg(itemCode)) != 0)
                    {
                        systemLogBeg((String) session.getAttribute("username"), itemCode, Integer.parseInt(begginingValues[start]), itemDescription(itemCode));
                        updateItem(itemCode);
                    }
                    editBegItem(Integer.parseInt(begginingValues[start]), itemCode);
                    
                    if((Integer.parseInt(endValues[start]) - itemEnd(itemCode)) != 0)
                    {
                        systemLogEnd((String) session.getAttribute("username"), itemCode, Integer.parseInt(endValues[start]), itemDescription(itemCode));
                        updateItem(itemCode);
                    }
                    editEndItem(Integer.parseInt(endValues[start]), itemCode);
                    
                    start++;
                }
                session.setAttribute("varianceMessage", "BEG/END has been saved");
                response.sendRedirect("VariancePageRedirect");
                }
            }
        } 
        catch (SQLException sqle)
        {
                response.sendRedirect("error.jsp");
        }
    }
    
    public void updateItem(String itemCode)throws SQLException
    {
        String query = "UPDATE ITEM SET "
                + "UPDATED= ? "
                + "WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDate = format.format(new Date(System.currentTimeMillis()));
        ps.setString(1, formattedDate);
        
        ps.setString(2, itemCode);
        ps.executeUpdate();
        ps.close();
    }
    
    public void systemLogBeg(String user, String itemCode, int count, String itemDescription)throws SQLException
    {
        String query = "INSERT INTO SYSTEMLOG (USERNAME, ITEM_CODE, \"ACTION\", \"SOURCE\", \"COUNT\", ITEM_DESCRIPTION) "
                + "VALUES (?, ?, 'BEGGINING QUANTITY CHANGE', 'VARIANCE', ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, user);
        ps.setString(2, itemCode);
        ps.setInt(3, count);
        ps.setString(4, itemDescription);
        ps.executeUpdate();
        ps.close();
    }
    
    public void systemLogEnd(String user, String itemCode, int count, String itemDescription)throws SQLException
    {
        String query = "INSERT INTO SYSTEMLOG (USERNAME, ITEM_CODE, \"ACTION\", \"SOURCE\", \"COUNT\", ITEM_DESCRIPTION) "
                + "VALUES (?, ?, 'END QUANTITY CHANGE', 'VARIANCE', ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, user);
        ps.setString(2, itemCode);
        ps.setInt(3, count);
        ps.setString(4, itemDescription);
        ps.executeUpdate();
        ps.close();
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
    
    public int itemBeg(String gc) throws SQLException
    {
        int result = 0;
        
        String query = "SELECT BEGINNING_QUANTITY FROM STOCKHISTORY WHERE ITEM_CODE= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getInt("beginning_quantity");
        }
        
        return result;
    }
    
    public int itemEnd(String gc) throws SQLException
    {
        int result = 0;
        
        String query = "SELECT END_QUANTITY FROM STOCKHISTORY WHERE ITEM_CODE= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getInt("end_quantity");
        }
        
        return result;
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
