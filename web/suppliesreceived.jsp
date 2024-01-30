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
        <link rel="stylesheet" href="styles/suppliesreceived.css">
        <title>Supplies Received Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
              <div class="dashboardbar">
                    <h1 id="dashboardheader">Supplies Received</h1></div>
                    <button class="inventory" id="generate" onclick="navigateTo('additem.jsp')">Generate Report</button>
                    <button class="inventory" id="sort" onclick="navigateTo('addaccount.jsp')">Sort Options</button>
                    <input type="text" id="searchBar" placeholder="Search..."> 
                    <br>
                     <img id="inventorytable"src=".\photos\inventory.png" alt="inventory">
                     
                      <div id="dateText">Date: July 15, 2024</div>
                      <div id="costs">Total Delivery Costs:</div>
                      <input type="text" id="deliverycost" name="myText" placeholder="304,299">
    </body>
</html>
