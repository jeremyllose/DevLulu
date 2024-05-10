/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.product;

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
import javax.servlet.http.HttpSession;

/**
 *
 * @author Cesar
 */
public class ProductAction extends HttpServlet {
    
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
        String action = request.getParameter("button");
        
        if (action.equals("disable")) 
        {
            String[] itemIds = request.getParameterValues("selectProduct");
            if(itemIds != null)
            {
                for (String itemId : itemIds) 
                {
                    disableUser(itemId);
                    systemLog((String) session.getAttribute("username"), itemId, itemDescription(itemId));
                }
            }
            session.setAttribute("productMessage", "Items Successfully Disabled");
            response.sendRedirect("ProductRedirect");
        }
        else if (action.equals("PByPrice")) 
        {
            response.sendRedirect("PByPrice");
        }
        else if (action.equals("PByQuantity")) 
        {
            response.sendRedirect("PByQuantity");
        }
        else if (action.equals("Enable")) 
        {
            String product = request.getParameter("enable");
            
            enableUser(product);
            
            session.setAttribute("productMessage", "Item Successfully Enabled");
            systemLogEnable((String) session.getAttribute("username"), product, itemDescription(product));
            response.sendRedirect("ProductRedirect");
        }
        else if (action.equals("save")) 
        {
            String[] products = request.getParameterValues("products");
            String[] quantites = request.getParameterValues("qty");
            int start = 0;
            
            for (String product : products)
            {
                int quantity = Integer.parseInt(quantites[start]) - previousQuantity(product);
                
                updateProduct(product , Integer.parseInt(quantites[start]));
                
                if(quantity != 0)
                {
                String itemCodes[] = productItems(product, countItems(product));
                int sold[] = productQuantity(product, countItems(product));
                
                int startAgain = 0;
                for (String itemCode : itemCodes)
                {
                    int newSold = soldQuantity(itemCode) + sold[startAgain];
                    updateWastes(newSold, itemCode);
                    startAgain++;
                }
                systemLogSave((String) session.getAttribute("username"), product, itemDescription(product), quantity);
                }
                
                start++;
            }
            
            session.setAttribute("productMessage", "Item Quantities Saved");
            response.sendRedirect("ProductRedirect");
        }
        else if(action.substring(0, action.indexOf(" ")).equals("edit"))
        {
            String arr[] = action.split(" ", 2);
            String theRest = arr[1];
            session.setAttribute("productCode", theRest);
            response.sendRedirect("EditProductRedirect");
        }
    }
    
    public void updateWastes(int sold, String itemCode)throws SQLException
    {
        String query = "UPDATE TRANSACTIONS SET SOLD = ? WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, sold);
        ps.setString(2, itemCode);
        ps.executeUpdate();
        ps.close();
    }
    
    public String itemDescription(String gc) throws SQLException
    {
        String result = null;
        
        String query = "SELECT PRODUCT_DESCRIPTION FROM PRODUCT WHERE PRODUCT_CODE= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getString("PRODUCT_DESCRIPTION");
        }
        
        return result;
    }
    
    public String[] productItems(String gc, int count) throws SQLException
    {
        String result[] = new String[count];
        
        String query = "SELECT * FROM BILLOFMATERIALS WHERE PRODUCT_CODE= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        int i = 0;
        while (resultSet.next()) {
            result[i] = resultSet.getString(2);
            i++;
        }
        
        return result;
    }
    
    public int[] productQuantity(String gc, int count) throws SQLException
    {
        int result[] = new int[count];
        
        String query = "SELECT * FROM BILLOFMATERIALS WHERE PRODUCT_CODE= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        int i = 0;
        while (resultSet.next()) {
            result[i] = resultSet.getInt("QUANTITY");
            i++;
        }
        
        return result;
    }
    
    public int previousQuantity(String gc) throws SQLException
    {
        int result = 0;
        
        String query = "SELECT * FROM PRODUCT WHERE PRODUCT_CODE= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getInt("QUANTITY");
        }
        
        return result;
    }
    
    public int countItems(String gc) throws SQLException
    {
        String query = "SELECT COUNT(*) FROM BILLOFMATERIALS WHERE PRODUCT_CODE= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        resultSet.next();
        int count = resultSet.getInt(1);
        count += 1;
        return count;
    }
    
    public int soldQuantity(String gc) throws SQLException
    {
        int result = 0;
        
        String query = "SELECT * FROM TRANSACTIONS WHERE ITEM_CODE= ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, gc);
        ResultSet resultSet = ps.executeQuery();
        if (resultSet.next()) {
            result = resultSet.getInt("SOLD");
        }
        
        return result;
    }
    
    public void systemLogSave(String user, String itemCode, String itemDescription, int count)throws SQLException
    {
        String query = "INSERT INTO SYSTEMLOG (USERNAME, ITEM_CODE, \"ACTION\", \"SOURCE\", ITEM_DESCRIPTION, \"COUNT\")"
                + " VALUES (?, ?, 'SAVED', 'RECIPE', ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, user);
        ps.setString(2, itemCode);
        ps.setString(3, itemDescription);
        ps.setInt(4, count);
        ps.executeUpdate();
        ps.close();
    }
    
    public void systemLog(String user, String itemCode, String itemDescription)throws SQLException
    {
        String query = "INSERT INTO SYSTEMLOG (USERNAME, ITEM_CODE, \"ACTION\", \"SOURCE\", ITEM_DESCRIPTION)"
                + " VALUES (?, ?, 'DISABLED', 'RECIPE', ?)";
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
                + " VALUES (?, ?, 'ENABLED', 'RECIPE', ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, user);
        ps.setString(2, itemCode);
        ps.setString(3, itemDescription);
        ps.executeUpdate();
        ps.close();
    }
    
    public void disableUser(String product)throws SQLException
    {
        String query = "UPDATE PRODUCT SET DISABLED = TRUE WHERE PRODUCT_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, product);
        ps.executeUpdate();
    }
    
    public void updateProduct(String product, int quantity)throws SQLException
    {
        String query = "UPDATE PRODUCT SET QUANTITY = ? WHERE PRODUCT_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, quantity);
        ps.setString(2, product);
        ps.executeUpdate();
    }
    
    public void enableUser(String user)throws SQLException
    {
        String query = "UPDATE PRODUCT SET DISABLED = FALSE WHERE PRODUCT_CODE = ?";
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ProductAction.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ProductAction.class.getName()).log(Level.SEVERE, null, ex);
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
