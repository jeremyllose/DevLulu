<%-- 
    Document   : passchange
    Created on : Apr 17, 2024, 2:02:45 AM
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
        <link rel="stylesheet" href="styles/passchange.css">
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
          <div class="dashboardbar">
            <h1 id="dashboardheader">Edit Account</h1> 
        </div>
        <div class="content-container">
        <form action="PasswordChange" method="post">
            <%
            if (session.getAttribute("username") != null) {
        %>
        <h1>USER: ${username}</h1><input type="hidden" name="username" value="${username}">
        <%
            }
            else{
                session.setAttribute("verification", "You have no Permission to Open the Password Change page without a valid session");
                response.sendRedirect("403 Forbidden Page.jsp");
            }
        %>
        <table>
            <tr>
                <th>Password: </th><th><input type="password" name="password" placeholder="Password" required/></th>
            </tr>
            <tr>
                <th>Confirm Password: </th><th><input type="password" name="confirmPassword" placeholder="Confirm Password" required/></th>
            </tr>
        </table>
        <input type="hidden" name="page" value="passchange.jsp">
            <button id="save" type="submit" onclick="return confirm('Password will be Confirmed by Admin before it can be used')">Save</button>
            </form>
            <%
            if (session.getAttribute("message") != null) {
        %>
        <h4>${message}</h4>
        <%
            }
        %>
        <th><button class="inventory" id="return" onclick="redirectTo('WelcomePageRedirect')">Return</button></th>
        </div>
    </body>
</html>
