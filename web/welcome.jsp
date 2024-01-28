<%-- 
    Document   : welcome
    Created on : Jan 19, 2024, 10:21:51 AM
    Author     : Cesar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/welcome.css">

        <title>Dashboard Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>


        <div class="container">
            <div class="sidebar">
                <button class="menu-item" id="homebutton" onclick="navigateTo('welcome.jsp')"><img src=".\photos\NXGen.png" alt="Home"></button>
                <button class="menu-item" onclick="navigateTo('dashboard.html')">PlaceHolder</button>
                <button class="menu-item" onclick="navigateTo('sales.html')">Sales</button>
                <button class="menu-item" onclick="navigateTo('product.html')">Product</button>
                <button class="menu-item" onclick="navigateTo('variance.html')">Variance</button>
                <button class="menu-item" onclick="navigateTo('inventory.html')">Inventory</button>
                <button class="menu-item" onclick="navigateTo('supplies_received.html')">Supplies Received</button>
                <button class="menu-item" onclick="navigateTo('waste.html')">Waste</button>
                <button class="menu-item" id="accountlist" onclick="navigateTo('accountlist.jsp')">Account List</button>
                <button class="menu-item" id="logout" onclick="navigateTo('login.jsp')">Logout</button>
                <!-- Add more buttons as needed -->
            </div>  
            <div class="main-content" id="mainContent">
                <div class="dashboard-bar">
                    <h1 id="dashboardheader">Dashboard</h1>
                </div>
                <!-- Add your main content here -->
            </div>
        </div>
    </body>
</html>
