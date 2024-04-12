<%-- 
    Document   : dashboardfinal
    Created on : 04 12, 24, 8:23:07 PM
    Author     : BioStaR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="dashboard final.css">
        <title>dashboard final</title>
    </head>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.2/dist/chart.umd.min.js"></script>
    <script src="my_chart.js"></script>
    <body>
        <div class="graphBox">
            <div class="box">
                <canvas id="myChart"></canvas>
            </div>
            <div class="box">
                <canvas id="sales"></canvas>
            </div>
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
            <div id="inventory">
                <h2>Inventory</h2>
                <p><b>Inventory Price:</b> </p>
                <p><b>Inventory Count:</b> </p>
            </div>
        </div>
    </body>
    <script>
        95% of storage used … If you run out, you can't create, edit, and upload files. Get 100 GB of storage for ₱89.00 ₱0 for 1 month.
const ctx = document.getElementById('myChart');
const sales = document.getElementById('sales');


	  new Chart(ctx, {
		type: 'pie',
		data: {
		  labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
		  datasets: [{
			label: '# of Votes',
			data: [12, 19, 3, 5, 2, 3],
			borderWidth: 1
		  }]
		},
		options: {
		  responsive: true;
		}
	  });

	  new Chart(sales, {
		type: 'line',
		data: {
		  labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
		  datasets: [{
			label: '# of Votes',
			data: [12, 19, 3, 5, 2, 3],
			borderWidth: 1
		  }]
		},
		options: {
		  responsive: true;
		}
	  });
          </script>
</html>