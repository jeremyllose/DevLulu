<%-- 
    Document   : activtylog
    Created on : May 5, 2024, 10:01:41 PM
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
        <h1>Hello World!</h1>
        <table>
                        <thead>
                            <tr>
                                <th>USER</th>
                                <th>Item Code</th>
                                <th>Item Description</th>
                                <th>Action</th>
                                <th>Source</th>
                                <th>Count</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ResultSet results = (ResultSet) request.getAttribute("itemRecords");
                                while (results.next()) {%>
                            <tr>
                                <td><%=results.getString("username")%></td>
                                <td><%=results.getString("item_code")%></td>
                                <td><%=results.getString("item_description")%></td>
                                <td><%=results.getString("action")%></td>
                                <td><%=results.getString("source")%></td>
                                <td><%=results.getString("count")%></td>
                                <td><%=results.getString("date_column")%></td>
                            </tr>        
                            <%	}
                            %>
                        </tbody>
                    </table>
    </body>
</html>
