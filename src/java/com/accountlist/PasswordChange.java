/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.accountlist;

import com.model.EncryptDecrypt;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class PasswordChange extends HttpServlet {

    Connection con;
    int i = 3;
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
        String getUsername = request.getParameter("username");
        String getPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String page = request.getParameter("page");
        
        EncryptDecrypt crypto;
        
        if(!check(getUsername))
        {
            session.setAttribute("message", "Account Does Not Exist");
            response.sendRedirect(page);
        }
        else if(!getPassword.equals(confirmPassword))
        {
            session.setAttribute("message", "Password & Confirm Password does not match");
            response.sendRedirect(page);
        }
        else if(session.getAttribute("username") != null)
        {
            updateUser(EncryptDecrypt.encrypt(getPassword, key, cypher), getUsername);
            session.setAttribute("message", "Wait till you're password has been approved by the Admin");
            response.sendRedirect(page);
        }
        else
        {
            updateUser(EncryptDecrypt.encrypt(getPassword, key, cypher), getUsername);
            session.setAttribute("message", "Wait till you're password has been approved by the Admin");
            response.sendRedirect("login.jsp");
        }
    }
    
    public boolean check(String pkey) throws SQLException
    {
        String query = "SELECT 1 FROM LOGIN WHERE USERNAME = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, pkey);
        ResultSet resultSet = ps.executeQuery();
        
        return resultSet.next();
    }
    
    public boolean checkPassword(String pkey) throws SQLException
    {
        String query = "SELECT 1 FROM LOGIN WHERE PASSWORD = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, pkey);
        ResultSet resultSet = ps.executeQuery();
        
        
        return resultSet.next();
    }
    
    public void updateUser(String getPassword, String originalUsername)throws SQLException
    {
        String query = "UPDATE LOGIN SET FORGOTTEN = TRUE, REQUESTEDCHANGE = ? WHERE USERNAME = ?";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, getPassword);
        ps.setString(2, originalUsername);
        ps.executeUpdate();
        ps.close();
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
            Logger.getLogger(PasswordChange.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(PasswordChange.class.getName()).log(Level.SEVERE, null, ex);
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
