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
        <div class="dashboardbar">
                    <h1 id="dashboardheader">Edit Product</h1></div>
                    <button class="inventory" id="add" onclick="redirectTo('addProduct.jsp')">Add Product</button>
                    <button class="inventory" id="generate" onclick="redirectTo('editProduct.jsp')">Edit Product</button>
                    <button class="inventory" id="sort" onclick="redirectTo('addaccount.jsp')">Delete Product</button>
                    <input type="text" id="searchBar" placeholder="Search...">
        <h1>Edit Product</h1>
        <%
            if (session.getAttribute("productCode") != null) {
        %>
        ${productCode}
        <%
            }
        %>
        <form action="EditProduct" method="post">
        <%
            ResultSet results = (ResultSet)request.getAttribute("editProduct");
            while (results.next()) { %>
            <div class="item-container">
            <table>
                <tr>
                    <th>Product Description</th><th><input type="text" name="productDescription" value="<%= results.getString("product_description") %>" required/></th>
                </tr>
                <tr>
                    <th>Product Price</th><th><input type="number" min="0" step="any" name="productPrice" value="<%= results.getFloat("product_price") %>" required/></th>
                </tr>
            </table>
        <%	
            }
        %>
        <table>
            <thead>
                <tr>
                    <td>Check to Remove Item</td>
                    <th>Item</th>
                    <th>SubClass</th>
                    <th>Quantity</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ResultSet results2 = (ResultSet)request.getAttribute("productInfo");
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
                <tr>
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
                    <td><%=results3.getString("item_code")%></td>
                </tr>	
                <%	}
                %>
            </tbody>
        </table>
            <input type="submit" value="Save Changes"/>
            </div>
        </form>
    </body>
</html>
