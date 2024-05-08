/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.inventorylist;

import static com.model.UnitCost.getUnitCost;
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
public class AddItem extends HttpServlet {

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
        
        int getItemMarkup = Integer.parseInt(request.getParameter("itemMarkup"));
        String getItemDescription = request.getParameter("itemDescription");
        String getUOM = request.getParameter("uom");
        float getTransferCost = Float.parseFloat(request.getParameter("transferCost"));
        String getGC = request.getParameter("gc");
        String getSC = request.getParameter("sc");
        String getVat = request.getParameter("vat");
        int getQty = Integer.parseInt(request.getParameter("qty"));
        int getMax = Integer.parseInt(request.getParameter("max"));
        int getReorder = Integer.parseInt(request.getParameter("rod"));
        boolean isChecked = getVat != null && getVat.equals("on");
        
        try
        {
            if(genName(getGC).equals("Food Item") && !subName(getSC).equals("Rawmats"))
            {
                session.setAttribute("existing", "Food Item Should be paired with Rawmats");
                request.getRequestDispatcher("AddItemPageRedirect").forward(request,response);
            }
            else if(genName(getGC).equals("Supplies") && subName(getSC).equals("Rawmats"))
            {
                session.setAttribute("existing", "Supplies Should NOT be paired with Rawmats");
                request.getRequestDispatcher("AddItemPageRedirect").forward(request,response);
            }
            else
            {
                String baseName = genCode(getGC) + "-" + subCode(getSC) + "-";
                int start = 1;
                String formattedLength = String.format("%04d", start);
                String name = baseName + formattedLength;
                while (check(name))
                {
                    start++;
                    formattedLength = String.format("%04d", start);
                    name = baseName + formattedLength;
                }
                int markup = 0;
                if(isChecked)
                {
                    markup = getItemMarkup;
                }
                
                addItem(name, countDB(), getItemDescription, abbriviation(name), getGC, getSC, markup);
                addPricing(name, getUOM, getTransferCost, isChecked, getItemMarkup);
                addTransaction(name, getQty);
                addInventory(name, getQty, getMax, getReorder);
                addStockHistory(name, getQty);
                systemLog((String) session.getAttribute("username"), name, getItemDescription);
            }
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(AddItem.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("itemMessage", "Item Added");
        request.getRequestDispatcher("ItemList").forward(request,response);
    }
    
    public void systemLog(String user, String itemCode, String itemDescription)throws SQLException
    {
        String query = "INSERT INTO SYSTEMLOG (USERNAME, ITEM_CODE, \"ACTION\", \"SOURCE\", ITEM_DESCRIPTION)"
                + " VALUES (?, ?, 'ADDED', 'INVENTORY', ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, user);
        ps.setString(2, itemCode);
        ps.setString(3, itemDescription);
        ps.executeUpdate();
        ps.close();
    }
    
    public void addItem(String itemCode, int itemNum, String itemDesc, String itemAbb, String genId, String subId, int markup)throws SQLException
    {
        String query = "INSERT INTO ITEM (ITEM_CODE, ITEM_NUM, ITEM_DESCRIPTION, ABBREVIATION, GEN_ID, SUB_ID, MARKUP_COST)"
                + " VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, itemCode);
        ps.setInt(2, itemNum);
        ps.setString(3, itemDesc);
        ps.setString(4, itemAbb);
        ps.setString(5, genId);
        ps.setString(6, subId);
        ps.setInt(7, markup);
        ps.executeUpdate();
        ps.close();
    }
    
    public void addPricing(String itemCode, String unitId, float transferCost, boolean vat, int markup)throws SQLException
    {
        String query = "INSERT INTO PRICING (ITEM_CODE, UNIT_ID, TRANSFER_COST, VAT, UNIT_PRICE) "
                + "VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, itemCode);
        ps.setString(2, unitId);
        ps.setFloat(3, transferCost);
        ps.setBoolean(4, vat);
        ps.setFloat(5, getUnitCost(vat, transferCost, markup));
        ps.executeUpdate();
        ps.close();
    }
    
    public void addTransaction(String itemCode, int quantity)throws SQLException
    {
        String query = "INSERT INTO TRANSACTIONS (ITEM_CODE, DELIVERY, OTHERADDS, SOLD, WASTE, OTHERSUBS) "
                + "VALUES (?, 0, 0, 0, 0, 0)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, itemCode);
        ps.executeUpdate();
        ps.close();
    }
    
    public void addInventory(String itemCode, int quantity, int max, int reorder)throws SQLException
    {
        String query = "INSERT INTO INVENTORY (ITEM_CODE, QUANTITY, MAX_QUANTITY, SUGGESTED_FORECAST, REORDER_QUANTITY) "
                + "VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, itemCode);
        ps.setInt(2, quantity);
        ps.setInt(3, max);
        ps.setInt(4, max-quantity);
        ps.setInt(5, reorder);
        ps.executeUpdate();
        ps.close();
    }
    
    public void addStockHistory(String itemCode, int quantity)throws SQLException
    {
        String query = "INSERT INTO STOCKHISTORY (ITEM_CODE, BEGINNING_QUANTITY, END_QUANTITY) "
                + "VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, itemCode);
        ps.setInt(2, quantity);
        ps.setInt(3, quantity);
        ps.executeUpdate();
        ps.close();
    }
    
    public String abbriviation(String pkey)
    {
        String firstThreeLetters = pkey.substring(0, 2) + pkey.charAt(3);
        return firstThreeLetters;
    }
    
    public boolean check(String pkey) throws SQLException
    {
        String query = "SELECT 1 FROM ITEM WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, pkey);
        ResultSet resultSet = ps.executeQuery();
        
        return resultSet.next();
    }
    
    public String genName(String gc) throws SQLException
    {
        String result = null;
        
        String query = "SELECT GEN_NAME FROM GEN_CLASS WHERE GEN_ID= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getString("gen_name");
        }
        
        return result;
    }
    
    public String genCode(String gc) throws SQLException
    {
        String result = null;
        
        String query = "SELECT CODE FROM GEN_CLASS WHERE GEN_ID= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getString("code");
        }
        
        return result;
    }
    
    public String subName(String gc) throws SQLException
    {
        String result = null;
        String firstWord = null;
        
        String query = "SELECT SUB_NAME FROM SUB_CLASS WHERE SUB_ID= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getString("sub_name");
            String arr[] = result.split(" ", 2);
            firstWord = arr[0];
        }
        
        return firstWord;
    }
    
    public String subCode(String gc) throws SQLException
    {
        String result = null;
        
        String query = "SELECT CODE FROM SUB_CLASS WHERE SUB_ID= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getString("code");
        }
        
        return result;
    }
    
    public static boolean characters(String str) 
    {
        for (int i = 0; i < 3; i++) 
        {
            char c = str.charAt(i);
            if (!Character.isLetter(c))
            {
                return true;
            }
        }
        return false;
    }
    
    public void unitPrice(boolean vat, String itemCode, float transferCost)throws SQLException
    {
        float percent = transferCost * (0.01f * 10.7f);
        float unit = transferCost - percent;
        if(vat == true)
        {
            String query = "UPDATE ITEMS SET UNIT_PRICE = ? WHERE ITEM_CODE = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setFloat(1, unit);
            ps.setString(2, itemCode);
            ps.executeUpdate();
        }
        
    }
    
    public int countDB() throws SQLException
    {
        Statement stmt = con.createStatement();
        String query = "select count(*) from ITEM";
        ResultSet rs = stmt.executeQuery(query);
        rs.next();
        int count = rs.getInt(1);
        count += 1;
        return count;
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
