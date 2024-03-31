/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.forgot;

import static com.model.EncryptDecrypt.decrypt;
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
public class ForgotPassword extends HttpServlet {

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

        } catch (SQLException sqle) {
            System.out.println("SQLException error occured - "
                    + sqle.getMessage());
        } catch (ClassNotFoundException nfe) {
            System.out.println("ClassNotFoundException error occured - "
                    + nfe.getMessage());
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        String getUsername = request.getParameter("forgot-email");


        if (getUsername == null || getUsername.isEmpty()) {
 
            response.sendRedirect("login.jsp");
            return; 
        }
        
        if (usernameExist(getUsername) == 0) {
            session.setAttribute("message", "User DOES NOT Exist");
            response.sendRedirect("login.jsp");
        }
        if (userEnabled(getUsername) == 1) {
            session.setAttribute("message", "Password: " + getUserPassword(getUsername));
            passwordReceived(getUsername);
            response.sendRedirect("login.jsp");
        } else {
            forgotten(getUsername);
            session.setAttribute("message", "Please wait for a few minutes before getting confirmation from a higher up");
            response.sendRedirect("login.jsp");
        }
    }

    public String getUserPassword(String username) throws SQLException {
        String password = "";
        String query = "SELECT * FROM LOGIN WHERE USERNAME = ?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, username);
        ResultSet result = ps.executeQuery();
        if (result.next()) {
            password = decrypt(result.getString("password"), key, cypher);
        }
        return password;
    }

    public int usernameExist(String username) throws SQLException {
        int count = 0;
        String query = "SELECT COUNT(*) AS username_exists FROM LOGIN WHERE USERNAME = ?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, username);
        ResultSet result = ps.executeQuery();
        if (result.next()) {
            count = result.getInt("username_exists");
        }
        return count;
    }

    public int userEnabled(String username) throws SQLException {
        int count = 0;
        String query = "SELECT COUNT(*) AS username_exists FROM LOGIN WHERE USERNAME = ? AND ENABLE = TRUE";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, username);
        ResultSet result = ps.executeQuery();
        if (result.next()) {
            count = result.getInt("username_exists");
        }
        return count;
    }

    public void forgotten(String username) throws SQLException {
        int count = 0;
        String query = "UPDATE LOGIN SET FORGOTTEN = TRUE WHERE USERNAME = ?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, username);
        ps.executeUpdate();
        ps.close();
    }

    public void passwordReceived(String username) throws SQLException {
        int count = 0;
        String query = "UPDATE LOGIN SET FORGOTTEN = FALSE, ENABLE = FALSE WHERE USERNAME = ?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, username);
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
            Logger.getLogger(ForgotPassword.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ForgotPassword.class.getName()).log(Level.SEVERE, null, ex);
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
