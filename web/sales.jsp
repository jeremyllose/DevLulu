<%-- 
    Document   : inventory
    Created on : Jan 30, 2024, 9:34:46 PM
    Author     : jeremy
--%>

<%@page import="java.text.DecimalFormat"%>
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
                            <th>Item Code </th>
                            <th>Item Number <button class="sorting" onclick="redirectTo('SByQuantity')"><span id="priceSortIcon">&#8597;</span></button></th>    
                            <th>Item Description</th>
                                <th>Transfer Cost <button class="sorting" onclick="redirectTo('SByPrice')"><span id="priceSortIcon">&#8597;</span></button></th>
                                <th>Sold</th>
                                <th>Total <button class="sorting" onclick="redirectTo('SByTotal')"><span id="priceSortIcon">&#8597;</span></button></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            float total = 0;
                            DecimalFormat formatter = new DecimalFormat("#,##0.00");
                            ResultSet results = (ResultSet) request.getAttribute("sales");
                            while (results.next()) {%>
                        <tr>
                            <td><%=results.getString("item_code")%></td>
                            <td><%=results.getString("item_num")%></td>
                                <td><%=results.getString("item_description")%></td>
                                <td>₱<% 
                                    String formattedValue = formatter.format(results.getDouble("unit_price"));
                                    out.print(formattedValue);%></td>
                                <td><%=results.getString("sold")%></td>
                                <td>₱<% 
                                    String formattedValue2 = formatter.format(results.getDouble("total"));
                                    out.print(formattedValue2);%><input type="hidden" name="items" value="<%=results.getString("item_code")%>"/></td>
                        </tr>
                        <%
                            }
                        %>
                </table>        
            
            <br>
            <br>
            <%
                DecimalFormat formatter2 = new DecimalFormat("#,##0.00");
                float addCost = (Float) request.getAttribute("addsValue");
                String formattedValue3 = formatter2.format(addCost);
            %>
            <div id="costs">Total:</div>
            <input id="costtotal" type="text" id="inventoryprice" name="myText" placeholder="₱<%=formattedValue3%>" readonly style="color: black;">
            </div>
            <%
            Integer itemPgNum = (Integer) session.getAttribute("salesPgNum");
            Integer totalPages = (Integer) session.getAttribute("salesPages");

            int currentPage = itemPgNum != null ? itemPgNum : 1;
            int totalPg = totalPages != null ? totalPages : 1;
        %>
        <form action="SalesRedirect" method="post">
            <table class="pagination">
                <tr>
                    <%
                        if ((currentPage - 2) >= 0 && (currentPage - 2) != 0) {
                    %>
                    <td><input type="submit" name="button" value="<%=currentPage - 2%>"></td>
                        <%
                            }
                        %>
                        <%
                            if ((currentPage - 1) != 0) {
                        %>
                    <td><input type="submit" name="button" value="<%=currentPage - 1%>"></td>
                        <%
                            }
                        %>

                    <td><%= currentPage%></td>

                    <%
                        if ((currentPage + 1) <= totalPg) {
                    %>
                    <td><input type="submit" name="button" value="<%= currentPage + 1%>"></td>
                        <%
                            }
                        %>
                        <%
                            if ((currentPage + 2) <= totalPg) {
                        %>
                    <td><input type="submit"name="button" value="<%= currentPage + 2%>"></td>
                        <%
                            }
                        %>
                </tr>
            </table>
        </form>
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
