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
        <link rel="stylesheet" href="styles/dashboardfinal.css">

        <title>Dashboard Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <div class="content-wrapper">
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

                    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.2/dist/chart.umd.min.js"></script>
                    <body>
                        <div class="box">
                            <canvas id="sales"></canvas>
                            <script>
                                const sales = document.getElementById('sales');
                                const labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July'];
                                const data = {
                                    labels: labels,
                                    datasets: [
                                        {
                                            label: 'Sales',
                                            data: [65, 59, 80, 81, 56, 55, 40],
                                            fill: false,
                                            borderColor: 'rgb(75, 192, 192)',
                                            tension: 0.1
                                        },
                                        {
                                            label: 'Pie',
                                            data: [70, 32, 100, 91, 26, 55, 70],
                                            fill: false,
                                            borderColor: 'rgb(75, 255, 255)',
                                            tension: 0.1
                                        }
                                    ]
                                };

                                new Chart(sales, {
                                    type: 'line',
                                    data: data,
                                    options: {
                                        plugins: {
                                            legend: {
                                                display: true,
                                                labels: {
                                                    color: 'rgb(255, 99, 132)'
                                                }
                                            }
                                        }
                                    }
                                });
                            </script>
                        </div>
                        <div class="graphBox">
                            <div class="box">
                                <canvas id="myChart"></canvas>
                                <script>
                                    const ctx = document.getElementById('myChart');

                                    new Chart(ctx, {
                                        type: 'pie',
                                        data: {
                                            labels: ['Red', 'Blue', 'Yellow'],
                                            datasets: [{
                                                label: 'Best Sellers',
                                                data: [300, 50, 100],
                                                backgroundColor: ['rgb(255, 99, 132)', 'rgb(54, 162, 235)', 'rgb(255, 205, 86)'],
                                                hoverOffset: 4
                                            }]
                                        }
                                    });
                                </script>

                            </div>
                            <div class="info">
                                <div class="chart-info">
                                    <h2>Best Sellers</h2>
                                    <ol>
                                        <li>Sausage Fried Rice <span style="background-color: red"></span></li>
                                        <li>Ham Fried Rice <span style="background-color: yellow"></span></li>
                                        <li>Spam Fried Rice <span style="background-color: green"></span></li>
                                        <li>Sausage Waffle <span style="background-color: blue"></span></li>
                                        <li>Spam Waffle <span style="background-color: purple"></span></li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </body>
            </div>
        </div>
    </div>
</body>
</html>
