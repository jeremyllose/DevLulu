<%-- 
    Document   : editAccount
    Created on : Apr 16, 2024, 10:18:01 PM
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
            if (session.getAttribute("username") != null) {
        %>
        <h1>USER: ${username}</h1>
        <%
            }
        %>
        <form action="EditAccountRedirect" method="post">
            <input type="hidden" name="originalUsername" value="<%= session.getAttribute("username") %>"/>
        <table>
            <tr>
                <th>Username: </th><th><input type="text" name="username" value="<%= session.getAttribute("username") %>" required/></th>
            </tr>
            <tr>
                <th>Old Password: </th><th><input type="password" name="oldPassword" required/></th>
            </tr>
            <tr>
                <th>Password: </th><th><input type="password" name="password" required/></th>
            </tr>
            <tr>
                <th>Confirm Password: </th><th><input type="password" name="confirmPassword" required/></th>
            </tr>
        </table>
            <button type="submit" onclick="return confirm('Are you sure you want to edit this account?')">Save</button>
            </form>
            <%
            if (session.getAttribute("message") != null) {
        %>
        <h4>${message}</h4>
        <%
            }
        %>
    </body>
</html>
