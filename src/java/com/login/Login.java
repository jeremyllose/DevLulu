/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.login;

import org.apache.commons.codec.binary.Base64;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletConfig;
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
            try {	
                    Class.forName(config.getInitParameter("driver"));
                    
                    String username = config.getInitParameter("username");
                    String password = config.getInitParameter("password");
                    String url = config.getInitParameter("url");
                    
                    con = DriverManager.getConnection(url, username, password);
                    
                    String pkey = config.getInitParameter("publicKey");
                    byte[] key = pkey.getBytes();
                    setKey(key);
                    setCypher(config.getInitParameter("cypher"));
                    
            } catch (SQLException sqle){
                    System.out.println("SQLException error occured - " 
                            + sqle.getMessage());
            } catch (ClassNotFoundException nfe){
                    System.out.println("ClassNotFoundException error occured - " 
                    + nfe.getMessage());
            }
    }
    
    public byte[] getKey() 
    {
        return key;
    }

    public void setKey(byte[] key) 
    {
        this.key = key;
    }
    
    public String getCypher() 
    {
        return cypher;
    }

    public void setCypher(String cypher) 
    {
        this.cypher = cypher;
    }
    
    public  String decrypt(String codeDecrypt)
    {
        String decryptedString = null;
        try{
            Cipher cipher = Cipher.getInstance(getCypher());
            final SecretKeySpec secretKey = new SecretKeySpec(getKey(), "AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            decryptedString = new String(cipher.doFinal(Base64.decodeBase64(codeDecrypt)));
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return decryptedString;
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String sql = "select * from login where username=?";
        
        String uname = request.getParameter("uname");
        String pass = request.getParameter("pass");
        HttpSession session = request.getSession();
        
        if (i <= 0 || (session.getAttribute("attempts") == null)) {
            i = 3;
        }
        
        try {
            
            PreparedStatement st = con.prepareStatement(sql);
            
            st.setString(1, uname);
            //st.setString(2, pass);
            
            ResultSet rs = st.executeQuery();
            if(rs.next() && pass.equals(decrypt(rs.getString("password"))))
            {
                
                session.setAttribute("username", uname);
                //redirect to dashboard 
                response.sendRedirect("welcome.jsp");
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
