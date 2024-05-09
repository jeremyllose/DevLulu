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
                <button  style="position: relative; top: -13rem; right: -0rem;" id="homebutton" onclick="redirectTo('WelcomePageRedirect')"><img src=".\photos\homeicon.png" alt="Home"></button>
                <form id="item-form" action="ItemList" method="post">
                    <button class="menu-item"><img src="photos/Inventory.png" alt="add item Button" style="width: 20px; height: 20px; margin-right: 5px;">Inventory</button>
                </form>
                <form id="product-form" action="ProductRedirect" method="post">
                    <button class="menu-item"><img src="photos/Product.png" alt="add item Button" style="width: 20px; height: 20px; margin-right: 5px;">Recipe</button>
                </form>
                <form id="supplies-form" action="SuppliesRedirectPage" method="post">
                    <button class="menu-item"><img src="photos/SuppliesReceived.png" alt="add item Button" style="width: 20px; height: 20px; margin-right: 5px;">Deliveries</button>
                </form>
                <form id="waste-form" action="WasteRedirect" method="post">
                    <button class="menu-item"><img src="photos/Waste.png" alt="add item Button" style="width: 20px; height: 20px; margin-right: 5px;">Usage</button>
                </form>
                <form id="sales-form" action="SalesRedirect" method="post">
                    <button class="menu-item">
                        <img src="photos/Sales.png" alt="add item Button" style="width: 20px; height: 20px; margin-right: 5px;">Sales</button>
                </form>

                <form id="variance-form" action="VariancePageRedirect" method="post">
                    <button class="menu-item"><img src="photos/Variance.png" alt="add item Button" style="width: 20px; height: 20px; margin-right: 5px;">Variance</button>
                </form>


                <br>
                <%
                    if (!session.getAttribute("userRole").equals("Manager")) {
                %>
                <form id="account-form" action="AccountList" method="post">
                    <button class="menu-item" id="accountlist"><img src="photos/AccountList.png" alt="add item Button" style="width: 20px; height: 20px; margin-right: 5px;">Account List</button>
                </form>
                <form id="account-form" action="ActivtyLog" method="post">
                    <button class="menu-item" id="accountlist"><img src="photos/AccountList.png" alt="add item Button" style="width: 20px; height: 20px; margin-right: 5px;">Activity Log</button>
                </form>
                <form id="editaccount-form" action="editAccount.jsp">
                    <button class="menu-item" id="editaccount"><img src="photos/AccountList.png" alt="add item Button" style="width: 20px; height: 20px; margin-right: 5px;">Edit Account</button>
                </form>
                <%
                } else {
                %>
                <form id="account-form" action="passchange.jsp">
                    <button class="menu-item" id="accountlist"><img src="photos/AccountList.png" alt="add item Button" style="width: 20px; height: 20px; margin-right: 5px;">Edit Account</button>
                </form>
                <%
                    }
                %>

                <br>
                <form id="logout-form" action="Logout">
                    <button class="menu-item" id="logout-button" type="submit" onclick="return confirm('Are you sure you want to logout?')" ><img src="photos/Logout.png" alt="add item Button" style="width: 20px; height: 20px; margin-right: 5px;">Logout</button>
                </form>
            </div>
            <div class="main-content" id="mainContent">
                <img id="leafBG" src="photos/leavebro.png" alt="add item Button">
            </div>
            <footer class="footer">
                <nav>
                    <ul>
                        <li><a href="https://drive.google.com/file/d/1YT25OU0M9b1-x-KUXAZgoQGU8DuF4yNy/view?usp=sharing" target="_blank">Training & Development</a></li>
                        <li><a href="https://docs.google.com/forms/d/e/1FAIpQLScKhqB2z_si3ItCGP-Y77b811sneRnjtJFE5ffr3gEzdlV6HA/viewform?usp=sf_link" target="_blank">Feedback & Suggestions</a></li>
                        <li><a href="https://drive.google.com/file/d/1Lsvbtm3pEIYD4iQWqgN-kdsCgjM-5Mep/view?usp=sharing" target="_blank">Support & Assistance</a></li>
                    </ul>
                </nav>
                <p>&copy; 2024 NextGen Cafe</p>
            </footer>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const salesButton = document.getElementById('sales-form');
                    const productButton = document.getElementById('product-form');
                    const varianceButton = document.getElementById('variance-form');
                    const itemButton = document.getElementById('item-form');
                    const suppliesButton = document.getElementById('supplies-form');
                    const wasteButton = document.getElementById('waste-form');
                    const accountButton = document.getElementById('account-form');
                    const editButton = document.getElementById('editaccount-form');
                    const logoutButton = document.getElementById('logout-form');
                    salesButton.addEventListener('click', function (event) {
                        event.preventDefault();
                        document.body.style.opacity = 0;
                        setTimeout(function () {
                            document.body.style.opacity = 1;
                            document.getElementById('sales-form').submit();
                        }, 200);
                    });

                    // Add event listeners for other buttons following a similar pattern
                    productButton.addEventListener('click', function (event) {
                        event.preventDefault();
                        document.body.style.opacity = 0;
                        setTimeout(function () {
                            document.body.style.opacity = 1;
                            document.getElementById('product-form').submit();
                        }, 200);
                    });

                    varianceButton.addEventListener('click', function (event) {
                        event.preventDefault();
                        document.body.style.opacity = 0;
                        setTimeout(function () {
                            document.body.style.opacity = 1;
                            document.getElementById('variance-form').submit();
                        }, 200);
                    });

                    itemButton.addEventListener('click', function (event) {
                        // Prevent default form submission
                        event.preventDefault();

                        // Trigger page transition animation
                        document.body.style.opacity = 0;

                        // After animation (adjust time based on your animation duration)
                        setTimeout(function () {
                            // Revert animation
                            document.body.style.opacity = 1;

                            // Submit the form after animation completes
                            document.getElementById('item-form').submit();
                        }, 200); // Adjust this value based on your transition duration (in milliseconds)
                    });

                    suppliesButton.addEventListener('click', function (event) {
                        event.preventDefault();
                        document.body.style.opacity = 0;
                        setTimeout(function () {
                            document.body.style.opacity = 1;
                            document.getElementById('supplies-form').submit();
                        }, 200);
                    });

                    wasteButton.addEventListener('click', function (event) {
                        event.preventDefault();
                        document.body.style.opacity = 0;
                        setTimeout(function () {
                            document.body.style.opacity = 1;
                            document.getElementById('waste-form').submit();
                        }, 200);
                    });

                    accountButton.addEventListener('click', function (event) {
                        event.preventDefault();
                        document.body.style.opacity = 0;
                        setTimeout(function () {
                            document.body.style.opacity = 1;
                            document.getElementById('account-form').submit();
                        }, 200);
                    });

                    editButton.addEventListener('click', function (event) {
                        event.preventDefault();
                        document.body.style.opacity = 0;
                        setTimeout(function () {
                            document.body.style.opacity = 1;
                            document.getElementById('editaccount-form').submit();
                        }, 200);
                    });

                    logoutButton.addEventListener('click', function (event) {
                        event.preventDefault();
                        document.body.style.opacity = 0;
                        setTimeout(function () {
                            document.body.style.opacity = 1;
                            document.getElementById('logout-form').submit();
                        }, 200);
                    });
                });
            </script>
    </body>
</html>
