<%-- 
    Document   : passwordchange
    Created on : Apr 17, 2024, 12:34:32 AM
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
        <form action="PasswordChange" method="post">
            <%
            if (session.getAttribute("usernameForgot") != null) {
        %>
        <h1>USER: ${usernameForgot}</h1><input type="hidden" name="username" value="${usernameForgot}">
        <%
            session.removeAttribute("usernameForgot");
            }else{
                session.setAttribute("verification", "You have no Permission to Open the Password Change page without a valid username");
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
