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
        <link rel="stylesheet" href="styles/suppliesreceived.css">
        <title>Supplies Received Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
              <div class="dashboardbar">
                    <h1 id="dashboardheader">Supplies Received</h1></div>
                    <button class="inventory" id="generate" onclick="redirectTo('sr-generateReport.jsp')">Generate Report</button>
                    <button class="inventory" id="sort" onclick="redirectTo('sr-sort.jsp')">Sort Options</button>
                    <input type="text" id="searchBar" placeholder="Search..."> 
                    <br>
                     
        <table>
            <thead>
                <tr>
                    <th>Selector</th>
                    <th>No.</th>
                    <th>Item Description</th>
                    <th>Gen Class</th>
                    <th>Sub Class</th>
                    <th>Unit</th>
                    <th>1</th>
                    <th>2</th>
                    <th>3</th>
                    <th>4</th>
                    <th>5</th>
                    <th>6</th>
                    <th>7</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">1</td>
                    <td>Butter</td>
                    <td>Food Item</td>
                    <td>Cake</td>
                    <td>PC</td>
                    <td>8</td>
                    <td>-</td>
                    <td>2</td>
                    <td>-</td>
                    <td>2</td>
                    <td>0</td>
                    <td>-</td>
                </tr>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">1</td>
                    <td>Butter</td>
                    <td>Food Item</td>
                    <td>Cake</td>
                    <td>PC</td>
                    <td>-</td>
                    <td>2</td>
                    <td>2</td>
                    <td>4</td>
                    <td>2</td>
                    <td>0</td>
                    <td>-</td>
                </tr>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">1</td>
                    <td>Butter</td>
                    <td>Food Item</td>
                    <td>Cake</td>
                    <td>PC</td>
                    <td>8</td>
                    <td>2</td>
                    <td>2</td>
                    <td>3</td>
                    <td>2</td>
                    <td>0</td>
                </tr>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">2</td>
                    <td>Alcohol</td>
                    <td>Supplies</td>
                    <td>Cleaning</td>
                    <td>GAL</td>
                    <td>6</td>
                    <td>4</td>
                    <td>3</td>
                    <td>2</td>
                    <td>1</td>
                    <td>-</td>
                    <td>-</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">1</td>
                    <td>Butter</td>
                    <td>Food Item</td>
                    <td>Cake</td>
                    <td>PC</td>
                    <td>8</td>
                    <td>2</td>
                    <td>-</td>
                    <td>-</td>
                    <td>2</td>
                    <td>0</td>
                    <td>0</td>
                </tr>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">2</td>
                    <td>Alcohol</td>
                    <td>Supplies</td>
                    <td>Cleaning</td>
                    <td>GAL</td>
                    <td>6</td>
                    <td>4</td>
                    <td>-</td>
                    <td>2</td>
                    <td>-</td>
                    <td>0</td>
                    <td>0</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">1</td>
                    <td>Butter</td>
                    <td>Food Item</td>
                    <td>Cake</td>
                    <td>PC</td>
                    <td>8</td>
                    <td>2</td>
                    <td>-</td>
                    <td>3</td>
                    <td>2</td>
                    <td>0</td>
                    <td>-</td>
                </tr>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">2</td>
                    <td>Alcohol</td>
                    <td>Supplies</td>
                    <td>Cleaning</td>
                    <td>GAL</td>
                    <td>6</td>
                    <td>4</td>
                    <td>3</td>
                    <td>2</td>
                    <td>1</td>
                    <td>0</td>
                    <td>0</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">3</td>
                    <td>Bleach</td>
                    <td>Supplies</td>
                    <td>Cleaning</td>
                    <td>PC</td>
                    <td>-</td>
                    <td>6</td>
                    <td>3</td>
                    <td>-</td>
                    <td>1</td>
                    <td>0</td>
                    <td>0</td>
                </tr>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">4</td>
                    <td>Baking Spray</td>
                    <td>Food Item</td>
                    <td>Cake</td>
                    <td>CAN</td>
                    <td>43</td>
                    <td>21</td>
                    <td>2</td>
                    <td>-</td>
                    <td>1</td>
                    <td>0</td>
                    <td>0</td>
                </tr>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">1</td>
                    <td>Butter</td>
                    <td>Food Item</td>
                    <td>Cake</td>
                    <td>PC</td>
                    <td>8</td>
                    <td>2</td>
                    <td>2</td>
                    <td>3</td>
                    <td>2</td>
                    <td>-</td>
                    <td>0</td>
                </tr>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">1</td>
                    <td>Butter</td>
                    <td>Food Item</td>
                    <td>Cake</td>
                    <td>PC</td>
                    <td>8</td>
                    <td>2</td>
                    <td>2</td>
                    <td>3</td>
                    <td>2</td>
                    <td>0</td>
                    <td>2</td>
                </tr>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">1</td>
                    <td>Butter</td>
                    <td>Food Item</td>
                    <td>Cake</td>
                    <td>PC</td>
                    <td>8</td>
                    <td>2</td>
                    <td>2</td>
                    <td>3</td>
                    <td>2</td>
                    <td>0</td>
                    <td>5</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">2</td>
                    <td>Alcohol</td>
                    <td>Supplies</td>
                    <td>Cleaning</td>
                    <td>GAL</td>
                    <td>6</td>
                    <td>4</td>
                    <td>3</td>
                    <td>-</td>
                    <td>1</td>
                    <td>0</td>
                    <td>6</td>
                </tr>
                 <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">3</td>
                    <td>Bleach</td>
                    <td>Supplies</td>
                    <td>Cleaning</td>
                    <td>PC</td>
                    <td>13</td>
                    <td>-</td>
                    <td>-</td>
                    <td>4</td>
                    <td>1</td>
                    <td>0</td>
                    <td>8</td>
                </tr>
            </tbody>
        </table> 
                      <div id="dateText">Date: July 15, 2024</div>
                      <div id="costs">Total Delivery Costs:</div>
                      <input type="text" id="deliverycost" name="myText" placeholder="304,299">
    </body>
</html>
