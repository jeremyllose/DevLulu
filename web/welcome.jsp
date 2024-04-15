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
                            <%
                                    String[] top5 = (String[]) request.getAttribute("topFiveDescriptions");
                                    double[] top5Prices = (double[]) request.getAttribute("topFiveTotal");
                                    int[] quantites = (int[]) request.getAttribute("quantites");
                                %>
                            <script>
                                const sales = document.getElementById('sales');
                                const labels = ['<%=top5[0]%>', '<%=top5[1]%>', '<%=top5[2]%>', '<%=top5[3]%>', '<%=top5[4]%>'];
                                const data = {
                                    labels: labels,
                                    datasets: [
                                        {
                                            label: 'Sold',
                                            data: [<%=top5Prices[0]%>, <%=top5Prices[1]%>, <%=top5Prices[2]%>, <%=top5Prices[3]%>, <%=top5Prices[4]%>],
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
                                            labels: ['<%=top5[0]%>', '<%=top5[1]%>', '<%=top5[2]%>', '<%=top5[3]%>', '<%=top5[4]%>'],
                                            datasets: [{
                                                label: 'Best Sellers',
                                                data: [<%=quantites[0]%>, <%=quantites[1]%>, <%=quantites[2]%>, <%=quantites[3]%>, <%=quantites[4]%>],
                                                backgroundColor: ['rgb(255, 99, 132)', 'rgb(54, 162, 235)', 'rgb(255, 205, 86)', 'rgb(0, 128, 0)', 'rgb(128, 0, 128)'],
                                                hoverOffset: 4
                                            }]
                                        }
                                    });
                                </script>

                            </div>
                            <div class="info">
                                <div class="box">
                                <div class="chart-info">
                                    <h2>Best Sellers</h2>
                                    <ol>
                                        <li><%=top5[0]%><span style="background-color: red"></span></li>
                                        <li><%=top5[1]%><span style="background-color: yellow"></span></li>
                                        <li><%=top5[2]%><span style="background-color: green"></span></li>
                                        <li><%=top5[3]%><span style="background-color: blue"></span></li>
                                        <li><%=top5[4]%><span style="background-color: purple"></span></li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </body>
            </div>
        </div>
    </div>
    </div>
</body>
</html>