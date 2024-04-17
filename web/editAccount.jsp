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
        <link rel="stylesheet" href="styles/addaccount.css">
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
          <div class="dashboardbar">
            <h1 id="dashboardheader">Add Account</h1> 
        </div>
        <div style="height: 32%" class="content-container">
        <%
            if (session.getAttribute("username") != null) {
        %>
        <h1>USER: ${username}</h1>
        <%
            }
        %>
        <form action="EditAccountRedirect" method="post">
            <input type="hidden" name="originalUsername" value="<%= session.getAttribute("username")%>"/>
            <table>
                <tr>
                    <th>Username: </th><th><input type="text" name="username" value="<%= session.getAttribute("username")%>" required/></th>
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
            <button style="position: relative; right: -250px; top: 25px;" id="addacc" type="submit" onclick="return confirm('Are you sure you want to edit this account?')">Save</button>
        </form>
        <%
            if (session.getAttribute("message") != null) {
        %>
        <h4>${message}</h4>
        <%
            }
        %>
        <th><button style="position: relative; top: -10px;"class="inventory" id="return" onclick="redirectTo('AccountList')">Return</button></th>
        </div>
    </body>
</html>
