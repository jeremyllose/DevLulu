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
        <script>
            if (window.history.replaceState)
            {
                window.history.replaceState(null, null, window.location.href);
            }
        </script>
        <%            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <div class="content-wrapper">
            <div class="dashboardbar">
                <h1 id="dashboardheader">Sales</h1></div>

            <div class="others">
                <form action="SalesSearch" method="post">
                    <div class="searchContainer">
                        <input type="text" id="searchBar" name="searchBar" placeholder="Search...">
                        <button id="search" type="submit">
                            <img src="photos/greensearch.png" style="width: 47px; height: 47px;" alt="Search Icon">
                        </button>
                    </div>
                </form> 

            </div>


            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Product Description</th>
                            <th>Product Price   <button class="sorting" onclick="redirectTo('SByPrice')"><span id="priceSortIcon">&#8597;</span></button> </th>
                            <th>Quantity  <button class="sorting" onclick="redirectTo('SByQuantity')"><span id="quantitySortIcon">&#8597;</span></button></th>
                            <th>Total  <button class="sorting" onclick="redirectTo('SByTotal')"><span id="totalSortIcon">&#8597;</span> </button></th>

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
            <input style="font-size: 16px; width: 190px;" type="text" id="inventoryprice" name="myText" placeholder="<%=total%>">
        </div>
        <!--        <button onclick="redirectTo('SByPrice')">Sort By Price</button>
                    <button onclick="redirectTo('SByQuantity')">Sort By Quantity</button>
                    <button onclick="redirectTo('SByTotal')">Sort By Total</button>-->
<!--       <script>
        // JavaScript functions
        function redirectTo(sortType) {
            // Replace this with your actual redirection logic
            console.log("Redirecting to sorting endpoint: " + sortType);
        }

        function toggleSortOrder(column, sortOrderIcon) {
            var currentOrder = sortOrderIcon.textContent;
            if (currentOrder === "↕") {
                sortOrderIcon.textContent = "↑"; // Change to upward arrow
            } else if (currentOrder === "↑") {
                sortOrderIcon.textContent = "↓"; // Change to downward arrow
            } else {
                sortOrderIcon.textContent = "↑"; // Revert to upward arrow
            }
            redirectTo(column);
        }
    </script>-->
    </body>
</html>
