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
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Vince
 */
@WebServlet(name = "DeliveryExcelServlet", urlPatterns = {"/DeliveryExcelServlet"})
public class DeliveryExcelServlet extends HttpServlet {

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
        
            // Use the database connection to retrieve data
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM TRANSACTIONS");

            // Create Excel workbook
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Delivery Report");

            // Get ResultSet metadata to obtain column names
        ResultSetMetaData metaData = rs.getMetaData();
        int columnCount = metaData.getColumnCount();

        // Write column names as the first row in Excel sheet
        Row headerRow = sheet.createRow(3); // Assuming you want the column names to start from row 3

        String[] columnNames = {"itemCode", "Delivery", "Other Adds"};

        for (int i = 0; i < columnNames.length; i++) {
        headerRow.createCell(i).setCellValue(columnNames[i]);
        }

        // Write login name and date/time of generation as header information
        Row infoRow = sheet.createRow(0);
        infoRow.createCell(0).setCellValue("Generated By:");
        infoRow.createCell(1).setCellValue(loginName);
        infoRow = sheet.createRow(1);
        infoRow.createCell(0).setCellValue("Date/Time Generated:");
        infoRow.createCell(1).setCellValue(formattedDateTime);

        // Write data to Excel sheet
        int rowNum = 4; // Start writing data from row 3
        while (rs.next()) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(rs.getString("ITEM_CODE"));
            row.createCell(1).setCellValue(rs.getString("DELIVERY"));
            row.createCell(2).setCellValue(rs.getString("OTHERADDS"));
          
       
           
            // Add more columns as needed
        }

        // Set response headers
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=Delivery Report.xlsx");

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
