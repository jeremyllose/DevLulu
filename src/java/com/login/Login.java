/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.login;

import com.model.EncryptDecrypt;
import java.io.IOException;
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
public class Login extends HttpServlet {
    
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
                    String url = config.getInitParameter("url");
                    
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
        
        String sql = "select * from login where username=?";
        
        String uname = request.getParameter("uname");
        String pass = request.getParameter("pass");
        
        EncryptDecrypt crypto;
        
        HttpSession session = request.getSession();
        
        if (i <= 0 || (session.getAttribute("attempts") == null)) {
            i = 3;
        }
        
        try {
            
            PreparedStatement st = con.prepareStatement(sql);
            
            st.setString(1, uname);
            
            ResultSet rs = st.executeQuery();
            
            //Only Accepts users with non disabled accounts
            if(rs.next() && pass.equals(EncryptDecrypt.decrypt(rs.getString("password"), key, cypher)) && !rs.getBoolean("DISABLED"))
            {
                session.setAttribute("userRole", rs.getString("role"));
                session.setAttribute("username", uname);
                //redirect to dashboard 
                response.sendRedirect("welcome.jsp");
            }
            else if(rs.getBoolean("DISABLED"))
            {
                session.setAttribute("message", "This account has been Disabled by the Owner or Assistant Manager");
                response.sendRedirect("login.jsp");
            }
            else
            {
                i--;
                session.setAttribute("attempts", i);
                session.setAttribute("message", "Attempts Left: " + i);
                request.setAttribute("attemptsLeft", i);
                //No username or password
                response.sendRedirect("login.jsp");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
