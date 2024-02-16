<%-- 
    Document   : commons
    Created on : 02 12, 24, 2:25:49 AM
    Author     : jeremy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("pageTitle", "Default Title"); %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/commons.css">
        <title>JSP Page</title>
    </head>
    <body>
        
        <div class="container">
            <div class="sidebar">
                <button class="menu-item" id="homebutton" onclick="redirectTo('welcome.jsp')"><img src=".\photos\dashboardlogo.png" alt="Home"></button>
                <button class="menu-item" onclick="redirectTo('sales.jsp')">Sales</button>
                <button class="menu-item" onclick="redirectTo('product.jsp')">Product</button>
                <button class="menu-item" onclick="redirectTo('variance.jsp')">Variance</button>
                <button class="menu-item" onclick="redirectTo('inventory.jsp')">Inventory</button>
                <button class="menu-item" onclick="redirectTo('suppliesreceived.jsp')">Supplies Received</button>
                <button class="menu-item" onclick="redirectTo('waste.jsp')">Waste</button>
                <button class="menu-item" id="accountlist" onclick="redirectTo('accountlist.jsp')">Account List</button>
                <button class="menu-item" id="logout" onclick="redirectTo('login.jsp')">Logout</button>
                <!-- Add more buttons as needed -->
            </div>  
            <div class="main-content" id="mainContent">
    </body>
</html>
