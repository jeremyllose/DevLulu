/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.product;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
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
public class EditProductRedirect extends HttpServlet {

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
        String productCode = (String) session.getAttribute("productCode");
        
        Statement stmt = con.createStatement();
        ResultSet record = stmt.executeQuery("SELECT * FROM PRODUCT WHERE PRODUCT_CODE = '"+ productCode +"'");
        request.setAttribute("editProduct", record);
        
        Statement stmt2 = con.createStatement();
        ResultSet record2 = stmt2.executeQuery("SELECT * FROM BILLOFMATERIALS "
                + "INNER JOIN ITEM ON BILLOFMATERIALS.ITEM_CODE = ITEM.ITEM_CODE "
                + "INNER JOIN SUB_CLASS ON ITEM.SUB_ID = SUB_CLASS.SUB_ID "
                + "WHERE PRODUCT_CODE = '"+ productCode +"' ORDER BY ITEM_NUM");
        request.setAttribute("productInfo", record2);
        
        Statement stmt3 = con.createStatement();
        ResultSet record3 = stmt3.executeQuery("SELECT i.*, sc.SUB_NAME FROM ITEM i "
                + "LEFT JOIN BILLOFMATERIALS bom ON i.ITEM_CODE = bom.ITEM_CODE AND bom.PRODUCT_CODE = '"+ productCode +"' "
                + "LEFT JOIN SUB_CLASS sc ON i.SUB_ID = sc.SUB_ID "
                + "INNER JOIN GEN_CLASS gc ON i.GEN_ID = gc.GEN_ID "
                + "WHERE gc.GEN_NAME = 'Food Item' AND bom.ITEM_CODE IS NULL");
        request.setAttribute("moreItems", record3);
        
        request.getRequestDispatcher("p-editProduct.jsp").forward(request,response);
        
        record.close();
        record2.close();
        
        stmt.close();
        stmt2.close();
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
            Logger.getLogger(EditProductRedirect.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(EditProductRedirect.class.getName()).log(Level.SEVERE, null, ex);
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
