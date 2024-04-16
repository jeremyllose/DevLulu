/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.imports;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.poi.ss.usermodel.*;
/**
 *
 * @author Vince
 */

@MultipartConfig
@WebServlet(name = "UploadServlet", urlPatterns = {"/UploadServlet"})
public class UploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("file");
        Workbook workbook = WorkbookFactory.create(filePart.getInputStream());
        
        try {
            // Get the sheets from the workbook
            Sheet sheetItem = workbook.getSheet("Item");
            Sheet sheetPricing = workbook.getSheet("Pricing");
            Sheet sheetTransaction = workbook.getSheet("Transaction");
            Sheet sheetInventory = workbook.getSheet("Inventory");
            Sheet sheetStockHistory = workbook.getSheet("Stockhistory_Tables");

            // Set attributes for each sheet
            request.setAttribute("Item", sheetItem);
            request.setAttribute("Pricing", sheetPricing);
            request.setAttribute("Transaction", sheetTransaction);
            request.setAttribute("Inventory", sheetInventory);
            request.setAttribute("Stockhistory_Tables", sheetStockHistory);

            // Forward the request to the InsertDataServlet for database insertion
            request.getRequestDispatcher("/InsertDataServlet").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Handle error appropriately
            response.sendRedirect("error.jsp");
        } finally {
            workbook.close();
        }
    }
}