<%-- 
    Document   : commons
    Created on : 02 12, 24, 2:25:49 AM
    Author     : jeremy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("pageTitle", "Default Title");%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/commons.css">
        <link rel="icon" type="image/png" href="photos/cafeicon.png">
        <script src="script/transitions.js" defer></script>
        <title>JSP Page</title>
    </head>
    <body>

        <div class="container">
            <div class="sidebar">
                <button id="homebutton" onclick="redirectTo('welcome.jsp')"><img src=".\photos\dashboardlogo.png" alt="Home"></button>
                <button class="menu-item" onclick="redirectTo('sales.jsp')">Sales</button>
                <button class="menu-item" onclick="redirectTo('product.jsp')">Product</button>
                <button class="menu-item" onclick="redirectTo('variance.jsp')">Variance</button>
                <form action="ItemList" method="post">
                    <button class="menu-item" onclick="redirectToWithTransition('ItemList')">Inventory</button>
                </form>
                <button class="menu-item" onclick="redirectTo('suppliesreceived.jsp')">Supplies Received</button>
                <button class="menu-item" onclick="redirectTo('waste.jsp')">Waste</button>
                <br>
                <br>
                <br>
                <br>
                <form action="AccountList" method="post">
                    <button class="menu-item" id="accountlist">Account List</button>
                </form>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <form action="Logout">
                    <button class="menu-item" id="logout"  type="submit" onclick="return confirm('Are you sure you want to logout?')" >Logout</button>
                </form>
            </div>
            <div class="main-content" id="mainContent">
                <!-- no div tag closing, if added layout issues show-->
                </body>
                </html>
