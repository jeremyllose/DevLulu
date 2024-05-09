<%-- 
    Document   : editAccount
    Created on : Apr 16, 2024, 10:18:01 PM
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
        <link rel="stylesheet" href="styles/editaccount.css">
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
          <div class="dashboardbar">
            <h1 id="dashboardheader">Add Account</h1> 
        </div>
        <div class="content-container">
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
                <th>Old Password: </th><th><input type="password" name="oldPassword" placeholder="Password" required/></th>
            </tr>
            <tr>
                <th>New Password: </th><th><input type="password" name="password" placeholder="Password" required/></th>
            </tr>
            <tr>
                <th>Confirm Password: </th><th><input type="password" name="confirmPassword" placeholder="Confirm Password" required/></th>
            </tr>
        </table>
            <button id="save" type="submit" onclick="return confirm('Are you sure you want to edit this account?')">Save</button>
            </form>
            <%
            if (session.getAttribute("message") != null) {
        %>
        <h4 class="info">${message}</h4>
        <%
            }
        %>
        <th><button class="inventory" id="return" onclick="redirectTo('AccountList')">Return</button></th>
        </div>
    </body>
</html>
