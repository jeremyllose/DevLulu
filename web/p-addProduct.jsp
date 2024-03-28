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
             <h1 id="dashboardheader">Add Product</h1>
         </div>
        
        <form action="AddProduct" method="post">
        <table>
            <tr>
                <th>Product Code:</th>
                <td><input type="text" name="productCode" minlength="8" pattern="[A-Za-z0-9]+" required></td>
            </tr>
            <tr>
                <th>Product Description:</th>
                <td><input type="text" name="productDescription" required></td>
            </tr>
            <tr>
                <th>Product Price:</th>
                <td><input type="number" min="0" step="any" name="productPrice" required></td>
            </tr>
        </table>
        
        <table>
            <thead>
                <tr>
                    <th>Selector</th>
                    <th>Item No.</th>
                    <th>Description</th>
                    <th>Unit of Measurement</th>
                    <th>General Class</th>
                    <th>Sub Class</th>
                    <th>Quantity</th>
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
        </table>
            <input type="submit" value="Add Product">
        </form>
    </body>
</html>
