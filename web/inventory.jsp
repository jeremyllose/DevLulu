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
        <script src="script/transitions.js" defer></script>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    </head>
    <body>
        <div class="dashboardbar">
            <h1 id="dashboardheader">Inventory</h1>
        </div>

        <div class="others">
            <form action="AddItemPageRedirect" method="post">
                <button class="inventory" id="add" type="submit">
                    <img src="photos/plus.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span style="margin-right: 5px;">Add Item</span>
                </button>
            </form>
            <button class="inventory" id="import" onclick="openFileExplorer()">
                <img src="photos/import.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span style="margin-right: 5px;">Import Excel</span></button>
            <form action="i-generateReport.jsp">
                <button class="inventory" id="generate" type="submit">
                    <img src="photos/export.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span style="margin-right: 5px; font-size:23px;">Generate Report</span></button>
            </form>
            <form action="ItemAction" method="post">
                <button class="inventory" id="sort" onclick="redirectTo('i-sort.jsp')"><img src="photos/sort.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span style="margin-right: 5px; font-size:23px;">Sort Options</span></button>
            </form>
            <input type="text" id="searchBar" placeholder="Search..."> 
        </div>
        <form action="ItemAction" method="post">
            <table>
                <thead>
                    <tr>
                        <th><button id="button-css" type="submit" name="button" value="disable" style="background-color: #8f654a; color: white; border:none;">
                                <image src="photos/disable.png" alt="Disable Button" style="width: 20px; height: 20px;"> <b style="font-size: 16px; padding-left: 5px;">Disable Item</b></button></th>
                        <th>Item Code</th>
                        <th>Item No.</th>
                        <th>Description</th>
                        <th>Abbreviation</th>
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
                        ResultSet results = (ResultSet) request.getAttribute("itemRecords");
                        while (results.next()) {%>
                    <tr>
                        <td><input type="checkbox" name="items" value="<%= results.getString("item_code")%>"></td>
                        <td><%=results.getString("item_code")%></td>
                        <td><%=results.getString("item_num")%></td>
                        <td><%=results.getString("item_description")%></td>
                        <td><%=results.getString("abbreviation")%></td>
                        <td><%=results.getString("unit_name")%></td>
                        <td><%=results.getString("transfer_cost")%></td>
                        <td><%=results.getString("gen_name")%></td>
                        <td><%=results.getString("sub_name")%></td>
                        <td><%=results.getString("vat")%></td>
                        <td><%=results.getString("unit_price")%></td>
                        <td>
                            <button id="button-css" type="submit" name="button" value="edit <%= results.getString("item_code")%>">
                                <img id="edit-picture" src="photos/edit-button.png" alt="Edit Button">  Edit
                            </button>
                        </td>
                    </tr>	
                    <%	}
                    %>
                </tbody>
            </table>
        </form>
        <input type="hidden" name="selectedOptions" id="selectedOptions" value="">
        <div id="dateText">Date: July 15, 2024</div>
        <script>
            $("#button1").click(function () {
                $("#myForm").submit(); // Submit the form
            });
        </script>
        <script>
            function openFileExplorer() {
                // Creating an input element of type file
                const fileInput = document.createElement('input');
                fileInput.type = 'file';

                // Setting accept attribute to allow only Excel files
                fileInput.accept = '.xls, .xlsx';

                // Adding an event listener for when a file is selected
                fileInput.addEventListener('change', handleFileSelection);

                // Triggering a click on the file input to open the file explorer
                fileInput.click();

                function handleFileSelection(event) {
                    // Accessing the selected file
                    const selectedFile = event.target.files[0];

                    // You can now perform operations with the selected Excel file
                    // For example, you can read the file using FileReader

                    // Ensure you remove the event listener after handling the file
                    fileInput.removeEventListener('change', handleFileSelection);
                }
            }
        </script>
    </body>
</html>
