<%-- 
    Document   : welcome
    Created on : Jan 19, 2024, 10:21:51 AM
    Author     : Cesar
--%>

<%@page import="java.util.Date"%>
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
        <script>
            if (window.history.replaceState)
            {
                window.history.replaceState(null, null, window.location.href);
            }
        </script>
        <div class="content-wrapper">
            <%                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

                if (session.getAttribute("username") == null) {
                    response.sendRedirect("login.jsp");
                }
            %>
            <div class="main-content" id="mainContent">
                <div class="dashboardbar">
                    <h1 id="dashboardheader">Dashboard</h1>

                </div>
                <!-- Add your main content here -->
                <img id="Coffee" src="photos/CBFR.png" alt="add item Button">
                <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.2/dist/chart.umd.min.js"></script>
                <body>


                    <div class="box">
                        <h1 id="OSC">Overall Sales Line Chart</h1>   
                        <div style="background-color: #522e14"  class="chart-container">
                            <canvas style="background-color: #f4eebe;" id="sales"></canvas>
                                <%
                                    String[] top5 = (String[]) request.getAttribute("topFiveDescriptions");
                                    double[] top5Prices = (double[]) request.getAttribute("topFiveTotal");
                                    int[] quantites = (int[]) request.getAttribute("quantites");
                                    double[] solds = (double[]) request.getAttribute("solds");
                                    String[] dates = (String[]) request.getAttribute("dates");
                                %>
                            <script>
            const sales = document.getElementById('sales');
            const labels = ['<%=dates[0]%>', '<%=dates[1]%>', '<%=dates[2]%>', '<%=dates[3]%>', '<%=dates[4]%>'];
            const data = {
                labels: labels,
                datasets: [
                    {
                        label: 'Sold',
                        data: [<%=solds[0]%>, <%=solds[1]%>, <%=solds[2]%>, <%=solds[3]%>, <%=solds[4]%>],
                        fill: false,
                        borderColor: 'rgb(55, 160, 58)',
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
                                color: 'rgb(82,46,20)'
                            }
                        }
                    }
                }
            });
                            </script>
                        </div>
                        <div class="graphBox">
                            <div style="background-color: #522e14;" class="box">
                                <canvas style="background-color: #f4eebe;"id="myChart"></canvas>     
                                <script>
                                    const ctx = document.getElementById('myChart');

                                    new Chart(ctx, {
                                        type: 'pie',
                                        data: {
                                            labels: ['<%=top5[0]%>', '<%=top5[1]%>', '<%=top5[2]%>', '<%=top5[3]%>', '<%=top5[4]%>'],
                                            datasets: [{
                                                    label: 'Best Sellers',
                                                    data: [<%=quantites[0]%>, <%=quantites[1]%>, <%=quantites[2]%>, <%=quantites[3]%>, <%=quantites[4]%>],
                                                    backgroundColor: ['rgb(255, 99, 132)', 'rgb(54, 162, 235)', 'rgb(255, 205, 86)', 'rgb(127,203,42)', 'rgb(128, 0, 128)'],
                                                    hoverOffset: 4
                                                }]
                                        }
                                    });
                                </script>
                            </div>

                            <div class="chart-info">
                                <div class="info">        
                                    <h2 style="color: #333; font-size: 24px; text-align: center; position: relative; right: -1.5rem;">Best Sellers</h2>
                                    <ol style="text-align: center;">
                                        <li style="color: #333;">
                                            <%= top5[0]%>
                                            <span style="margin-left: 5px;">🔴</span>
                                        </li>
                                        <li style="color: #333;">
                                            <%= top5[1]%>
                                            <span style="margin-left: 5px;">🟡</span>
                                        </li>
                                        <li style="color: #333;">
                                            <%= top5[2]%>
                                            <span style="margin-left: 5px;">🟢</span>
                                        </li>
                                        <li style="color: #333;">
                                            <%= top5[3]%>
                                            <span style="margin-left: 5px;">🔵</span>
                                        </li>
                                        <li style="color: #333;">
                                            <%= top5[4]%>
                                            <span style="margin-left: 5px;">🟣</span>
                                        </li>
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