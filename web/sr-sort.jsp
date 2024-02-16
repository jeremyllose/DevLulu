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
        <title>Sales Page</title>
        <script src="script/welcome.js" defer></script>
        <title>edit Product Page</title>
    </head>
    <body>
        <div class="dashboardbar">
                    <h1 id="dashboardheader">Sort Options</h1></div>
                    <button class="inventory" id="add" onclick="redirectTo('addProduct.jsp')">Add Product</button>
                    <button class="inventory" id="generate" onclick="redirectTo('editProduct.jsp')">Edit Product</button>
                    <button class="inventory" id="sort" onclick="redirectTo('addaccount.jsp')">Delete Product</button>
                    <input type="text" id="searchBar" placeholder="Search...">
        <h1>Hello World!</h1>
    </body>
</html>
