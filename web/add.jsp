<%-- 
    Document   : add
    Created on : Feb 2, 2024, 11:58:31 AM
    Author     : Cesar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <h1>Add Account</h1>
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
                    <th>Role</th>
                </tr>
                <tr>
                    <th><label for="owner">Owner</label> <input type="radio" id="owner" name="role" value="Owner"></th>
                        
                    <th><label for="assistantManager">Assistant Manager</label> <input type="radio" id="assistantManager" name="role" value="Assistant Manager"></th>
                        
                    <th><label for="manager">Manager</label> <input type="radio" id="manager" name="role" value="Manager"></th>
                </tr>
                <tr>
                    <th><input type="submit" value="Add Account"/></th>
                </tr>
            </table>
        </form>
    </body>
</html>
