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
        <div class="content-wrapper">
            <%
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

                if (session.getAttribute("username") == null) {
                    response.sendRedirect("login.jsp");
                }
            %>
            <div class="dashboardbar">
                <h1 id="dashboardheader">Waste</h1></div>

            <div class="others">
                <button class="inventory" id="generate" onclick="redirectTo('w-generateReport.jsp')"><img src="photos/export.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span style="margin-right: 5px; font-size:23px;">Generate Report</span></button>
                <button class="inventory" id="sort" onclick="redirectTo('w-sort.jsp')">
                    <img src="photos/sort.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span style="margin-right: 5px; font-size:23px;">Sort Options</span></button>
                <form action="WasteSearch" method="post">
                    <input type="text" id="searchBar" name="searchBar" placeholder="Search...">
                    <button type="submit">Search</button>
                </form> 
            </div>
            <input type="text" id="searchBar" placeholder="Search...">
            <form action="SaveWastes" method="post">
                <table>
                    <thead>
                        <tr>
                            <th>Item Code</th>
                            <th>Item Description</th>
                            <th>General Class</th>
                            <th>Sub Class</th>
                            <th>UOM</th>
                            <th>Sold</th>
                            <th>Waste</th>
                            <th>Other Subtractions</th>
                            <th>End Quantity</th>
                            <th><button id="button-css" type="submit" name="button" value="save" style="background-color: #8f654a; color: white; border:none;">
                                    <image src="photos/save.png" alt="Save Button" style="width: 20px; height: 20px;"> <b style="font-size: 16px; padding-left: 5px;">Save Changes</b></button></th>
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
                            <td><%=results.getString("end_quantity")%></td>
                            <td><input type="hidden" name="items" value="<%=results.getString("item_code")%>"/></td>
                        </tr>        
                        <%	}
                        %>
                    </tbody>
                </table>
            </form>
            <div id="dateText">Date: July 15, 2024</div>
        </div>
    </body>
</html>
