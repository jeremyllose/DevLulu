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
        <div class="content-wrapper">
            <div class="dashboardbar">
                <h1 id="dashboardheader">Supplies Received</h1>
            </div>
            <%
                float addCost = (Float) request.getAttribute("addsValue");
            %>
            <div class="others">
                <button class="inventory" id="generate" onclick="redirectTo('sr-generateReport.jsp')"><img src="photos/export.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span style="margin-right: 5px; font-size:23px;">Generate Report</span></button>
                <button class="inventory" id="sort" onclick="redirectTo('SortRedirectSupplies')"><img src="photos/sort.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span style="margin-right: 5px; font-size:23px;">Sort Options</span></button>
                <div class="Delivery-Container"><h1><img src="photos/Delivery.png" alt="plus Button" style="width: 35px; height: 35px; margin: 0px 5px -7px">Delivery Costs: <%= addCost%></h1></div>
                <form action="SuppliesSearch" method="post">
                    <div id="searchContainer">
                        <input type="text" id="searchBar" name="searchBar" placeholder="Search...">
                        <button id="search" type="submit">
                            <img src="photos/searchicon.png" alt="Search Icon">
                        </button>
                    </div>
                </form>

            </div>
            <form action="SaveDeliveries" method="post">
                <div class="table-container">
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
                                <!--                            <th><button id="button-css" type="submit" name="button" value="save" style="background-color: #8f654a; color: white; border:none;">
                                                                    <image src="photos/save.png" alt="Save Button" style="width: 20px; height: 20px;"> <b style="font-size: 16px; padding-left: 5px;">Save Changes</b></button></th>-->
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
                                <td><%=results.getString("end_quantity")%><input type="hidden" name="items" value="<%=results.getString("item_code")%>"/></td>
    <!--                             // <td><input type="hidden" name="items" value="<%=results.getString("item_code")%>"/></td>-->
                            </tr>        
                            <%	}
                            %>
                        </tbody>
                    </table>
                </div>
                <div class="others"><button style="position: relative; right: -480px; top: -270px;" type="submit" class="inventory">
                        <image src="photos/save.png" alt="Save Button" style="width: 20px; height: 20px;"> <span style=" padding-left: 5px;">Save Changes</span></div>
            </form>
            <form action="SuppliesRedirectPage" method="post">
                <table>
                    <%
                        Integer itemPgNum = (Integer) session.getAttribute("suppliesPgNum");
                        Integer totalPages = (Integer) session.getAttribute("suppliesPages");

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
        </div>
    </body>
</html>
