<%-- 
    Document   : addProduct
    Created on : 02 11, 24, 2:39:14 PM
    Author     : jeremy
--%>

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
                    <h1 id="dashboardheader">Add Product</h1></div>
                    <button class="inventory" id="add" onclick="redirectTo('p-addProduct.jsp')">Add Product</button>
                    <button class="inventory" id="generate" onclick="redirectTo('p-editProduct.jsp')">Edit Product</button>
                    <button class="inventory" id="sort" onclick="redirectTo('p-deleteProduct.jsp')">Delete Product</button>
                    <input type="text" id="searchBar" placeholder="Search..."> 
                    
        <h1>Hello World!</h1>
    </body>
</html>
