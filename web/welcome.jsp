<%-- 
    Document   : welcome
    Created on : Jan 19, 2024, 10:21:51 AM
    Author     : Cesar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="commons.jsp"%>
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
