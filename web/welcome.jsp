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
                <button class="menu-item" onclick="navigateTo('sales.jsp')">Sales</button>
                <button class="menu-item" onclick="navigateTo('product.jsp')">Product</button>
                <button class="menu-item" onclick="navigateTo('variance.jsp')">Variance</button>
                <button class="menu-item" onclick="navigateTo('inventory.jsp')">Inventory</button>
                <button class="menu-item" onclick="navigateTo('suppliesreceived.jsp')">Supplies Received</button>
                <button class="menu-item" onclick="navigateTo('waste.jsp')">Waste</button>
                
                <form action="AccountList" method="post">
                    <button class="menu-item" id="accountlist">Account List</button>
                </form>
                
                <button class="menu-item" id="logout" onclick="navigateTo('login.jsp')">Logout</button>
                <!-- Add more buttons as needed -->
            </div>  
            <div class="main-content" id="mainContent">
                <div class="dashboardbar">
                    <h1 id="dashboardheader">Dashboard</h1>
                    
                </div>
                <!-- Add your main content here -->
                <img id="charts"src=".\photos\Charts.png" alt="Charts">
            </div>
        </div>
        <%
            if (session.getAttribute("verification") != null) {
        %>
        <h4>${verification}</h4>
        <%
            }
        %>
    </body>
</html>
