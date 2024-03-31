/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.accountlist;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Cesar
 */
public class AccountList extends HttpServlet {
    
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
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try 
        {
            if (con != null) 
            {
                Statement stmt = con.createStatement();
                //Only gets the Accounts where DISABLED IS FALSE
                ResultSet records = stmt.executeQuery("SELECT * FROM LOGIN WHERE DISABLED = FALSE ORDER BY ID");
                
                //gives all the records to the Accountlist
                request.setAttribute("results", records);
                request.getRequestDispatcher("accountlist.jsp").forward(request,response);
            }
        } 
        catch (SQLException sqle)
        {
                response.sendRedirect("error.jsp");
        } 
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try 
        {
            if (con != null) 
            {
                Statement stmt = con.createStatement();
                //Only gets the Accounts where DISABLED IS FALSE
                ResultSet records = stmt.executeQuery("SELECT * FROM LOGIN WHERE DISABLED = FALSE ORDER BY ID");
                
                //gives all the records to the Accountlist
                request.setAttribute("results", records);
                request.getRequestDispatcher("accountlist.jsp").forward(request,response);
            }
        } 
        catch (SQLException sqle)
        {
                response.sendRedirect("error.jsp");
        } 
    }

}
