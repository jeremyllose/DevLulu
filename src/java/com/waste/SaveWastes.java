/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.waste;

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
public class SaveWastes extends HttpServlet {

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
        String action = request.getParameter("button");
                if (action.equals("WByItem"))
                {
                    response.sendRedirect("WByItem");
                }
                else if (action.equals("WBySold"))
                {
                    response.sendRedirect("WBySold");
                }
                else if (action.equals("WByWaste"))
                {
                    response.sendRedirect("WByWaste");
                }
                else if (action.equals("WByOther"))
                {
                    response.sendRedirect("WByOther");
                }
                else if(action.equals("save"))
                {
        HttpSession session = request.getSession();
        String[] solds = request.getParameterValues("sold");
        String[] wastes = request.getParameterValues("waste");
        String[] othersubs = request.getParameterValues("othersubs");
        String[] items = request.getParameterValues("items");
        int start = 0;
        
//        Statement stmt = con.createStatement();
//        String query = "SELECT * FROM ITEM\n" +
//                "INNER JOIN INVENTORY ON ITEM.ITEM_CODE = INVENTORY.ITEM_CODE\n" +
//                "INNER JOIN TRANSACTIONS ON ITEM.ITEM_CODE = TRANSACTIONS.ITEM_CODE\n" +
//                "INNER JOIN PRICING ON ITEM.ITEM_CODE = PRICING.ITEM_CODE\n" +
//                "INNER JOIN STOCKHISTORY ON ITEM.ITEM_CODE = STOCKHISTORY.ITEM_CODE\n" +
//                "WHERE ITEM.DISABLED = FALSE ORDER BY ITEM_NUM";
//        ResultSet rs = stmt.executeQuery(query);
        for(String item : items)
        {
            int sold = Integer.parseInt(solds[start]) - previousSold(item);
            if(sold != 0)
            {
                systemLogSold((String) session.getAttribute("username"), item, sold, itemDescription(item));
                updateItem(item);
            }
            int waste = Integer.parseInt(wastes[start]) - previousWaste(item);
            if(waste != 0)
            {
                systemLogWaste((String) session.getAttribute("username"), item, waste, itemDescription(item));
                updateItem(item);
            }
            int subs = Integer.parseInt(othersubs[start]) - previousSubs(item);
            if(subs != 0)
            {
                systemLogOthers((String) session.getAttribute("username"), item, subs, itemDescription(item));
                updateItem(item);
            }
            
            int endQuantity = endQuantity(item) - (sold + waste + subs);
            
            updateEndItem(endQuantity, item);
            updateQuantity(endQuantity, item);
            updateWastes(Integer.parseInt(solds[start]), Integer.parseInt(wastes[start]), Integer.parseInt(othersubs[start]), item);
            
            start++;
        }
        session.setAttribute("wasteMessage", "Waste has been saved");
        response.sendRedirect("WasteRedirect");
                }
//        rs.close();
//        stmt.close();
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
    
    public void systemLogSold(String user, String itemCode, int count, String itemDescription)throws SQLException
    {
        String query = "INSERT INTO SYSTEMLOG (USERNAME, ITEM_CODE, \"ACTION\", \"SOURCE\", \"COUNT\", ITEM_DESCRIPTION) "
                + "VALUES (?, ?, 'STOCK DECREASE', 'USAGE/Sold Column', ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, user);
        ps.setString(2, itemCode);
        ps.setInt(3, count);
        ps.setString(4, itemDescription);
        ps.executeUpdate();
        ps.close();
    }
    
    public void systemLogWaste(String user, String itemCode, int count, String itemDescription)throws SQLException
    {
        String query = "INSERT INTO SYSTEMLOG (USERNAME, ITEM_CODE, \"ACTION\", \"SOURCE\", \"COUNT\", ITEM_DESCRIPTION) "
                + "VALUES (?, ?, 'STOCK DECREASE', 'USAGE/Waste Column', ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, user);
        ps.setString(2, itemCode);
        ps.setInt(3, count);
        ps.setString(4, itemDescription);
        ps.executeUpdate();
        ps.close();
    }
    
    public void systemLogOthers(String user, String itemCode, int count, String itemDescription)throws SQLException
    {
        String query = "INSERT INTO SYSTEMLOG (USERNAME, ITEM_CODE, \"ACTION\", \"SOURCE\", \"COUNT\", ITEM_DESCRIPTION) "
                + "VALUES (?, ?, 'STOCK DECREASE', 'USAGE/Other Subtraction Column', ?, ?)";
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
    
    public int previousSold(String itemCode) throws SQLException
    {
        int result = 0;
        
        String query = "SELECT SOLD FROM TRANSACTIONS WHERE ITEM_CODE=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, itemCode);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getInt("sold");
        }
        
        return result;
    }
    
    public int previousWaste(String itemCode) throws SQLException
    {
        int result = 0;
        
        String query = "SELECT WASTE FROM TRANSACTIONS WHERE ITEM_CODE=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, itemCode);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getInt("waste");
        }
        
        return result;
    }
    
    public int previousSubs(String itemCode) throws SQLException
    {
        int result = 0;
        
        String query = "SELECT OTHERSUBS FROM TRANSACTIONS WHERE ITEM_CODE=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, itemCode);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getInt("othersubs");
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
    
    public void updateWastes(int sold, int waste, int subs, String itemCode)throws SQLException
    {
        String query = "UPDATE TRANSACTIONS SET SOLD = ?, WASTE = ?, OTHERSUBS = ? WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, sold);
        ps.setInt(2, waste);
        ps.setInt(3, subs);
        ps.setString(4, itemCode);
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
            Logger.getLogger(SaveWastes.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SaveWastes.class.getName()).log(Level.SEVERE, null, ex);
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
