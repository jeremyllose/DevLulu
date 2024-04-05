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
        <link rel="stylesheet" href="styles/product.css">
        <title>Product Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <div class="dashboardbar">
            <h1 id="dashboardheader">Product</h1>
        </div>
        
        <div class="others">
            <form action="AddProductRedirect" method="post">
                <button type="submit" class="inventory" id="add">Add Product</button>
            </form>
        <form action="ProductSearch" method="post">
            <input type="text" id="searchBar" name="searchBar" placeholder="Search...">
            <button class="inventory" id="sort" type="submit">Search</button>
        </form> 
        </div>
        <form action="ProductAction" method="post">
        <table>
            <thead>
                <tr>
                    <th><button type="submit" name="button" value="disable">Disable Product</button></th>
                    <th>Product Code</th>
                    <th>Product Description</th>
                    <th>Product Price</th>
                    <th>Quantity</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ResultSet results = (ResultSet) request.getAttribute("product");
                    while (results.next()) {%>
                    <tr>
                        <td><input type="checkbox" name="selectProduct" value="<%= results.getString("product_code")%>"></td>
                        <td><%=results.getString("product_code")%></td>
                        <td><%=results.getString("product_description")%></td>
                        <td><%=results.getString("product_price")%></td>
                        <td><input type="number" min="0" name="qty" value="<%=results.getString("quantity")%>" required/></td>
                        <td>
                            <button type="submit" name="button" value="edit <%= results.getString("product_code")%>">Edit</button>
                        </td>
                        <td><input type="hidden" name="products" value="<%= results.getString("product_code")%>"></td>
                    </tr>
                <%	}
                %>
            </tbody>
        </table>
            <button type="submit" name="button" value="save">Save Changes</button>
        </form>
    </body>
</html> 
