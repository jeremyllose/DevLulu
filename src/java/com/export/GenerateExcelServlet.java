/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.export;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
/**
 *
 * @author Vince
 */
@WebServlet(name = "ItemExcelServlet", urlPatterns = {"/ItemExcelServlet"})
public class GenerateExcelServlet extends HttpServlet {

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
     
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     
    }

  
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        // Get login name from session or request attributes
        String loginName = (String) request.getSession().getAttribute("username");

        // Get current date and time
        LocalDateTime currentTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = currentTime.format(formatter);

        // Use the database connection to retrieve data for inventory report
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM ITEM");

        // Create Excel workbook
        Workbook workbook = new XSSFWorkbook();
        Sheet inventorySheet = workbook.createSheet("Item");

        // Get ResultSet metadata to obtain column names for inventory report
        ResultSetMetaData metaData = rs.getMetaData();
        int columnCount = metaData.getColumnCount();

        // Write column names as the first row in Excel sheet for inventory report
        Row headerRow = inventorySheet.createRow(2); // Assuming you want the column names to start from row 0

        String[] columnNames = {"ITEM_CODE", "ITEM_DESCRIPTION", "ABBREVIATION", "GEN_ID", "SUB_ID", "MARKUP_COST"};

        for (int i = 0; i < columnNames.length; i++) {
            headerRow.createCell(i).setCellValue(columnNames[i]);
        }

        // Write login name and date/time of generation as header information for inventory report
        Row infoRow = inventorySheet.createRow(0);
        infoRow.createCell(0).setCellValue("Generated By:");
        infoRow.createCell(1).setCellValue(loginName);
        infoRow = inventorySheet.createRow(1);
        infoRow.createCell(0).setCellValue("Date/Time Generated:");
        infoRow.createCell(1).setCellValue(formattedDateTime);
        for (int i = 0; i < columnNames.length; i++) {
        inventorySheet.autoSizeColumn(i);
        }
        // Write data to Excel sheet for inventory report
        int rowNum = 3; // Start writing data from row 1
        while (rs.next()) {
            Row row = inventorySheet.createRow(rowNum++);
            row.createCell(0).setCellValue(rs.getString("ITEM_CODE"));
            row.createCell(1).setCellValue(rs.getString("ITEM_DESCRIPTION"));
            row.createCell(2).setCellValue(rs.getString("ABBREVIATION"));
            row.createCell(3).setCellValue(rs.getString("GEN_ID"));
            row.createCell(4).setCellValue(rs.getString("SUB_ID"));
            row.createCell(5).setCellValue(rs.getString("MARKUP_COST"));
            // Add more columns as needed

        for (int i = 0; i < columnNames.length; i++) {
        inventorySheet.autoSizeColumn(i);
        }
        }

        // Use the database connection to retrieve data for delivery report
        Statement stmtTxn = con.createStatement();
        ResultSet rsTxn = stmtTxn.executeQuery("SELECT * FROM TRANSACTIONS");

        // Create sheet for delivery report
        Sheet deliverySheet = workbook.createSheet("Transaction");

        // Get ResultSet metadata to obtain column names for delivery report
        ResultSetMetaData metaDataTxn = rsTxn.getMetaData();
        int columnCountTxn = metaDataTxn.getColumnCount();

        // Write column names as the first row in Excel sheet for delivery report
        Row headerRowTxn = deliverySheet.createRow(2); // Assuming you want the column names to start from row 0

        String[] columnNamesTxn = {"ITEM_CODE", "DELIVERY", "OTHERADDS","SOLD", "WASTE","OTHERSUBS"};

        for (int i = 0; i < columnNamesTxn.length; i++) {
            headerRowTxn.createCell(i).setCellValue(columnNamesTxn[i]);
        }

        // Write login name and date/time of generation as header information for delivery report
        Row infoRowTxn = deliverySheet.createRow(0);
        infoRowTxn.createCell(0).setCellValue("Generated By:");
        infoRowTxn.createCell(1).setCellValue(loginName);
        infoRowTxn = deliverySheet.createRow(1);
        infoRowTxn.createCell(0).setCellValue("Date/Time Generated:");
        infoRowTxn.createCell(1).setCellValue(formattedDateTime);
        for (int i = 0; i < columnNames.length; i++) {
        deliverySheet.autoSizeColumn(i);
        }

        // Write data to Excel sheet for delivery report
        int rowNumTxn = 3; // Start writing data from row 1
        while (rsTxn.next()) {
            Row row = deliverySheet.createRow(rowNumTxn++);
            row.createCell(0).setCellValue(rsTxn.getString("ITEM_CODE"));
            row.createCell(1).setCellValue(rsTxn.getString("DELIVERY"));
            row.createCell(2).setCellValue(rsTxn.getString("OTHERADDS"));
            row.createCell(3).setCellValue(rsTxn.getString("SOLD"));
            row.createCell(4).setCellValue(rsTxn.getString("WASTE"));
            row.createCell(5).setCellValue(rsTxn.getString("OTHERSUBS"));
            // Add more columns as needed

        for (int i = 0; i < columnNames.length; i++) {
        deliverySheet.autoSizeColumn(i);
        }
        }

        // Use the database connection to retrieve data for Pricing report
        Statement stmtPrc = con.createStatement();
        ResultSet rsPrc = stmtPrc.executeQuery("SELECT * FROM PRICING");

        // Create sheet for delivery report
        Sheet PricingSheet = workbook.createSheet("Pricing");

        // Get ResultSet metadata to obtain column names for Pricing report
        ResultSetMetaData metaDataPrc = rsPrc.getMetaData();
        int columnCountPrc = metaDataPrc.getColumnCount();

        // Write column names as the first row in Excel sheet for delivery report
        Row headerRowPrc = PricingSheet.createRow(2); // Assuming you want the column names to start from row 0

        String[] columnNamesPrc = {"ITEM_CODE", "UNIT_ID", "TRANSFER_COST", "VAT"};

        for (int i = 0; i < columnNamesPrc.length; i++) {
            headerRowPrc.createCell(i).setCellValue(columnNamesPrc[i]);
        }

        // Write login name and date/time of generation as header information for delivery report
        Row infoRowPrc = PricingSheet.createRow(0);
        infoRowPrc.createCell(0).setCellValue("Generated By:");
        infoRowPrc.createCell(1).setCellValue(loginName);
        infoRowPrc = PricingSheet.createRow(1);
        infoRowPrc.createCell(0).setCellValue("Date/Time Generated:");
        infoRowPrc.createCell(1).setCellValue(formattedDateTime);
        for (int i = 0; i < columnNames.length; i++) {
        PricingSheet.autoSizeColumn(i);
        }

        // Write data to Excel sheet for Pricing report
        int rowNumPrc = 3; // Start writing data from row 1
        while (rsPrc.next()) {
            Row row = PricingSheet.createRow(rowNumPrc++);
            row.createCell(0).setCellValue(rsPrc.getString("ITEM_CODE"));
            row.createCell(1).setCellValue(rsPrc.getString("UNIT_ID"));
            row.createCell(2).setCellValue(rsPrc.getString("TRANSFER_COST"));
            row.createCell(3).setCellValue(rsPrc.getString("VAT"));
            // Add more columns as needed

        for (int i = 0; i < columnNames.length; i++) {
        PricingSheet.autoSizeColumn(i);
        }
        }




  // Use the database connection to retrieve data for Pricing report
        Statement stmtStk = con.createStatement();
        ResultSet rsStk = stmtStk.executeQuery("SELECT * FROM STOCKHISTORY");

        // Create sheet for delivery report
        Sheet StockSheet = workbook.createSheet("StockHistory");

        // Get ResultSet metadata to obtain column names for Pricing report
        ResultSetMetaData metaDataStk = rsStk.getMetaData();
        int columnCountStk = metaDataStk.getColumnCount();

        // Write column names as the first row in Excel sheet for delivery report
        Row headerRowStk = StockSheet.createRow(2); // Assuming you want the column names to start from row 0

        String[] columnNamesStk = {"ITEM_CODE", "BEGINNING_QUANTITY", "END_QUANTITY"};

        for (int i = 0; i < columnNamesStk.length; i++) {
            headerRowStk.createCell(i).setCellValue(columnNamesStk[i]);
        }

        // Write login name and date/time of generation as header information for delivery report
        Row infoRowStk = StockSheet.createRow(0);
        infoRowStk.createCell(0).setCellValue("Generated By:");
        infoRowStk.createCell(1).setCellValue(loginName);
        infoRowStk = StockSheet.createRow(1);
        infoRowStk.createCell(0).setCellValue("Date/Time Generated:");
        infoRowStk.createCell(1).setCellValue(formattedDateTime);
        for (int i = 0; i < columnNames.length; i++) {
        StockSheet.autoSizeColumn(i);
        }

        // Write data to Excel sheet for Pricing report
        int rowNumStk = 3; // Start writing data from row 1
        while (rsStk.next()) {
            Row row = StockSheet.createRow(rowNumStk++);
            row.createCell(0).setCellValue(rsStk.getString("ITEM_CODE"));
            row.createCell(1).setCellValue(rsStk.getString("BEGINNING_QUANTITY"));
            row.createCell(2).setCellValue(rsStk.getString("END_QUANTITY"));
            
            // Add more columns as needed

        for (int i = 0; i < columnNames.length; i++) {
        StockSheet.autoSizeColumn(i);
        }
        }


// Use the database connection to retrieve data for Pricing report
        Statement stmtInt = con.createStatement();
        ResultSet rsInt = stmtInt.executeQuery("SELECT * FROM INVENTORY");

        // Create sheet for delivery report
        Sheet InventorySheet = workbook.createSheet("Inventory");

        // Get ResultSet metadata to obtain column names for Pricing report
        ResultSetMetaData metaDataInt = rsInt.getMetaData();
        int columnCountInt = metaDataInt.getColumnCount();

        // Write column names as the first row in Excel sheet for delivery report
        Row headerRowInt = InventorySheet.createRow(2); // Assuming you want the column names to start from row 0

        String[] columnNamesInt = {"ITEM_CODE", "QUANTITY", "MAX_QUANTITY","REORDER_QUANTITY"};

        for (int i = 0; i < columnNamesInt.length; i++) {
            headerRowInt.createCell(i).setCellValue(columnNamesInt[i]);
        }

        // Write login name and date/time of generation as header information for delivery report
        Row infoRowInt = InventorySheet.createRow(0);
        infoRowInt.createCell(0).setCellValue("Generated By:");
        infoRowInt.createCell(1).setCellValue(loginName);
        infoRowInt = InventorySheet.createRow(1);
        infoRowInt.createCell(0).setCellValue("Date/Time Generated:");
        infoRowInt.createCell(1).setCellValue(formattedDateTime);
        for (int i = 0; i < columnNames.length; i++) {
        InventorySheet.autoSizeColumn(i);
        }

        // Write data to Excel sheet for Pricing report
        int rowNumInt = 3; // Start writing data from row 1
        while (rsInt.next()) {
            Row row = InventorySheet.createRow(rowNumInt++);
            row.createCell(0).setCellValue(rsInt.getString("ITEM_CODE"));
            row.createCell(1).setCellValue(rsInt.getString("QUANTITY"));
            row.createCell(2).setCellValue(rsInt.getString("MAX_QUANTITY"));
            row.createCell(2).setCellValue(rsInt.getString("REORDER_QUANTITY"));
            
            // Add more columns as needed

        for (int i = 0; i < columnNames.length; i++) {
        InventorySheet.autoSizeColumn(i);
        }
        }
        // Set response headers
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=General Reports.xlsx");

        // Write workbook to response output stream
        workbook.write(response.getOutputStream());
        workbook.close();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}


    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
