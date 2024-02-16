<%-- 
    Document   : editProduct
    Created on : 02 12, 24, 8:49:05 PM
    Author     : BioStaR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="commons.jsp"%>
<!DOCTYPE html>
<html>
    <head>
          <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/editProduct.css">
        <script src="script/welcome.js" defer></script>
        <title>Generate Report Page</title>
    </head>
    <body>
        <div class="dashboardbar">
                    <h1 id="dashboardheader">Generate Report</h1></div>
                    <button class="inventory" id="add" onclick="redirectTo('addProduct.jsp')">Add Product</button>
                    <button class="inventory" id="generate" onclick="redirectTo('editProduct.jsp')">Edit Product</button>
                    <button class="inventory" id="sort" onclick="redirectTo('addaccount.jsp')">Delete Product</button>
                    <input type="text" id="searchBar" placeholder="Search...">
        <h1>Hello World!</h1>
    </body>
</html>
