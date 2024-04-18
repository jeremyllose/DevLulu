<%-- 
    Document   : passchange
    Created on : Apr 17, 2024, 2:02:45 AM
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
                <th>Password: </th><th><input type="password" name="password" required/></th>
            </tr>
            <tr>
                <th>Confirm Password: </th><th><input type="password" name="confirmPassword" required/></th>
            </tr>
        </table>
        <input type="hidden" name="page" value="passchange.jsp">
            <button type="submit" onclick="return confirm('Password will be Confirmed by Admin before it can be used')">Save</button>
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
