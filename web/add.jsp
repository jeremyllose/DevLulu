<%-- 
    Document   : add
    Created on : Feb 2, 2024, 11:58:31 AM
    Author     : Cesar
--%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="commons.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styles/addaccount.css">
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <div class="dashboardbar">
            <h1 id="dashboardheader">Add Account</h1> 
        </div>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <%
            if (session.getAttribute("userRole").equals("Manager") ) {
                session.setAttribute("verification", "You have no Permission to Open the Account List");
                response.sendRedirect("403 Forbidden Page.jsp");
            }
        %>
        <div class="content-container">
            <form action="AddAccount" method="post">
                <table> 
                    <tr>
                        <th>Username</th><th><input type="text" name="username"/></th>
                    </tr>
                    <tr>
                        <th>Password</th><th><input type="password" name="password"/></th>
                    </tr>
                    <tr>
                        <th>Confirm Password</th><th><input type="password" name="confirmPassword"/></th>
                    </tr>
                    <tr>
                        <th>Role:</th>
                    </tr>
                    <tr>
                        <%
                            if (session.getAttribute("userRole").equals("Owner") ) 
                            {
                        %>
                        <th><label for="owner">Owner</label> <input type="radio" id="owner" name="role" value="Owner"></th>
                        <%
                            }
                        %>
                        <th><label for="manager">Manager</label> <input type="radio" id="manager" name="role" value="Manager"></th>
                    </tr>
                    <tr>
                    <th><input id="addacc" type="submit" value="Add Account"/></th>
                    </tr>
                </table>
                        <%
            if (session.getAttribute("message") != null) {
        %>
        <h4>${message}</h4>
        <%
            }
        %>
        </form>
        <th><button class="inventory" id="return" onclick="redirectTo('AccountList')">Return</button></th>
        </div>
    
</body>
</html>
