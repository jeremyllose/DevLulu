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
        <link rel="stylesheet" href="styles/product.css">
        <title>Product Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <div class="dashboardbar">
            <h1 id="dashboardheader">Product</h1></div>
            <div class="others">
        <button class="inventory" id="add" onclick="redirectTo('p-addProduct.jsp')">Add Product</button>
        <button class="inventory" id="generate" onclick="redirectTo('p-editProduct.jsp')">Edit Product</button>
        <button class="inventory" id="sort" onclick="redirectTo('p-deleteProduct.jsp')">Delete Product</button>
        <input type="text" id="searchBar" placeholder="Search..."> 
            </div>
        <table>
            <thead>
                <tr>
                    <th>Selector</th>
                    <th>Description</th>
                    <th>Item No.</th>
                    <th>Recipe</th>
                    <th>Conversion</th>
                    <th>Quantity</th>
                    <th>Unit</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td rowspan="6"><input type="checkbox" name="selectProduct"></td>
                    <td rowspan="6">Latte</td>
                    <td>40</td>
                    <td>Coffee Beans Mixed</td>
                    <td>1</td>
                    <td>2</td>
                    <td>G</td>
                </tr>
                <tr>

                    <td>41</td>
                    <td>Double Wall Cup Printed</td>
                    <td>3</td>
                    <td>4</td>
                    <td>PC</td>
                </tr>
                <tr>

                    <td>42</td>
                    <td>Coffee Lid Black</td>
                    <td>5</td>
                    <td>6</td>
                    <td>PC</td>
                </tr>
            <td>43</td>
            <td>Wooden Stirrer</td>
            <td>6</td>
            <td>7</td>
            <td>PC</td>
        </tr>
        <td>44</td>
        <td>Plastic Take Out Single</td>
        <td>8</td>
        <td>9</td>
        <td>PC</td>
    </tr>
    <td>45</td>
    <td>Quarterfold Tissue</td>
    <td>10</td>
    <td>11</td>
    <td>PC</td>
</tr>
<td rowspan="6"><input type="checkbox" name="selectProduct"></td>
 <td rowspan="6">Mocha</td>
<td>40</td>
<td>Coffee Beans Mixed</td>
<td>1</td>
<td>2</td>
<td>G</td>
</tr>
<tr>

    <td>41</td>
    <td>Double Wall Cup Printed</td>
    <td>3</td>
    <td>4</td>
    <td>PC</td>
</tr>
<tr>

    <td>42</td>
    <td>Coffee Lid Black</td>
    <td>5</td>
    <td>6</td>
    <td>PC</td>
</tr>
<td>43</td>
<td>Wooden Stirrer</td>
<td>6</td>
<td>7</td>
<td>PC</td>
</tr>
<td>44</td>
<td>Plastic Take Out Single</td>
<td>8</td>
<td>9</td>
<td>PC</td>
</tr>
<td>45</td>
<td>Quarterfold Tissue</td>
<td>10</td>
<td>11</td>
<td>PC</td>
</tr>

<td rowspan="6"><input type="checkbox" name="selectProduct"></td>
 <td rowspan="6">Americano</td>
<td>40</td>
<td>Coffee Beans Mixed</td>
<td>1</td>
<td>2</td>
<td>G</td>
</tr>
<tr>

    <td>41</td>
    <td>Double Wall Cup Printed</td>
    <td>3</td>
    <td>4</td>
    <td>PC</td>
</tr>
<tr>

    <td>42</td>
    <td>Coffee Lid Black</td>
    <td>5</td>
    <td>6</td>
    <td>PC</td>
</tr>
<td>43</td>
<td>Wooden Stirrer</td>
<td>6</td>
<td>7</td>
<td>PC</td>
</tr>
<td>44</td>
<td>Plastic Take Out Single</td>
<td>8</td>
<td>9</td>
<td>PC</td>
</tr>
<td>45</td>
<td>Quarterfold Tissue</td>
<td>10</td>
<td>11</td>
<td>PC</td>
</tr>

<td rowspan="6"><input type="checkbox" name="selectProduct"></td>
 <td rowspan="6">Espresso</td>
<td>40</td>
<td>Coffee Beans Mixed</td>
<td>1</td>
<td>2</td>
<td>G</td>
</tr>
<tr>

    <td>41</td>
    <td>Double Wall Cup Printed</td>
    <td>3</td>
    <td>4</td>
    <td>PC</td>
</tr>
<tr>

    <td>42</td>
    <td>Coffee Lid Black</td>
    <td>5</td>
    <td>6</td>
    <td>PC</td>
</tr>
<td>43</td>
<td>Wooden Stirrer</td>
<td>6</td>
<td>7</td>
<td>PC</td>
</tr>
<td>44</td>
<td>Plastic Take Out Single</td>
<td>8</td>
<td>9</td>
<td>PC</td>
</tr>
<td>45</td>
<td>Quarterfold Tissue</td>
<td>10</td>
<td>11</td>
<td>PC</td>
</tr>
</tbody>
</table>
        
</body>
</html> 
