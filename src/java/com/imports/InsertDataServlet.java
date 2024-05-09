/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.imports;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

/**
 *
 * @author Vince
 */
@WebServlet(name = "InsertDataServlet", urlPatterns = {"/InsertDataServlet"})
public class InsertDataServlet extends HttpServlet {

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
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    try {
       
        Sheet sheetItem = (Sheet) request.getAttribute("Item");
        Sheet sheetTransaction = (Sheet) request.getAttribute("Transaction");
        Sheet sheetPricing = (Sheet) request.getAttribute("Pricing");
        Sheet sheetStockHistory = (Sheet) request.getAttribute("Stock History");
        Sheet sheetInventory = (Sheet) request.getAttribute("Inventory");
      
        processItemSheet(sheetItem);
        processTransactionSheet(sheetTransaction);
        processPricingSheet(sheetPricing);
        processStockHistorySheet(sheetStockHistory);
        processInventorySheet(sheetInventory);
        
        
        response.sendRedirect("ItemList");

        
        
    } catch (SQLException e) {
        e.printStackTrace();
        handleSQLException(e, response);
    }

}

private void processItemSheet(Sheet sheet) throws SQLException {
        PreparedStatement pstmt = con.prepareStatement("INSERT INTO ITEM (ITEM_CODE, ITEM_DESCRIPTION, ABBREVIATION, GEN_ID, SUB_ID, MARKUP_COST) VALUES (?,?,?,?,?,?)");


    for (Row row : sheet) {
        if (row.getRowNum()  > 1) {
            pstmt.setString(1, row.getCell(0).toString());
            pstmt.setInt(2, (int) Float.parseFloat(row.getCell(1).toString()));
            pstmt.setString(3, row.getCell(2).toString());
            pstmt.setString(4, row.getCell(3).toString());
            pstmt.setString(5, row.getCell(4).toString());
            pstmt.setString(6, row.getCell(5).toString());
            executeInsertIgnore(pstmt);
        }
    }

    pstmt.close();
    con.commit();
}

private void processPricingSheet(Sheet sheet) throws SQLException {
      PreparedStatement pstmt = con.prepareStatement("INSERT INTO PRICING (ITEM_CODE, UNIT_ID, TRANSFER_COST, VAT) VALUES (?,?,?,?)");

    for (Row row : sheet) {
        if (row.getRowNum()  > 1) {
            pstmt.setString(1, row.getCell(0).toString());
            pstmt.setString(2, row.getCell(1).toString());
            pstmt.setBigDecimal(3, new BigDecimal(row.getCell(2).toString()));
            pstmt.setBoolean(4, Boolean.parseBoolean(row.getCell(3).toString()));
            pstmt.setBigDecimal(5, new BigDecimal(row.getCell(4).toString()));
             executeInsertIgnore(pstmt);
        }
    }

    pstmt.close();
    con.commit();
}

private void processTransactionSheet(Sheet sheet) throws SQLException {
        PreparedStatement pstmt = con.prepareStatement("INSERT INTO TRANSACTIONS (ITEM_CODE, DELIVERY, OTHERADDS, SOLD, WASTE, OTHERSUBS) VALUES (?,?,?,?,?,?)");

    for (Row row : sheet) {
        if (row.getRowNum()  > 1) {
            pstmt.setString(1, row.getCell(0).toString());
            for (int i = 1; i <= 5; i++) {
                pstmt.setInt(i + 1, (int) Float.parseFloat(row.getCell(i).toString()));
            }
            executeInsertIgnore(pstmt);
        }
    }

    pstmt.close();
    con.commit();
}

private void processInventorySheet(Sheet sheet) throws SQLException {
       PreparedStatement pstmt = con.prepareStatement("INSERT INTO INVENTORY (ITEM_CODE, QUANTITY, MAX_QUANTITY, REORDER_QUANTITY) VALUES (?,?,?,?)");

    for (Row row : sheet) {
        if (row.getRowNum()  > 1) {
            pstmt.setString(1, row.getCell(0).toString());
            for (int i = 1; i <= 4; i++) {
                pstmt.setInt(i + 1, (int) Float.parseFloat(row.getCell(i).toString()));
            }
            executeInsertIgnore(pstmt);
        }
    }

    pstmt.close();
    con.commit();
}

private void processStockHistorySheet(Sheet sheet) throws SQLException {
     PreparedStatement pstmt = con.prepareStatement("INSERT INTO STOCKHISTORY (ITEM_CODE, BEGINNING_QUANTITY, END_QUANTITY) VALUES (?,?,?)");

    for (Row row : sheet) {
        if (row.getRowNum()  > 1) {
            pstmt.setString(1, row.getCell(0).toString());
            for (int i = 1; i <= 2; i++) {
                pstmt.setInt(i + 1, (int) Float.parseFloat(row.getCell(i).toString()));
            }
             executeInsertIgnore(pstmt);
        }
    }

    pstmt.close();
    con.commit();
}
private void executeInsertIgnore(PreparedStatement pstmt) throws SQLException {
    try {
        pstmt.executeUpdate();
    } catch (SQLException e) {
        
        if (e.getSQLState().equals("23505")) {
            System.out.println("Duplicate key error ignored: " + e.getMessage());
        } else {
            throw e; 
        }
    }
}

private void handleSQLException(SQLException e, HttpServletResponse response) throws IOException {
    e.printStackTrace();

    response.sendRedirect("500 Internal Server Error Page.jsp");
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