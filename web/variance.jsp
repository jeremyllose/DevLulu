<%-- 
    Document   : inventory
    Created on : Jan 30, 2024, 9:34:46 PM
    Author     : jeremy
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="commons.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/variance.css">
        <title>Variance Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <div class="content-wrapper">
            <%
                // Get current date
                LocalDate today = LocalDate.now();

                // Check if today is within the first 5 days of the month
                boolean withinFirstFiveDays = today.getDayOfMonth() <= 5;
            %>
            <%
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

                if (session.getAttribute("userRole").equals("Manager")) {
                    session.setAttribute("verification", "You have no Permission to Open the Account List");
                    response.sendRedirect("welcome.jsp");
                }
            %>
            <div class="dashboardbar">
                <h1 id="dashboardheader">Variance</h1>
            </div>
            <br>
            <br>
            <%
                int itemCount = (Integer) request.getAttribute("inventoryCount");
            %>
            <div class="Delivery-Container" id="DC"><h1><image src="photos/Count.png" alt="Save Button" style="width: 35px; height: 35px; position: relative; right: 3px; top: 10px;">Inventory Count: <%= itemCount%></h1></div>
                    <%
                        float inventoryCost = (Float) request.getAttribute("inventoryValue");
                    %>
            <div class="Delivery-Container"><h1><image src="photos/Value.png" alt="Save Button" style="width: 35px; height: 35px; position: relative; right: 3px; top: 4px;">Inventory Value: <%= inventoryCost%></h1></div>
            
                <form action="VarianceSearch" method="post">
                    <div id="searchContainer">
                        <input type="text" id="searchBar" name="searchBar" placeholder="Search...">
                        <button id="search" type="submit">
                            <img src="photos/searchicon.png" alt="Search Icon">
                        </button>
                    </div>
                </form>
            <form action="SaveVariance" method="post">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Item Description</th>
                                <th>General Class</th>
                                <th>Sub Class</th>
                                <th>UOM</th>
                                <th>BEG</th>
                                <th>Deliveries</th>
                                <th>Others</th>
                                <th>Total On Main</th>
                                <th>Sold</th>
                                <th>Waste</th>
                                <th>Others</th>
                                <th>Total</th>
                                <th>Expected End</th>
                                <th>Actual End</th>
                                <th>Variance</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ResultSet results = (ResultSet) request.getAttribute("inventory");
                                while (results.next()) {%>
                            <tr>
                                <td><%=results.getString("item_description")%><input type="hidden" name="code" value="<%=results.getString("item_code")%>"/></td>
                                <td><%=results.getString("gen_name")%></td>
                                <td><%=results.getString("sub_name")%></td>
                                <td><%=results.getString("unit_name")%></td>
                                <%
                                    if (withinFirstFiveDays) {
                                %>
                                <td><input type="number" min="0" name="beg" value="<%=results.getString("beginning_quantity")%>" required/></td>
                                    <% } else {
                                    %>
                                <td><input type="number" min="0" name="beg" value="<%=results.getString("beginning_quantity")%>" required readonly/></td>
                                    <% }
                                    %>

                                <td><%=results.getString("delivery")%></td>
                                <td><%=results.getString("otheradds")%></td>
                                <%
                                    int totalOnMain = results.getInt("beginning_quantity") + results.getInt("delivery") + results.getInt("otheradds");
                                %>
                                <td><%=totalOnMain%></td>
                                <td><%=results.getString("sold")%></td>
                                <td><%=results.getString("waste")%></td>
                                <td><%=results.getString("othersubs")%></td>
                                <%
                                    int totalOutput = totalOnMain - results.getInt("sold") - results.getInt("waste") - results.getInt("othersubs");
                                %>
                                <td><%=totalOutput%></td>
                                <td><%=totalOutput%></td>
                                <td><input type="number" min="0" name="end" value="<%=results.getString("end_quantity")%>" required/></td>
                                    
                                    <%
                                        int variance = results.getInt("end_quantity") - totalOutput;
                                    %>
                                <td><%=variance%></td>
                                <td>
                                    <button id="button-css" type="submit" name="button" value="edit <%= results.getString("item_code")%>">
                                        <img id="edit-picture" src="photos/edit-button.png" alt="Edit Button">  Edit
                                    </button>

                                </td>
                            </tr>	
                            <%	}
                            %>
                        </tbody>
                    </table>
                </div>
                        <input type="submit" value="Save Changes">
            </form>
            <form action="VariancePageRedirect" method="post">
                <table>
                    <%
                        Integer itemPgNum = (Integer) session.getAttribute("variancePgNum");
                        Integer totalPages = (Integer) session.getAttribute("variancePages");

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
                <div class="others"><button style="position: relative; right: -44px; top: -442px;" type="submit" class="inventory">
                        <image src="photos/save.png" alt="Save Button" style="width: 20px; height: 20px;"> <span style=" padding-left: 5px;">Save Changes</span></div>
            </form>
        </div>
    </body>
</html>
