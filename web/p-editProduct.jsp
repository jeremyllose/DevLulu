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
        <link rel="stylesheet" href="styles/editProduct.css">
        <script src="script/welcome.js" defer></script>
        <title>edit Product Page</title>
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
        <div class="dashboardbar">
            <h1 id="dashboardheader">Edit Product </h1></div>
            <%
                if (session.getAttribute("productCode") != null) {
            %>
            ${productCode}
            <%
                }
            %>
        <form action="EditProduct" method="post">
            <%
                ResultSet results = (ResultSet) request.getAttribute("editProduct");
                while (results.next()) {%>
            <div class="item-container">
                <%
                // Check if the session attribute for addItemMessage exists and display it
                String addItemMessage = (String) request.getAttribute("productMessage");
                String itemMessage = (String) session.getAttribute("productMessage");
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
                session.removeAttribute("productMessage");
                }
            %>
                <table>
                    <tr>
                        <th class="th-product-label">Product Code:</th>
                        <th class="th-product-label"><%= results.getString("product_code")%></th>
                    </tr>
                    <tr>
                        <th class="th-product-label">Product Description:</th>
                        <th class="th-product-label"><input type="text" name="productDescription" value="<%= results.getString("product_description")%>" required/></th>
                    </tr>
                    <tr>
                        <th class="th-product-label">Product Price:</th>
                        <th class="th-product-label"><input type="number" min="0" step="any" name="productPrice" value="<%= results.getFloat("product_price")%>" required/></th>
                    </tr>
                </table>
                <%
                    }
                %>
                <table>
                    <thead>
                        Select Items to remove from the Product:
                        <tr>
                    <hr color="black" size="1" width="100%" align="center">
                    <th>Item</th>
                    <th style="padding-left: 35px;">SubClass</th>
                    <th style="padding-left: 35px;">Quantity</th>
                    </tr>
                    </thead>
                    <tbody>
                        <%
                            ResultSet results2 = (ResultSet) request.getAttribute("productInfo");
                            while (results2.next()) {
                        %>
                        <tr>
                            <td><input type="checkbox" name="itemRemove" value="<%= results2.getString("item_code")%>"></td>
                            <th><%= results2.getString("item_description")%></th>
                            <th><%= results2.getString("sub_name")%></th>
                            <td><input type="number" min="0" name="updateItemQuantity" value="<%= results2.getString("quantity")%>" /></td>
                            <td><input type="hidden" name="itemCode" value="<%= results2.getString("item_code")%>"></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <table>
                    <thead>
                        Select Items to add to the Product:
                        <tr>
                    <hr color="black" size="1" width="100%" align="center">
                    <th>Selector</th>
                    <th>Description</th>
                    <th>Sub Class</th>
                    <th>Quantity</th>
                    </tr>
                    </thead>
                    <tbody>
                        <%
                            ResultSet results3 = (ResultSet) request.getAttribute("moreItems");
                            while (results3.next()) {%>
                        <tr>
                            <td><input type="checkbox" name="itemsAdd" value="<%=results3.getString("item_code")%>"></td>
                            <td><%=results3.getString("item_description")%></td>
                            <td><%=results3.getString("sub_name")%></td>
                            <td><input type="number" min="0" name="itemQuantity" value="0" /></td>
                            <td style="padding-left: 30px;"><%=results3.getString("item_code")%></td>
                        </tr>	
                        <%	}
                        %>
                    </tbody>

                </table>
                <button class="inventory" id="return" type="button" onclick="redirectTo('ProductRedirect')">Return</button>
                <input type="submit" value="Save"/>
            </div>
        </form>
                    
    </body>
</html>
