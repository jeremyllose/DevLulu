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
        <script>
            if (window.history.replaceState)
            {
                window.history.replaceState(null, null, window.location.href);
            }
        </script>
        <%            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <div class="content-wrapper">
            <div class="dashboardbar">
                <h1 id="dashboardheader">Inventory</h1>
            </div>

            <div class="others">
                <form action="AddItemPageRedirect" method="post">
                    <button class="inventory" id="add" type="submit">
                        <img src="photos/plus.png" alt="add item Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span class="inventory-text" style="margin-right: 5px;">Add Item</span>
                    </button>
                </form>

                <form action="ItemExcelServlet" method="post" onsubmit="return confirmGenerateReport()">
                    <button class="inventory" id="generate" type="submit">
                        <img src="photos/export.png" alt="generate report Button" style="width: 20px; height: 20px; margin-right: 5px;"> 
                        <span class="inventory-text" style="margin-right: 5px">Gen Report</span>
                    </button>
                </form>

                <form action="ItemSort" method="post">
                    <button class="inventory" id="sort" ><img src="photos/sort.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span class="inventory-text" style="margin-right: 5px;">Filter Options</span></button>
                </form>
                <form action="UploadServlet" method="post" enctype="multipart/form-data">
                    <input type="file" name="file" id="fileInput" style="display: none;"/>
                    <label for="fileInput" class="inventory" id="import" style="padding-top: 8px;">
                        <img src="photos/import.png" alt="import excel Button" style="width: 20px; height: 20px; margin-right: 5px;">
                        Import Excel</label>
                    <input id="upload" type="submit" value="Upload" 
                           alt="import excel Button" style="width: 80px; height: 25px; margin-right: 5px; border-radius: 8px;"/>
                    <span style="position: relative; right: 17rem; top: 3rem;" id="selectedFileName"></span>

                    <script>
                        // Get the file input element
                        var fileInput = document.getElementById('fileInput');
                        // Get the upload button element
                        var uploadButton = document.getElementById('uploadButton');
                        // Get the element to display the selected file name
                        var fileNameDisplay = document.getElementById('selectedFileName');

                        // Add event listener for file input change
                        fileInput.addEventListener('change', function () {
                            // Check if the selected file has the correct file extension
                            var allowedExtensions = ['.xlsx', '.xls'];
                            var fileName = this.files[0].name;
                            var fileExtension = fileName.substring(fileName.lastIndexOf('.')).toLowerCase();

                            if (allowedExtensions.indexOf(fileExtension) === -1) {
                                // Display error message if the file extension is not allowed
                                fileNameDisplay.textContent = 'Error: Invalid file format';
                                // Reset the file input to clear the selection
                                this.value = '';
                            } else {
                                // Update the display with the selected file name
                                fileNameDisplay.textContent = fileName;
                            }
                        });

                        // Add event listener to clear error message when upload button is clicked
                        uploadButton.addEventListener('click', function () {
                            fileNameDisplay.textContent = '';
                        });
                    </script>
                </form>
                <form action="ItemSearch" method="post">
                    <div class="searchContainer">
                        <input type="text" id="searchBar" name="searchBar" placeholder="Search...">
                        <button id="search" type="submit">
                            <img src="photos/greensearch.png" style="width: 47px; height: 47px;" alt="Search Icon">
                        </button>
                    </div>
                </form>
            </div>
            <form action="ItemAction" method="post">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th><button id="disable-css" type="submit" name="button" value="disable" >
                                        <image src="photos/DisableFR.png" alt="Disable Button" style="width: 20px; height: 20px;"></button></th>
                                <th>Item Code <button type="submit" class="sorting" name="button" value="sorting"><span id="ADIcon">&#8597;</span></button> </th>
                                <th>Item No.</th>
                                <th>Description</th>
                                <th>Abbreviation</th>
                                <th>Unit of Measure</th>
                                <th>Transfer Cost <button type="submit" class="sorting" name="button" value="sortingT"><span id="ADIcon">&#8597;</span></button></th>
                                <th>General Class</th>
                                <th>Sub Class</th>
                                <th>VAT</th>
                                <th>Unit Price <button type="submit" class="sorting" name="button" value="sortingU"><span id="ADIcon">&#8597;</span></button></th>
                                <th>Recently Updated</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>

                            <%
                                ResultSet results = (ResultSet) request.getAttribute("itemRecords");
                                while (results.next()) {%>

                            <tr>
                                <%
                                    if (results.getBoolean("disabled") == false) {
                                %>
                                <td><input type="checkbox" name="items" value="<%= results.getString("item_code")%>"></td>
                                    <%
                                    } else {
                                    %>
                                <td><button id="button-css" type="submit" name="button" value="enable <%= results.getString("item_code")%>">Enable</button></td>
                                <%
                                    }
                                %>
                                <td><%=results.getString("item_code")%></td>
                                <td><%=results.getString("item_num")%></td>
                                <td><%=results.getString("item_description")%></td>
                                <td><%=results.getString("abbreviation")%></td>
                                <td><%=results.getString("unit_name")%></td>
                                <td>₱<%=results.getString("transfer_cost")%></td>
                                <td><%=results.getString("gen_name")%></td>
                                <td><%=results.getString("sub_name")%></td>
                                <td><%=results.getString("vat")%></td>
                                <td>₱<%=results.getString("unit_price")%></td>
                                <td><%=results.getString("updated")%></td>
                                <td>
                                    <%
                                        if (results.getBoolean("disabled") == false) {
                                    %>
                                    <button id="button-css" type="submit" name="button" value="edit <%= results.getString("item_code")%>">
                                        <img id="edit-picture" src="photos/edit-button.png" alt="Edit Button">  Edit
                                    </button>
                                    <%
                                    } else {
                                    %>
                                    ITEM DISABLED
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>	
                            <%	}
                            %>
                        </tbody>
                    </table>
            </form> 
            <%
                // Check if the session attribute for addItemMessage exists and display it
                String addItemMessage = (String) request.getAttribute("itemMessage");
                String itemMessage = (String) session.getAttribute("itemMessage");
                if (addItemMessage != null) {
            %>
            <div class="success">
                <%= addItemMessage%>
            </div>
            <%
            } else if (itemMessage != null) {
            %>
            <div class="success">
                <%= itemMessage%>
            </div>
        </div>
        <%
                session.removeAttribute("itemMessage");
            }
        %>
        <%
            Integer itemPgNum = (Integer) session.getAttribute("itemPgNum");
            Integer totalPages = (Integer) session.getAttribute("itemPages");

            int currentPage = itemPgNum != null ? itemPgNum : 1;
            int totalPg = totalPages != null ? totalPages : 1;
        %>
        <form action="ItemList" method="post">
            <table class="pagination">
                <tr>
                    <%
                        if ((currentPage - 2) >= 0 && (currentPage - 2) != 0) {
                    %>
                    <td><input type="submit" name="button" value="<%=currentPage - 2%>"></td>
                        <%
                            }
                        %>
                        <%
                            if ((currentPage - 1) != 0) {
                        %>
                    <td><input type="submit" name="button" value="<%=currentPage - 1%>"></td>
                        <%
                            }
                        %>

                    <td><%= currentPage%></td>

                    <%
                        if ((currentPage + 1) <= totalPg) {
                    %>
                    <td><input type="submit" name="button" value="<%= currentPage + 1%>"></td>
                        <%
                            }
                        %>
                        <%
                            if ((currentPage + 2) <= totalPg) {
                        %>
                    <td><input type="submit"name="button" value="<%= currentPage + 2%>"></td>
                        <%
                            }
                        %>
                </tr>
            </table>
        </form>

    </form>
    <input type="hidden" name="selectedOptions" id="selectedOptions" value="">
    <!--            <div id="dateText">Date: July 15, 2024</div>-->
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
    <script>
    function confirmGenerateReport() {
        // Display confirmation dialog
        var confirmed = confirm('Are you sure you want to generate a report?');
        // Return true to submit the form if confirmed, false otherwise
        return confirmed;
    }
</script>
</div>
</body>
</html>
