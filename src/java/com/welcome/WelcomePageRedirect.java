/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.welcome;

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
public class WelcomePageRedirect extends HttpServlet {

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
        
        String sql = "SELECT p.PRODUCT_CODE, p.PRODUCT_DESCRIPTION,  SUM(p.QUANTITY * p.PRODUCT_PRICE) AS TOTAL_VALUE, p.QUANTITY\n" +
"FROM PRODUCT p\n" +
"GROUP BY p.PRODUCT_CODE, p.PRODUCT_DESCRIPTION, p.QUANTITY\n" +
"ORDER BY TOTAL_VALUE DESC\n" +
"FETCH NEXT 5 ROWS ONLY";
        
        Statement statement = con.createStatement();

        
        ResultSet resultSet = statement.executeQuery(sql);
        
        String[] productDescriptions = new String[5];
        double[] totalValues = new double[5];
        int[] quantites = new int[5];

        // Initialize counters
        int index = 0;

        // Loop through the results set
        while (resultSet.next() && index < 5) {
            productDescriptions[index] = resultSet.getString(2);
            totalValues[index] = resultSet.getDouble(3);
            quantites[index] = resultSet.getInt(4);
            index++;
        }

        // Close the connection and statement
        resultSet.close();
        statement.close();

        // Fill remaining slots with "NONE" and 0 if less than 5 results
        for (int i = index; i < 5; i++) {
            productDescriptions[i] = "NONE";
            totalValues[i] = 0.0;
            quantites[i] = 0;
        }
        
        request.setAttribute("topFiveTotal", totalValues);
        request.setAttribute("topFiveDescriptions", productDescriptions);
        request.setAttribute("quantites", quantites);
        request.getRequestDispatcher("welcome.jsp").forward(request,response);
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
            Logger.getLogger(WelcomePageRedirect.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(WelcomePageRedirect.class.getName()).log(Level.SEVERE, null, ex);
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
