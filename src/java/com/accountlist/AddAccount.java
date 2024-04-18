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
import java.sql.Statement;
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
public class AddAccount extends HttpServlet {
    
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
        String getUsername = request.getParameter("username");
        String getPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String getRole = request.getParameter("role");
        HttpSession session = request.getSession();
        session.removeAttribute("message");
        try 
        {
            Statement stm = con.createStatement();
            
            if(checkUsername(getUsername))
            {
                session.setAttribute("message", "Account Already Exist");
                response.sendRedirect("add.jsp");
            }
            else if(getPassword.equals(confirmPassword) && getPassword != "")
            {
                if(getRole != null)
                {
                    int idNum = countDB();
                    while(check(idNum) == true)
                    {
                        idNum++;
                    }
                    PreparedStatement ps = con.prepareStatement("INSERT INTO LOGIN (ID, USERNAME, PASSWORD, ROLE) VALUES ("+ idNum +", '"+ getUsername +"', '"+ EncryptDecrypt.encrypt(getPassword, key, cypher) +"', '"+ getRole +"')");
                    ps.executeUpdate();
                    ps.close();
                    request.setAttribute("accountMade", "Account Created");
                    request.getRequestDispatcher("AccountList").forward(request,response);
                }
                else
                {
                    session.setAttribute("message", "Role must be Selected");
                    response.sendRedirect("add.jsp");
                }
                
            }
            else
            {
                session.setAttribute("message", "Password and Confirm Password are not the same");
                response.sendRedirect("add.jsp");
            }
        }
        
        catch (SQLException ex) 
        {
            response.sendRedirect("error.jsp");
        }
    }
    
    public int countDB() throws SQLException
    {
        Statement stmt = con.createStatement();
        String query = "select count(*) from LOGIN";
        ResultSet rs = stmt.executeQuery(query);
        rs.next();
        int count = rs.getInt(1);
        count += 1;
        return count;
    }
    
    public boolean check(int pkey) throws SQLException
    {
        String query = "SELECT 1 FROM LOGIN WHERE ID = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, pkey);
        ResultSet resultSet = ps.executeQuery();
        
        return resultSet.next();
    }
    
    public boolean checkUsername(String pkey) throws SQLException
    {
        String query = "SELECT 1 FROM LOGIN WHERE USERNAME = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, pkey);
        ResultSet resultSet = ps.executeQuery();
        
        return resultSet.next();
    }
}
