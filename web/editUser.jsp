<%-- 
    Document   : editUser
    Created on : Apr 13, 2024, 12:01:52 AM
    Author     : Cesar
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="commons.jsp"%>
<!DOCTYPE html>
<html>
    <head>
         <meta charset="UTF-8">
         
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/accountlist.css">
        <title>Account List</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <%
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

                if (session.getAttribute("username") == null) {
                    response.sendRedirect("login.jsp");
                }
            %>
        <h1>Hello World!</h1>
        <%
            String username = (String) request.getAttribute("username");
            String password = (String) request.getAttribute("password");
            String role = (String) request.getAttribute("role");
        %>
        <form action="UserEdited" method="post">
            <input type="hidden" name="originalUsername" value="<%= username %>"/>
        <table>
            <tr>
                <th>Username: </th><th><input type="text" name="username" value="<%= username %>" required/></th>
                <th>Password: </th><th><input type="text" name="password" value="<%= password %>" required/></th>
            </tr>
            <tr>
                Role
            </tr>
            <tr>
                <%
                    if(role.equals("Owner")){
                %>
                <th><label>Owner</label> <input type="radio" name="role" value="Owner" checked required></th>
                <%
                    }
                    else{
                %>
                <th><label>Owner</label> <input type="radio" name="role" value="Owner" required></th>
                <%
                    }
                %>
                <%
                    if(role.equals("Assistant Manager")){
                %>
                <th><label>Assistant Manager</label> <input type="radio" name="role" value="Assistant Manager" checked required></th>
                <%
                    }
                    else{
                %>
                <th><label>Assistant Manager</label> <input type="radio" name="role" value="Assistant Manager" required></th>
                <%
                    }
                %>
                <%
                    if(role.equals("Manager")){
                %>
                <th><label>Manager</label> <input type="radio" name="role" value="Manager" checked required></th>
                <%
                    }
                    else{
                %>
                <th><label>Manager</label> <input type="radio" name="role" value="Manager" required></th>
                <%
                    }
                %>
            </tr>
        </table>
            <button type="submit" onclick="return confirm('Are you sure you want to edit this user account?')">Save</button>
            </form>
    </body>
</html>