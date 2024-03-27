<%-- 
    Document   : addProduct
    Created on : 02 11, 24, 2:39:14 PM
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
        <link rel="stylesheet" href="styles/addItem.css">
        <script src="script/welcome.js" defer></script>
        <title>Add Item</title>
    </head>
    <body>

        <div class="dashboardbar">
            <h1 id="dashboardheader">Add Item Page</h1>
        </div>
        <br>
        <br>
        <br>
        <br>
        <br>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <form action="AddItem" method="post">
            <div class="item-container">
                <table>
                    <tr>
                        <th>Item Code:</th>
                        <td><input type="text" name="itemCode" minlength="8" pattern="[A-Za-z0-9]+" required></td>
                    </tr>
                    <tr>
                        <th>Item Description:</th>
                        <td><input type="text" name="itemDescription" required></td>
                    </tr>
                    <tr>
                        <th>Unit of Measurement:</th>
                        <td>
                            <label for="pc"><input type="radio" id="pc" name="uom" value="PC" required> PC</label>
                            <label for="gal"><input type="radio" id="gal" name="uom" value="GAL"> GAL</label>
                            <label for="pac"><input type="radio" id="pac" name="uom" value="PAC"> PAC</label>
                        </td>
                    </tr>
                    <tr>
                        <th>Transfer Cost:</th>
                        <td><input type="number" min="0" step="any" name="transferCost" required></td>
                    </tr>
                    <tr>
                        <th>General Class:</th>
                        <td>
                            <%
                                ResultSet genClass = (ResultSet) request.getAttribute("genClass");
                                while (genClass.next()) {%>
                            <label><%=genClass.getString("gen_name")%> <input type="radio" name="gc" value="<%=genClass.getString("gen_id")%>" required></label><br>
                                <%	}
                                %>
                        </td>
                    </tr>
                    <tr>
                        <th>Sub Class:</th>
                        <td>
                            <%
                                ResultSet subClass = (ResultSet) request.getAttribute("subClass");
                                while (subClass.next()) {%>
                            <label><%=subClass.getString("sub_name")%> <input type="radio" name="sc" value="<%=subClass.getString("sub_id")%>" required></label><br>
                                <%	}
                                %>
                        </td>
                    </tr>
                    <tr>
                        <th>Include VAT:</th>
                        <td><input type="checkbox" name="vat" value="on"></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Add Item"></td>
                    </tr>
                    <form action="AddItemPageRedirect" method="post">
                        <button class="inventory" id="return" onclick="redirectTo('ItemList')">Return</button>
                    </form>
                </table>
            </div>
        </form>

        <div>   
            <% if (session.getAttribute("existing") != null) { %>
            <div class="error-message">
                <span class="error-symbol">&#9888;</span> Error! ${existing}
            </div>
            <% }%>
        </div>
    </body>
</html>