/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.export;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.itextpdf.text.pdf.PdfTemplate;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;


/**
 *
 * @author Vince
 */
@WebServlet(name = "ExportServlet", urlPatterns = {"/ExportServlet"})
public class ExportServlet extends HttpServlet {

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
   
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/pdf");


        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
        LocalDateTime now = LocalDateTime.now();
        String nowStr = now.format(dtf);
        Document document = new Document();
        Rectangle rect = new Rectangle(PageSize.LETTER);
        document.setPageSize(rect);

        response.setHeader("Content-Disposition", "attachment; filename=Variance Report " + nowStr + ".pdf");
        
        HttpSession session = request.getSession();
        String username = (String)session.getAttribute("username");

        Document doc = new Document();
        doc.setPageSize(PageSize.LETTER);
        
        
        try {
            PdfWriter pdfWriter = PdfWriter.getInstance(doc, response.getOutputStream());
            RightFooter right = new RightFooter();
            LeftFooter left = new LeftFooter(username);
            pdfWriter.setPageEvent(right);
            pdfWriter.setPageEvent(left);
            doc.open();

            Font f1 = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.BLACK);
            Paragraph p1 = new Paragraph();
            p1.setAlignment(Paragraph.ALIGN_CENTER);
            p1.setFont(f1);
            p1.add("Generated Report");

            Font f2 = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL, BaseColor.BLACK);
            Paragraph p2 = new Paragraph();
            p2.setFont(f2);
            p2.add("Email: hellaur");

            doc.add(p1);
            doc.add(p2);
            doc.add(new Paragraph("\n"));
            //doc.add(creds);
            doc.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        
    }

    class RightFooter extends PdfPageEventHelper {
        protected BaseFont baseFont;
        private PdfTemplate totalPages;
        private float footerTextSize = 8f;

        public RightFooter() throws DocumentException {
            super();
            try {
                baseFont = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        @Override
        public void onOpenDocument(PdfWriter writer, Document document) {
            totalPages = writer.getDirectContent().createTemplate(100, 100);
            totalPages.setBoundingBox(new Rectangle(-20, -20, 200, 200));
        }

        @Override
        public void onEndPage(PdfWriter writer, Document document) {
            PdfContentByte cb = writer.getDirectContent();
            cb.saveState();
            String text = String.format("Page %s of ", writer.getPageNumber());

            float textBase = document.bottom() - 20;
            float textSize = baseFont.getWidthPoint(text, footerTextSize);

            cb.beginText();
            cb.setFontAndSize(baseFont, footerTextSize);

            float adjust = baseFont.getWidthPoint("0", footerTextSize);
            cb.setTextMatrix(document.right() - textSize - adjust, textBase);
            cb.showText(text);
            cb.endText();
            cb.addTemplate(totalPages, document.right() - adjust, textBase);
            cb.restoreState();  
        }

        @Override
        public void onCloseDocument(PdfWriter writer, Document document) {
            totalPages.beginText();
            totalPages.setFontAndSize(baseFont, footerTextSize);
            totalPages.setTextMatrix(0, 0);
            totalPages.showText(String.valueOf(writer.getPageNumber()));
            totalPages.endText();
        }
    }
    
    class LeftFooter extends PdfPageEventHelper {
        private String email;
        protected BaseFont baseFont;
        private PdfTemplate totalPages;
        private float footerTextSize = 8f;

        public LeftFooter(String email) throws DocumentException {
            super();
            try {
                baseFont = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            } catch (Exception e) {
                e.printStackTrace();
            }
            this.email = email;
        }


        @Override
        public void onOpenDocument(PdfWriter writer, Document document) {
            totalPages = writer.getDirectContent().createTemplate(100,100);
            totalPages.setBoundingBox(new Rectangle(-20, -20, 100,100));
        }

        @Override
        public void onEndPage(PdfWriter writer, Document document){ //String username) {
            PdfContentByte cb = writer.getDirectContent();
            cb.saveState();

            LocalDateTime date = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("hh:mm a MM/dd/uuuu");
            String text = "Generated by " + email + " on " + date.format(formatter);   

            float textBase = document.bottom() - 20;
            float textSize = baseFont.getWidthPoint(text, footerTextSize);

            cb.beginText();
            cb.setFontAndSize(baseFont, footerTextSize);

            float adjust = baseFont.getWidthPoint("0", footerTextSize);
            cb.setTextMatrix(document.left(), textBase);
            cb.showText(text);
            cb.endText();
            cb.addTemplate(totalPages, document.left() + textSize, textBase);
            cb.restoreState();  
        }
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

