<%-- 
    Document   : test
    Created on : Feb 2, 2024, 6:25:34 AM
    Author     : Cesar
--%>

<%@page import="java.sql.ResultSet"%>
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

            if (session.getAttribute("userRole").equals("Manager") ) {
                session.setAttribute("verification", "You have no Permission to Open the Account List");
                response.sendRedirect("welcome.jsp");
            }
        %>
        <h1>Account List</h1>
        <form action="addUser.jsp" method="post">
            <input type="submit" value="Add User"/>
        </form>
        
        <table border="1" align="center">
		<tr>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Role</th>
                    <th>Action</th>
		</tr>
		
                <%
                    ResultSet results = (ResultSet)request.getAttribute("results");
			while (results.next()) { %>
			<tr>
                                <td><%=results.getString("username") %></td>
                                <td><%=results.getString("password") %></td>
                                <td><%=results.getString("role") %></td>
                                <td>
                                    <form action="EditUser" method="post">
                                        <input type="hidden" name="password" value="<%= results.getString("password") %>">
                                        <input type="hidden" name="role" value="<%= results.getString("role") %>">
                                        <button type="submit">Edit</button>
                                    </form>
                                    <form action="DisableUser" method="post">
                                        <input type="hidden" name="id" value="<%= results.getString("id") %>">
                                        <button type="submit" onclick="return confirm('Are you sure you want to disable this user account?')">Disable</button>
                                    </form>
                                </td>
			</tr>	
		<%	}
		%>
	</table>
    </body>
</html>
