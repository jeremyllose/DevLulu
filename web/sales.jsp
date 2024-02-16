<%-- 
    Document   : inventory
    Created on : Jan 30, 2024, 9:34:46 PM
    Author     : jeremy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="commons.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/sales.css">
        <title>Sales Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
              <div class="dashboardbar">
                    <h1 id="dashboardheader">Sales</h1></div>
                    <button class="inventory" id="add" onclick="redirectTo('s-addProduct.jsp')">Add Product</button>
                    <button class="inventory" id="generate" onclick="redirectTo('s-editProduct.jsp')">Edit Product</button>
                    <button class="inventory" id="sort" onclick="redirectTo('s-deleteProduct.jsp')">Delete Product</button>
                    <input type="text" id="searchBar" placeholder="Search..."> 
                     
                      
                       
           <table>
            <thead>
                <tr>
                    <th>Selector</th>
                    <th>Description</th>
                    <th>Quantity</th>
                    <th>SRP</th>
                    <th>Costp</th>
                    <th>Costper</th>
                    <th>Gross Profit</th>
                    <th>Barcode</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Bacon Fried Rice</td>
                    <td>15</td>
                    <td>180</td>
                    <td>0</td>
                    <td>0</td>
                    <td>2160.00</td>
                    <td>001</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Spam Garlic Fried Rice</td>
                    <td>20</td>
                    <td>160</td>
                    <td>0</td>
                    <td>0</td>
                    <td>3245.00</td>
                    <td>002</td>
                </tr>
                     <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Bacon Fried Rice</td>
                    <td>15</td>
                    <td>180</td>
                    <td>0</td>
                    <td>0</td>
                    <td>2160.00</td>
                    <td>001</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Spam Garlic Fried Rice</td>
                    <td>20</td>
                    <td>160</td>
                    <td>0</td>
                    <td>0</td>
                    <td>3245.00</td>
                    <td>002</td>
                </tr>
                     <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Bacon Fried Rice</td>
                    <td>15</td>
                    <td>180</td>
                    <td>0</td>
                    <td>0</td>
                    <td>2160.00</td>
                    <td>001</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Spam Garlic Fried Rice</td>
                    <td>20</td>
                    <td>160</td>
                    <td>0</td>
                    <td>0</td>
                    <td>3245.00</td>
                    <td>002</td>
                </tr>
                     <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Bacon Fried Rice</td>
                    <td>15</td>
                    <td>180</td>
                    <td>0</td>
                    <td>0</td>
                    <td>2160.00</td>
                    <td>001</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Spam Garlic Fried Rice</td>
                    <td>20</td>
                    <td>160</td>
                    <td>0</td>
                    <td>0</td>
                    <td>3245.00</td>
                    <td>002</td>
                </tr>
                     <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Original Waffle</td>
                    <td>10</td>
                    <td>79</td>
                    <td>0</td>
                    <td>0</td>
                    <td>2160.00</td>
                    <td>003</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">French Fries</td>
                    <td>50</td>
                    <td>89</td>
                    <td>0</td>
                    <td>0</td>
                    <td>4370.00</td>
                    <td>004</td>
                </tr>
                       <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Original Waffle</td>
                    <td>10</td>
                    <td>79</td>
                    <td>0</td>
                    <td>0</td>
                    <td>2160.00</td>
                    <td>003</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">French Fries</td>
                    <td>50</td>
                    <td>89</td>
                    <td>0</td>
                    <td>0</td>
                    <td>4370.00</td>
                    <td>004</td>
                </tr>
                         <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Original Waffle</td>
                    <td>10</td>
                    <td>79</td>
                    <td>0</td>
                    <td>0</td>
                    <td>2160.00</td>
                    <td>003</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">French Fries</td>
                    <td>50</td>
                    <td>89</td>
                    <td>0</td>
                    <td>0</td>
                    <td>4370.00</td>
                    <td>004</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Bacon Fried Rice</td>
                    <td>15</td>
                    <td>180</td>
                    <td>0</td>
                    <td>0</td>
                    <td>2160.00</td>
                    <td>001</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">Spam Garlic Fried Rice</td>
                    <td>20</td>
                    <td>160</td>
                    <td>0</td>
                    <td>0</td>
                    <td>3245.00</td>
                    <td>002</td>
                </tr>
</tbody>
</table>            
                    <div id="dateText">Date: July 15, 2024</div>
                      <div id="costs">Total:</div>
                      <input type="text" id="inventoryprice" name="myText" placeholder="29,061">
    </body>
</html>
