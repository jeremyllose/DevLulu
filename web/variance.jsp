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
        <link rel="stylesheet" href="styles/variance.css">
        <title>Variance Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <div class="dashboardbar">
            <h1 id="dashboardheader">Variance</h1></div>
        <button class="inventory" id="add" onclick="redirectTo('v-addItem.jsp')">Add Item</button>
        <button class="inventory" id="generate" onclick="redirectTo('v-generateReport.jsp')">Generate Report</button>
        <button class="inventory" id="sort" onclick="redirectTo('v-sort.jsp')">Sort Options</button>
        <input type="text" id="searchBar" placeholder="Search...">   

        <table>
            <thead>
                <tr>
                    <th>Selector</th>
                    <th>No.</th>
                    <th>Item Description</th>
                    <th>Gen Class</th>
                    <th>Sub Class</th>
                    <th>Unit</th>
                    <th>Beg</th>
                    <th>End</th>
                    <th>Total</th>
                    <th>Exp</th>
                    <th>Actual</th>
                    <th>Var</th>
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
                    <td>2</td>
                    <td>2</td>
                    <td>3</td>
                    <td>2</td>
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
                    <td>0</td>
                </tr>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">3</td>
                    <td>Bleach</td>
                    <td>Supplies</td>
                    <td>Cleaning</td>
                    <td>PC</td>
                    <td>13</td>
                    <td>6</td>
                    <td>3</td>
                    <td>4</td>
                    <td>1</td>
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
                    <td>12</td>
                    <td>1</td>
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
                    <td>0</td>
                </tr>
                <tr>
                    <td rowspan="1"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="1">3</td>
                    <td>Bleach</td>
                    <td>Supplies</td>
                    <td>Cleaning</td>
                    <td>PC</td>
                    <td>13</td>
                    <td>6</td>
                    <td>3</td>
                    <td>4</td>
                    <td>1</td>
                    <td>0</td>
                </tr>
            </tbody>
        </table> 
        <div id="dateText">Date: July 15, 2024</div>
        <div id="costs">Inventory Price:</div>
        <input type="text" id="inventoryprice" name="myText" placeholder="35,077">
        <div id="costs">Count:</div>
        <input type="text" id="inventoryprice" name="myText" placeholder="224">  

    </body>
</html>
