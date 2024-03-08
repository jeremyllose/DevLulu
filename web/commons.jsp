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
        <title>JSP Page</title>
    </head>
    <body>

        <div class="container">
            <div class="sidebar">
                <button class="menu-item" id="homebutton" onclick="redirectTo('welcome.jsp')"><img src=".\photos\dashboardlogo.png" alt="Home"></button>
                <button class="menu-item" onclick="redirectTo('sales.jsp')">Sales</button>
                <button class="menu-item" onclick="redirectTo('product.jsp')">Product</button>
                <form action="VariancePageRedirect" method="post">
                    <button class="menu-item">Variance</button>
                </form>
                <form action="ItemList" method="post">
                    <button class="menu-item">Inventory</button>
                </form>
                <form action="SuppliesRedirectPage" method="post">
                    <button class="menu-item">Supplies Received</button>
                </form>
                <button class="menu-item" onclick="redirectTo('waste.jsp')">Waste</button>
                <form action="AccountList" method="post">
                    <button class="menu-item" id="accountlist">Account List</button>
                </form>
                <form action="Logout">
                    <button class="menu-item" id="logout"  type="submit" onclick="return confirm('Are you sure you want to logout?')" >Logout</button>
                </form>
            </div>  
            <div class="main-content" id="mainContent">
                </body>
                </html>
