/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.variance;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
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
public class SortingVariance extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        String[] genClasses = request.getParameterValues("gc");
        String[] subClasses = request.getParameterValues("sc");
        
        String genClassClause = "";
        if (genClasses != null && genClasses.length > 0) 
        {
            StringBuilder sb = new StringBuilder();
            for (String genClass : genClasses) 
            {
                sb.append("'").append(genClass).append("'");
                sb.append(",");
            }
            genClassClause = sb.toString().substring(0, sb.length() - 1);
        }
        else
        {
            StringBuilder sb = new StringBuilder();
            for (String genClass : retrieveAllGenIdsAsArray())
            {
                sb.append("'").append(genClass).append("'");
                sb.append(",");
            }
            genClassClause = sb.toString().substring(0, sb.length() - 1);
        }
        session.setAttribute("genSortV", genClassClause);
        
        String subClassClause = "";
        if (subClasses != null && subClasses.length > 0) 
        {
            StringBuilder sb = new StringBuilder();
            for (String subClass : subClasses) 
            {
                sb.append("'").append(subClass).append("'");
                sb.append(",");
            }
            subClassClause = sb.toString().substring(0, sb.length() - 1);
        }
        else
        {
            StringBuilder sb = new StringBuilder();
            for (String subClass : retrieveAllSubIdsAsArray())
            {
                sb.append("'").append(subClass).append("'");
                sb.append(",");
            }
            subClassClause = sb.toString().substring(0, sb.length() - 1);
        }
        session.setAttribute("subSortV", subClassClause);
        
        response.sendRedirect("VariancePageRedirect");
    }
    
    public String[] retrieveAllGenIdsAsArray() throws SQLException 
    {
        ArrayList<String> genIds = new ArrayList<String>();
        Statement stmt = con.createStatement();
        String query = "SELECT GEN_ID FROM GEN_CLASS";
        ResultSet rs = stmt.executeQuery(query);
        while(rs.next())
        {
            genIds.add(rs.getString("GEN_ID"));
        }
        return genIds.toArray(new String[genIds.size()]);
    }
    
    public String[] retrieveAllSubIdsAsArray() throws SQLException 
    {
        ArrayList<String> genIds = new ArrayList<String>();
        Statement stmt = con.createStatement();
        String query = "SELECT SUB_ID FROM SUB_CLASS";
        ResultSet rs = stmt.executeQuery(query);
        while(rs.next())
        {
            genIds.add(rs.getString("SUB_ID"));
        }
        return genIds.toArray(new String[genIds.size()]);
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
            Logger.getLogger(SortingVariance.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SortingVariance.class.getName()).log(Level.SEVERE, null, ex);
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