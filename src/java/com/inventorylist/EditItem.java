/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.inventorylist;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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
public class EditItem extends HttpServlet {

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
        try {
            HttpSession session = request.getSession();
            int getItemMarkup = Integer.parseInt(request.getParameter("markup"));
            String getItemCode = request.getParameter("itemCode");
            String getItemDescription = request.getParameter("itemDescription");
            float getTransferCost = Float.parseFloat(request.getParameter("transferCost"));
            String getGC = request.getParameter("gc");
            String getSC = request.getParameter("sc");
            String getUOM = request.getParameter("uom");
            String getVat = request.getParameter("vat");
            boolean isChecked = getVat != null && getVat.equals("on");
            
            updateItem(getItemDescription, getGC, getSC, getItemCode, getItemMarkup);
            updatePrice(isChecked, getItemCode, getTransferCost, getUOM, getItemMarkup);
            systemLog((String) session.getAttribute("username"), getItemCode, getItemDescription);
            
            request.setAttribute("itemMessage", "Item "+ getItemDescription +" Was Edited");
            request.getRequestDispatcher("ItemList").forward(request,response);
        } catch (SQLException ex) {
            Logger.getLogger(EditItem.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void systemLog(String user, String itemCode, String itemDescription)throws SQLException
    {
        String query = "INSERT INTO SYSTEMLOG (USERNAME, ITEM_CODE, \"ACTION\", \"SOURCE\", ITEM_DESCRIPTION)"
                + " VALUES (?, ?, 'EDITED', 'INVENTORY', ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, user);
        ps.setString(2, itemCode);
        ps.setString(3, itemDescription);
        ps.executeUpdate();
        ps.close();
    }
    
    public void updateItem(String desc, String genId, String subId, String itemCode, int markup)throws SQLException
    {
        String query = "UPDATE ITEM SET "
                + "ITEM_DESCRIPTION = ?, "
                + "MARKUP_COST = ?, "
                + "GEN_ID= ?, "
                + "SUB_ID= ?, "
                + "UPDATED= ? "
                + "WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, desc);
         ps.setInt(2, markup);
        ps.setString(3, genId);
        ps.setString(4, subId);
        
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDate = format.format(new Date(System.currentTimeMillis()));
        ps.setString(5, formattedDate);
        
        ps.setString(6, itemCode);
        ps.executeUpdate();
        ps.close();
    }
    
    public void updatePrice(boolean vat, String itemCode, float transferCost, String unitId, int markup)throws SQLException
    {
        float percent = transferCost * (0.01f * (float) markup);
        float unit = transferCost + percent;
        
        String query = "UPDATE PRICING SET  "
                + "UNIT_PRICE = ?, "
                + "TRANSFER_COST = ?, "
                + "UNIT_ID = ?, "
                + "VAT = ? "
                + "WHERE ITEM_CODE = ?";
        PreparedStatement ps = con.prepareStatement(query);
        
        if(vat == true)
        {
            ps.setFloat(1, (float) (Math.ceil(unit * Math.pow(10, 2)) / Math.pow(10, 2)));
        }
        else
        {
            ps.setFloat(1, (float) (Math.ceil(transferCost * Math.pow(10, 2)) / Math.pow(10, 2)));
        }
        
        ps.setFloat(2, (float) (Math.ceil(transferCost * Math.pow(10, 2)) / Math.pow(10, 2)));
        ps.setString(3, unitId);
        ps.setBoolean(4, vat);
        ps.setString(5, itemCode);
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
