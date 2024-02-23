<%-- 
    Document   : inventory
    Created on : Jan 30, 2024, 9:34:46 PM
    Author     : jeremy
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="commons.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/inventory.css">
        <title>Inventory Page</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
        <div class="dashboardbar">
            <h1 id="dashboardheader">Inventory</h1>
        </div>
        
        <form action="i-generateReport.jsp">
             <button class="inventory" id="generate" type="submit">Generate Report</button>
         </form>
        
        <div class="others">
            <form action="AddItemPageRedirect" method="post">
             <button class="inventory" id="add" type="submit">Add Item</button>
            </form>
             <button class="inventory" id="delete" type="submit" name="button" value="disable">Delete Item</button>
            <button class="inventory" id="import" onclick="redirectTo('i-import.jsp')">Import Excel</button>
            <button class="inventory" id="sort" onclick="redirectTo('i-sort.jsp')">Sort Options</button>
        </div>
        <input type="text" id="searchBar" placeholder="Search..."> 
        
        <form action="ItemAction" method="post">
            <button type="submit" name="button" value="disable">Disable</button>
        <table>
            <thead>
                <tr>
                    <th>Selector</th>
                    <th>Item Code</th>
                    <th>Item No.</th>
                    <th>Description</th>
                    <th>Abbriviation</th>
                    <th>Unit of Measurement</th>
                    <th>Transfer Cost</th>
                    <th>General Class</th>
                    <th>Sub Class</th>
                    <th>VAT</th>
                    <th>Unit Price</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ResultSet results = (ResultSet)request.getAttribute("itemRecords");
			while (results.next()) { %>
			<tr>
                                <td><input type="checkbox" name="items" value="<%= results.getString("item_code") %>"></td>
                                <td><%=results.getString("item_code") %></td>
                                <td><%=results.getString("item_num") %></td>
                                <td><%=results.getString("item_description") %></td>
                                <td><%=results.getString("abbriviation") %></td>
                                <td><%=results.getString("uom") %></td>
                                <td><%=results.getString("transfer_cost") %></td>
                                <td><%=results.getString("gen_name") %></td>
                                <td><%=results.getString("sub_name") %></td>
                                <td><%=results.getString("vat") %></td>
                                <td><%=results.getString("unit_price") %></td>
                                <td>
                                    <button type="submit" name="button" value="edit <%= results.getString("item_code") %>">Edit</button>
                                </td>
			</tr>	
		<%	}
		%>
            </tbody>
        </table>
            <input type="hidden" name="selectedOptions" id="selectedOptions" value="">
        </form>
        <div id="dateText">Date: July 15, 2024</div>
        <script>
  $("#button1").click(function() {
    $("#myForm").submit(); // Submit the form
  });
</script>
    </body>
</html>
