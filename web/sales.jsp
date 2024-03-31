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
        <link rel="stylesheet" href="styles/sales.css">
        <title>Sales Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
              <div class="dashboardbar">
                    <h1 id="dashboardheader">Sales</h1></div>
                    
                    <div class="others">
                    <button class="inventory" id="add" onclick="redirectTo('s-addProduct.jsp')">Add Product</button>
                    <button class="inventory" id="generate" onclick="redirectTo('s-editProduct.jsp')">Edit Product</button>
                    <button class="inventory" id="sort" onclick="redirectTo('s-deleteProduct.jsp')">Delete Product</button>
                    <input type="text" id="searchBar" placeholder="Search..."> 
                    </div>
                     
                      
                       
           <table>
            <thead>
                <tr>
                    <th>Product Description</th>
                    <th>Product Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <%
                    float total = 0;
                    ResultSet results = (ResultSet) request.getAttribute("sales");
                    while (results.next()) {%>
                    <tr>
                        <td><%=results.getString("product_description")%></td>
                        <td><%=results.getString("product_price")%></td>
                        <td><%=results.getString("quantity")%></td>
                        <td><%=results.getString("TOTAL_PRICE")%></td>
                    </tr>
                <%	
                    total += results.getFloat("TOTAL_PRICE");
                    }
                %>
</table>            
                    <div id="dateText">Date: July 15, 2024</div>
                      <div id="costs">Total:</div>
                      <input type="text" id="inventoryprice" name="myText" placeholder="<%=total%>">
    </body>
</html>
