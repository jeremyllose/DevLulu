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
        // Process the workbook (read data from Excel file)
        // Example:
        Sheet sheet = workbook.getSheetAt(0);
        request.setAttribute("sheet", sheet);
        for (Row row : sheet) {
            for (Cell cell : row) {
                // Process cell contents
                System.out.print(cell.toString() + "\t");
            }
            System.out.println();
        }
        workbook.close();
        // Forward the request to another servlet for database insertion
        request.getRequestDispatcher("/InsertDataServlet").forward(request, response);
    }
}
