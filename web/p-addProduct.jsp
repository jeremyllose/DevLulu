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
        <link rel="stylesheet" href="styles/addProduct.css">
        <script src="script/welcome.js" defer></script>
        <title>add Product Page</title>
    </head>
    <body>
        <div class="dashboardbar">
            <h1 id="dashboardheader">Add Product Page</h1>
        </div>
        <br>
        <br>
        <br>
        <br>
        <br>
        <form action="AddProduct" method="post">
            <div class="product-container">
            <table>
                
                <tr class="prod-position">
                    <th class="th-product-label">Product Code:</th>
                    <td class="td-product-label"><input type="text" name="productCode" minlength="8" pattern="[A-Za-z0-9]+" required></td>
                </tr>
                <tr class="prod-position">
                    <th class="th-product-label">Product Description:</th>
                    <td class="td-product-label"><input type="text" name="productDescription" required></td>
                </tr>
                <tr class="prod-position">
                    <th class="th-product-label">Product Price:</th>
                    <td class="td-product-label"><input type="number" min="0" step="any" name="productPrice" required></td>
                </tr>
            </table>

            <table>
                <thead>
                    <tr>
                        <hr color="black" size="1" width="100%" align="center">
                        <th class="prod-table">Selector</th>
                        <th class="prod-table">Item No.</th>
                        <th class="prod-table">Description</th>
                        <th class="prod-table">Unit of Measurement</th>
                        <th class="prod-table">General Class</th>
                        <th class="prod-table">Sub Class</th>
                        <th class="prod-table">Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    ResultSet results = (ResultSet) request.getAttribute("items");
                    while (results.next()) {%>
                    <tr>
                        <td><input type="checkbox" name="items" value="<%= results.getString("item_code")%>"></td>
                        <td><%=results.getString("item_num")%></td>
                        <td><%=results.getString("item_description")%></td>
                        <td><%=results.getString("unit_name")%></td>
                        <td><%=results.getString("gen_name")%></td>
                        <td><%=results.getString("sub_name")%></td>
                        <td><input type="number" min="0" name="itemQuantity" value="0" /></td>
                    </tr>	
                    <%	}
                    %>
                </tbody>
                <button class="inventory" id="return" onclick="redirectTo('ProductRedirect')">Return</button>
            </table>
            <input type="submit" value="Add Product">
            </div>
        </form>
    </body>
</html>
