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
        <link rel="stylesheet" href="styles/inventory.css">
        <title>Inventory Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
              <div class="dashboardbar">
                    <h1 id="dashboardheader">Inventory</h1></div>
                    <button class="inventory" id="generate" onclick="navigateTo('additem.jsp')">Generate Report</button>
                    <div class="others">
                    <button class="inventory" id="add" onclick="navigateTo('additem.jsp')">Add Item</button>
                    <button class="inventory" id="edit" onclick="navigateTo('addaccount.jsp')">Edit Item</button>
                    <button class="inventory" id="delete" onclick="navigateTo('addaccount.jsp')">Delete Item</button>
                    <button class="inventory" id="import" onclick="navigateTo('addaccount.jsp')">Import Excel</button>
                    <button class="inventory" id="sort" onclick="navigateTo('addaccount.jsp')">Sort Options</button
    </div>
                    <input type="text" id="searchBar" placeholder="Search..."> 
                     <img id="inventorytable"src=".\photos\inventory.png" alt="inventory">
                     
                      <div id="dateText">Date: July 15, 2024</div>
    </body>
</html>
