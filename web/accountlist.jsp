<%-- 
    Document   : accountlist
    Created on : Jan 28, 2024, 1:22:13 PM
    Author     : jeremy
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
        <div class="dashboardbar">
             <h1 id="dashboardheader">Account List</h1>
         </div>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("userRole").equals("Manager") ) {
                session.setAttribute("verification", "You have no Permission to Open the Account List");
                response.sendRedirect("welcome.jsp");
            }
        %>
         
        <br> 
        <br> 
        <br>
        <form action="add.jsp">
             <button type="submit" class="account" id="addmember">
                 <img src="photos/plus.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span style="margin-right: 5px;">Add Account</span></button>
         </form>
        <div class="container">
            
        <table>
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Role</th>
                    <th>Action</th>
                    <th>Password Forgotten</th>
                </tr>
            </thead>
            
            <tbody>
                
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
                                <%
                                    if (results.getBoolean("forgotten") == true)
                                    {
                                %>
                                <td>
                                    <form action="EnablePassword" method="post">
                                        <input type="hidden" name="username" value="<%= results.getString("username") %>">
                                        <button type="submit" onclick="return confirm('Are you sure you want to enable this users password?')">Show password</button>
                                    </form>
                                </td>
                                <%
                                    }
                                %>
			</tr>	
		<%	}
		%>
                
            </tbody>
        </table>
    </div>
</body>
</html>
