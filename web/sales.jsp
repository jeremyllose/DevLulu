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
        <link rel="stylesheet" href="styles/sales.css">
        <title>Sales Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <div class="content-wrapper">
            <div class="dashboardbar">
                <h1 id="dashboardheader">Sales</h1></div>

            <div class="others">
                <form action="SalesSearch" method="post">
                    <div class="searchContainer">
                    <input type="text" id="searchBar" name="searchBar" placeholder="Search...">
                    <button id="search" type="submit">
                        <img src="photos/searchicon.png" alt="Search Icon">
                    </button>
                    </div>
                </form> 

            </div>


<div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Product Description</th>
                        <th>Product Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        float total = 0;
                        ResultSet results = (ResultSet) request.getAttribute("sales");
                        while (results.next()) {%>
                    <tr>
                        <td><%=results.getString("product_description")%></td>
                        <td><%=results.getString("product_price")%></td>
                        <td><%=results.getString("quantity")%></td>
                        <td><%=results.getString("TOTAL_PRICE")%></td>
                    </tr>
                    <%
                            total += results.getFloat("TOTAL_PRICE");
                        }
                    %>
            </table>        
</div>
            <br>
            <br>
            <div id="costs">Total:</div>
            <input style="font-size: 16px;" type="text" id="inventoryprice" name="myText" placeholder="<%=total%>">
        </div>
    </body>
</html>
