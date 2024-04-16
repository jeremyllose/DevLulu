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
import java.util.ArrayList;
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
public class ProductRedirect extends HttpServlet {

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
                HttpSession session = request.getSession();
                Statement stmt = con.createStatement();
                
                String sort = (String) session.getAttribute("pSort");
                if(sort == null)
                {
                    sort = "";
                    session.setAttribute("pSort", sort);
                }
                
                String genClassClause = (String) session.getAttribute("productItemSort");
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
                
                ResultSet records = stmt.executeQuery("SELECT p.PRODUCT_CODE, p.PRODUCT_DESCRIPTION, p.PRODUCT_PRICE, p.QUANTITY, p.DISABLED\n" +
"FROM PRODUCT p\n" +
"INNER JOIN BILLOFMATERIALS bom ON p.PRODUCT_CODE = bom.PRODUCT_CODE\n" +
"WHERE (bom.ITEM_CODE IN (" + genClassClause + ")) " + sort);
                
                request.setAttribute("product", records);
                request.getRequestDispatcher("product.jsp").forward(request,response);
                
                records.close();
                stmt.close();
            }
        } 
        catch (SQLException sqle)
        {
                response.sendRedirect("error.jsp");
        } 
    }
    
    public String[] retrieveAllGenIdsAsArray() throws SQLException 
    {
        ArrayList<String> genIds = new ArrayList<String>();
        Statement stmt = con.createStatement();
        String query = "SELECT ITEM_CODE FROM ITEM";
        ResultSet rs = stmt.executeQuery(query);
        while(rs.next())
        {
            genIds.add(rs.getString("ITEM_CODE"));
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
