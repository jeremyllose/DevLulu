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
                <button class="menu-item" id="homebutton" onclick="redirectTo('welcome.jsp')"><img src=".\photos\dashboardlogo.png" alt="Home"></button>
                <button class="menu-item" onclick="redirectTo('sales.jsp')">Sales</button>
                <button class="menu-item" onclick="redirectTo('product.jsp')">Product</button>
                <button class="menu-item" onclick="redirectTo('variance.jsp')">Variance</button>
                <form action="ItemList" method="post">
                    <button class="menu-item">Inventory</button>
                </form>
                <button class="menu-item" onclick="redirectTo('suppliesreceived.jsp')">Supplies Received</button>
                <button class="menu-item" onclick="redirectTo('waste.jsp')">Waste</button>
                <form action="AccountList" method="post">
                    <button class="menu-item" id="accountlist">Account List</button>
                </form>
                <form action="Logout">
                    <button class="menu-item" id="logout"  type="submit" onclick="return confirm('Are you sure you want to logout?')" >Logout</button>
                </form>
            </div>  
            <style>
                .container {
                display: flex;
                height: 100vh;
                }
                .sidebar {
                width: 200px;
                background-color: #bfefbb;
                padding-top: 200px;
                color: white;
                text-align: center;
                }
                .menu-item {
                width: 100%;
                padding: 10px;
                margin: 5px;
                text-decoration: none;
                color: white;
                background-color: #bfefbb;
                border: none;
                cursor: pointer;
                color: black;
                font-size: 20px;
                position: relative;
                right: 5px;
                }

                .menu-item:hover {
                background-color: #8f654a;
                color: white;
                }	
                #homebutton img {

                max-width: 200%;
                max-height: 200%;
                object-fit: contain;
                }
                #homebutton{
                width: 200px; 
                height: 100px; 
                position: relative;
                bottom: 220px;
                right: 5px;
                }
                #homebutton:hover{
                background-color: initial;
                }
                #accountlist {
                width: 100%;
                margin: 5px;
                position: relative;
                top: 100px;
                right: 5px;
                }
                #logout{
                background-color: #8f654a;
                color: white;
                position: relative;
                top: 155px;
                right: 5px;
                }
            </style>
            <div class="main-content" id="mainContent">
                <div class="dashboardbar">
                    <h1 id="dashboardheader">Dashboard</h1>

                </div>
                <!-- Add your main content here -->
                <img id="charts"src=".\photos\Charts.png" alt="Charts">
            </div>
        </div>
    </body>
</html>
