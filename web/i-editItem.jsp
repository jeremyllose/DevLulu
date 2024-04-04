<%-- 
    Document   : editProduct
    Created on : 02 12, 24, 8:49:05 PM
    Author     : BioStaR
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="commons.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Product Page</title>
        <link rel="stylesheet" href="styles/editItem.css">
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <%
            if (session.getAttribute("itemCode") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <div class="dashboardbar">
            <h1 id="dashboardheader">Edit Item Page</h1>
        </div>
        <div class="item-container">
            <form action="EditItem" method="post">
                <%
                    ResultSet results = (ResultSet) request.getAttribute("editRecord");
                    ResultSet genResults = (ResultSet) request.getAttribute("genClassEdit");
                    ResultSet subResults = (ResultSet) request.getAttribute("subClassEdit");
                    ResultSet unitResults = (ResultSet) request.getAttribute("unitClassEdit");
                    while (results.next()) {
                %>
                <input type="hidden" name="itemCode" value="<%= results.getString("item_code")%>">
                <table>
                    <tr>
                        <th>Item Code:</th>
                        <td><%= results.getString("item_code")%></td>
                    </tr>
                    <tr>
                        <th>Item Description:</th>
                        <td><input type="text" name="itemDescription" value="<%= results.getString("item_description")%>" required/></td>
                    </tr>
                    <tr>
                        <th>Unit of Measurement:</th>
                        <td class="class-options">
                            <%
                                while (unitResults.next()) {
                                    if (unitResults.getString("unit_name").equals(results.getString("unit_name"))) {
                            %>
                            <label><%=unitResults.getString("unit_name")%> <input type="radio" name="uom" value="<%=unitResults.getString("unit_id")%>" checked required></label><br>
                                <%
                                } else {
                                %>
                            <label><%=unitResults.getString("unit_name")%> <input type="radio" name="uom" value="<%=unitResults.getString("unit_id")%>" required></label><br>
                                <%
                                        }
                                    }
                                %>
                        </td>
                    </tr>
                    <tr>
                        <th>Transfer Cost:</th>
                        <td><input type="number" min="0" step="any" name="transferCost" value="<%= results.getFloat("transfer_cost")%>" required/></td>
                    </tr>
                    <tr>
                        <th>General Class:</th>
                        <td class="class-options">
                            <%
                                while (genResults.next()) {
                                    if (genResults.getString("gen_name").equals(results.getString("gen_name"))) {
                            %>
                            <label><%=genResults.getString("gen_name")%> <input type="radio" name="gc" value="<%=genResults.getString("gen_id")%>" checked required></label><br>
                                <%
                                } else {
                                %>
                            <label><%=genResults.getString("gen_name")%> <input type="radio" name="gc" value="<%=genResults.getString("gen_id")%>" required></label><br>
                                <%
                                        }
                                    }
                                %>
                        </td>
                    </tr>
                    <tr>
                        <th>Sub Class:</th>
                        <td class="box-container">
                            <%
                                while (subResults.next()) {
                                    if (subResults.getString("sub_name").equals(results.getString("sub_name"))) {
                            %>
                            <label><%=subResults.getString("sub_name")%> <input type="radio" name="sc" value="<%=subResults.getString("sub_id")%>" checked required></label><br>
                                <%
                                } else {
                                %>
                            <label><%=subResults.getString("sub_name")%> <input type="radio" name="sc" value="<%=subResults.getString("sub_id")%>" required></label><br>
                                <%
                                        }
                                    }
                                %>
                        </td>
                    </tr>
                    <tr>
                        <th>Include VAT:</th>
                        <td>
                            <%
                                if (results.getBoolean("vat")) {
                            %>
                            <input type="checkbox" name="vat" value="on" checked>
                            <%
                            } else {
                            %>
                            <input type="checkbox" name="vat" value="on">
                            <%
                                }
                            %>
                        </td>
                    </tr>
                </table>
                <button class="inventory" id="return" type="button" onclick="redirectTo('ItemList')">Return</button>
                <input type="submit" value="Save"/>
                <%
                    }
                %>
            </form>
        </div>
    </body>
</html>