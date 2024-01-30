<%-- 
    Document   : inventory
    Created on : Jan 30, 2024, 9:34:46 PM
    Author     : jeremy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/sales.css">
        <title>Product Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
              <div class="dashboardbar">
                    <h1 id="dashboardheader">Product</h1></div>
                    <button class="inventory" id="add" onclick="navigateTo('additem.jsp')">Add Product</button>
                    <button class="inventory" id="generate" onclick="navigateTo('additem.jsp')">Edit Product</button>
                    <button class="inventory" id="sort" onclick="navigateTo('addaccount.jsp')">Delete Product</button>
                    <input type="text" id="searchBar" placeholder="Search..."> 
                    <br>
                     <img id="salestable"src=".\photos\Sales.png" alt="inventory">
                     
                      <div id="dateText">Date: July 15, 2024</div>
                      <div id="costs">Total:</div>
                      <input type="text" id="inventoryprice" name="myText" placeholder="29,061">
                       
                      
    </body>
</html>
