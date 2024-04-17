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
        <link rel="stylesheet" href="styles/waste.css">
        <title>Waste Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <script>
            if (window.history.replaceState)
            {
                window.history.replaceState(null, null, window.location.href);
            }
        </script>
        <div class="content-wrapper">
            <%                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

                if (session.getAttribute("username") == null) {
                    response.sendRedirect("login.jsp");
                }
            %>
            <div class="dashboardbar">
                <h1 id="dashboardheader">Usage</h1></div>

            <div class="others">
                <form action="UsageExcelServlet" method="post">
                    <button class="inventory" id="generate" type="submit">
                        <img src="photos/export.png" alt="generate report Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span class="inventory-text" style="margin-right: 5px">Gen Report</span></button>
                </form>
                <button class="inventory" id="sort" onclick="redirectTo('SortWasteRedirect')">
                    <img src="photos/sort.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span class="inventory-text">Filter Options</span></button>

                <form action="WasteSearch" method="post">
                    <div class="searchContainer">
                        <input type="text" id="searchBar" name="searchBar" placeholder="Search...">
                        <button id="search" type="submit">
                            <img src="photos/greensearch.png" style="width: 46.5px; height: 46.5px;" alt="Search Icon">
                        </button>
                    </div>
                </form> 

            </div>

            <form action="SaveWastes" method="post">

                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Item Code <button class="sorting" type="submit" name="button" value="WByItem"><span id="itemCodeSortIcon">&#8597;</span></button></th>
                                <th>Item Description</th>
                                <th>General Class</th>
                                <th>Sub Class</th>
                                <th>UOM</th>
                                <th>Sold <button class="sorting" type="submit" name="button" value="WBySold"><span id="soldSortIcon">&#8597;</span></button></th>
                                <th>Waste <button class="sorting" type="submit" name="button" value="WByWaste"><span id="wasteSortIcon">&#8597;</span></button></th>
                                <th>Other Subtractions <button class="sorting" type="submit" name="button" value="WByOther"><span id="otherSubtractionsSortIcon">&#8597;</span></button></th>
                                <th>End Quantity</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ResultSet results = (ResultSet) request.getAttribute("waste");
                                while (results.next()) {%>
                            <tr>
                                <td><%=results.getString("item_code")%></td>
                                <td><%=results.getString("item_description")%></td>
                                <td><%=results.getString("gen_name")%></td>
                                <td><%=results.getString("sub_name")%></td>
                                <td><%=results.getString("unit_name")%></td>
                                <td><input type="number" min="0" name="sold" value="<%=results.getString("sold")%>" required/></td>
                                <td><input type="number" min="0" name="waste" value="<%=results.getString("waste")%>" required/></td>
                                <td><input type="number" min="0" name="othersubs" value="<%=results.getString("othersubs")%>" required/></td>
                                <td><%=results.getString("end_quantity")%> <input type="hidden" name="items" value="<%=results.getString("item_code")%>"/></td>
                            </tr>        
                            <%	}
                            %>
                        </tbody>
                    </table>
                </div>
                <div class="others"><button id="savechanges" type="submit" class="inventory" name="button" value="save">
                        <image src="photos/save.png" alt="Save Button" style="width: 20px; height: 20px;"> <span style=" padding-left: 5px;">Save Changes</span></div>
            </form>
                        <%
                // Check if the session attribute for addItemMessage exists and display it
                String addItemMessage = (String) request.getAttribute("wasteMessage");
                String itemMessage = (String) session.getAttribute("wasteMessage");
                if (addItemMessage != null) {
            %>
            <div class="message">
                <%= addItemMessage%>
            </div>
            <%
                }else if (itemMessage!= null){
            %>
            <div class="message">
                <%= itemMessage%>
            </div>
            <%
                session.removeAttribute("wasteMessage");
                }
            %>
            <form action="WasteRedirect" method="post">
                <table class="pagination">
                    <%
                        Integer itemPgNum = (Integer) session.getAttribute("wastePgNum");
                        Integer totalPages = (Integer) session.getAttribute("wastePages");

                        int currentPage = itemPgNum != null ? itemPgNum : 1;
                        int totalPg = totalPages != null ? totalPages : 1;
                    %>
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
                        <td><input type="submit" name="button" value="<%= currentPage + 2%>"></td>
                            <%
                                }
                            %>
                    </tr>
                </table>
            </form>
            <!--            <div id="dateText">Date: July 15, 2024</div>-->
        </div>
    </body>
</html>
