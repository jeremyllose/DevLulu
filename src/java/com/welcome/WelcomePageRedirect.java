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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
        
        String sql = "SELECT ITEM.ITEM_CODE, ITEM.ITEM_NUM, ITEM.ITEM_DESCRIPTION, PRICING.TRANSFER_COST, PRICING.UNIT_PRICE, TRANSACTIONS.DELIVERY, TRANSACTIONS.SOLD, TRANSACTIONS.OTHERADDS, (UNIT_PRICE * SOLD) AS TOTAL FROM ITEM\n" +
"INNER JOIN INVENTORY ON ITEM.ITEM_CODE = INVENTORY.ITEM_CODE\n" +
"INNER JOIN TRANSACTIONS ON ITEM.ITEM_CODE = TRANSACTIONS.ITEM_CODE\n" +
"INNER JOIN PRICING ON ITEM.ITEM_CODE = PRICING.ITEM_CODE\n" +
"INNER JOIN STOCKHISTORY ON ITEM.ITEM_CODE = STOCKHISTORY.ITEM_CODE\n" +
"INNER JOIN GEN_CLASS ON ITEM.GEN_ID = GEN_CLASS.GEN_ID\n" +
"INNER JOIN SUB_CLASS ON ITEM.SUB_ID = SUB_CLASS.SUB_ID\n" +
"INNER JOIN UNIT_CLASS ON PRICING.UNIT_ID = UNIT_CLASS.UNIT_ID\n" +
"WHERE ITEM.DISABLED = FALSE\n" +
"ORDER BY TOTAL DESC\n" +
"FETCH NEXT 5 ROWS ONLY";
        
        LocalDate today = LocalDate.now();
        LocalDate fiveDaysBefore = today.minusDays(5);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = fiveDaysBefore.format(formatter);
        
        String sql2 = "SELECT MAX(DATE_COLUMN) AS latest_update, SUM(COUNT) AS total_sum FROM SYSTEMLOG WHERE DATE_COLUMN BETWEEN '"+formattedDate+"' AND CURRENT_DATE AND SOURCE = 'USAGE/Sold Column' GROUP BY DATE_COLUMN";
        
        Statement statement = con.createStatement();
        Statement statement2 = con.createStatement();

        
        ResultSet resultSet = statement.executeQuery(sql);
        ResultSet resultSet2 = statement2.executeQuery(sql2);
        
        String[] productDescriptions = new String[5];
        double[] totalValues = new double[5];
        int[] quantites = new int[5];

        // Initialize counters
        int index = 0;

        // Loop through the results set
        while (resultSet.next() && index < 5) {
            productDescriptions[index] = resultSet.getString(3);
            totalValues[index] = resultSet.getDouble(5);
            quantites[index] = resultSet.getInt(7);
            index++;
        }
        
        int index2 = 0;
        
        String[] dates = new String[5];
        int[] solds = new int[5];

        // Loop through the results set
        while (resultSet2.next() && index2 < 5) {
            dates[index2] = resultSet2.getString(1);
            solds[index2] = resultSet2.getInt(2);
            index2++;
        }

        // Close the connection and statement
        resultSet.close();
        resultSet2.close();
        statement.close();
        statement2.close();

        // Fill remaining slots with "NONE" and 0 if less than 5 results
        for (int i = index; i < 5; i++) {
            productDescriptions[i] = "NONE";
            totalValues[i] = 0.0;
            quantites[i] = 0;
        }
        int day = 1;
        for (int i = index2; i < 5; i++) {
            dates[i] = today.plusDays(day).format(formatter);
            solds[i] = 0;
            day++;
        }
        
        request.setAttribute("dates", dates);
        request.setAttribute("solds", solds);
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
