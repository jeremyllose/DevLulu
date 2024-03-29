<%-- 
    Document   : inventory
    Created on : Jan 30, 2024, 9:34:46 PM
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
        <link rel="stylesheet" href="styles/suppliesreceived.css">
        <title>Supplies Received Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <div class="dashboardbar">
            <h1 id="dashboardheader">Supplies Received</h1>
        </div>
        <%
            float addCost = (Float) request.getAttribute("addsValue");
        %>
        <div class="others">
            <button class="inventory" id="generate" onclick="redirectTo('sr-generateReport.jsp')">Generate Report</button>
            <button class="inventory" id="sort" onclick="redirectTo('sr-sort.jsp')">Sort Options</button>
            <h1>Delivery Costs: <%= addCost %></h1>
            <input type="text" id="searchBar" placeholder="Search..."> 
        </div>
            <form action="SaveDeliveries" method="post">
            
            <table>
            <thead>
                <tr>
                    <th>Item Code</th>
                    <th>Item Description</th>
                    <th>General Class</th>
                    <th>Sub Class</th>
                    <th>UOM</th>
                    <th>Deliveries</th>
                    <th>Others</th>
                    <th>End Quantity</th>
                    <th><button type="submit" name="button" value="save">Save Changes</button></th>
                </tr>
            </thead>
            <tbody>
                <%
                    ResultSet results = (ResultSet) request.getAttribute("deliveries");
                    while (results.next()) {%>
                    <tr>
                        <td><%=results.getString("item_code")%></td>
                        <td><%=results.getString("item_description")%></td>
                        <td><%=results.getString("gen_name")%></td>
                        <td><%=results.getString("sub_name")%></td>
                        <td><%=results.getString("unit_name")%></td>
                        <td><input type="number" min="0" name="delivery" value="<%=results.getString("delivery")%>" required/></td>
                        <td><input type="number" min="0" name="others" value="<%=results.getString("otheradds")%>" required/></td>
                        <td><%=results.getString("end_quantity")%></td>
                    </tr>        
                <%	}
                %>
            </tbody>
        </table>
        </form>
    </body>
</html>
