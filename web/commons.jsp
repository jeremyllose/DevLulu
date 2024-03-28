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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
        <title>JSP Page</title>
    </head>
    <body>

        <div class="container">
            <div class="sidebar">
                <button id="homebutton" onclick="redirectTo('welcome.jsp')"><img src=".\photos\dashboardlogo.png" alt="Home"></button>
                <button class="menu-item" onclick="redirectTo('sales.jsp')">Sales</button>
                <form action="ProductRedirect" method="post">
                    <button class="menu-item">Product</button>
                </form>
                <form action="VariancePageRedirect" method="post">
                    <button class="menu-item">Variance</button>
                </form>
                <form id="menu-form" action="ItemList" method="post">
                    <button class="menu-item">Inventory</button>
                </form>
                <form action="SuppliesRedirectPage" method="post">
                    <button class="menu-item">Supplies Received</button>
                </form>
                <form action="WasteRedirect" method="post">
                    <button class="menu-item">Waste</button>
                </form>
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
                <form id="logout-form" action="Logout">
                    <button class="menu-item" id="logout"  type="submit" onclick="return confirm('Are you sure you want to logout?')" >Logout</button>
                </form>
            </div>
            <div class="main-content" id="mainContent">
                <!-- no div tag closing, if added layout issues show-->

                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const menuButton = document.getElementById('menu-form');
                        const logoutButton = document.getElementById('logout-form');

                        menuButton.addEventListener('click', function (event) {
                            // Prevent default form submission
                            event.preventDefault();

                            // Trigger page transition animation
                            document.body.style.opacity = 0;

                            // After animation (adjust time based on your animation duration)
                            setTimeout(function () {
                                // Revert animation
                                document.body.style.opacity = 1;

                                // Submit the form after animation completes
                                document.getElementById('menu-form').submit();
                            }, 200); // Adjust this value based on your transition duration (in milliseconds)
                        });
                        
                    logoutButton.addEventListener('click', function (event) {
                    // Prevent default form submission
                    event.preventDefault();
                            // Trigger page transition animation
                            document.body.style.opacity = 0;
                            // After animation (adjust time based on your animation duration)
                            setTimeout(function () {
                            // Revert animation
                            document.body.style.opacity = 1;
                                    // Submit the logout form after animation completes
                                    document.getElementById('logout-form').submit();
                            }, 200); // Adjust this value based on your transition duration (in milliseconds)
                    });
                    });
                </script>

                </body>
                </html>
