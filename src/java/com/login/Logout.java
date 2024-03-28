/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.login;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Cesar
 */
public class Logout extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object username = session.getAttribute("rememberUsername");
        Object password = session.getAttribute("rememberPassword");
        session.removeAttribute("username");
        session.invalidate();
        HttpSession sessionRemember = request.getSession();
        sessionRemember.setAttribute("rememberUsername", username);
        sessionRemember.setAttribute("rememberPassword", password);
        response.sendRedirect("login.jsp");
    }
}
