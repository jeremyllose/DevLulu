<%-- 
    Document   : activtylog
    Created on : May 5, 2024, 10:01:41 PM
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
        <link rel="stylesheet" href="styles/activitylog.css">
        <title>Activity Log Page</title>
        <script src="script/welcome.js" defer></script>
        <script src="script/transitions.js" defer></script>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    </head>
    <body>
        <div class="dashboardbar">
            <h1 id="dashboardheader">Activity Log</h1>
        </div>
        <div class="others">
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>USER</th>
                        <th>Item/Product Code</th>
                        <th>Item/Product Description</th>
                        <th>Action</th>
                        <th>Source</th>
                        <th>Count</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%                                ResultSet results = (ResultSet) request.getAttribute("itemRecords");
                                while (results.next()) {%>
                    <tr>
                        <td><%=results.getString("username")%></td>
                        <td><%=results.getString("item_code")%></td>
                        <td><%=results.getString("item_description")%></td>
                        <td><%=results.getString("action")%></td>
                        <td><%=results.getString("source")%></td>
                        <td><%=results.getString("count")%></td>
                        <td><%=results.getString("time_capture")%></td>
                    </tr>        
                    <%	}
                    %>
                </tbody>
            </table>
        </div>
        </div>
    </body>
</html>
