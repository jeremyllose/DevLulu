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
        <%
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

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

                <form action="ExcelServlet" method="post">
                    <button class="inventory" id="generate" type="submit">
                        <img src="photos/export.png" alt="generate report Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span class="inventory-text" style="margin-right: 5px">Gen Report</span></button>
                </form>
                <form action="ItemSort" method="post">
                    <button class="inventory" id="sort" ><img src="photos/sort.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span class="inventory-text" style="margin-right: 5px;">Sort Options</span></button>
                </form>
                <form action="UploadServlet" method="post" enctype="multipart/form-data">
                    <input type="file" name="file" id="fileInput" style="display: none;"/>
                    <label for="fileInput" class="inventory" id="import" style="padding-top: 8px;">
                        <img src="photos/import.png" alt="import excel Button" style="width: 20px; height: 20px; margin-right: 5px;">
                        Import Excel</label>
                    <input id="upload" type="submit" value="Upload" />

                    <script>
                        function showFileName() {
                            var input = document.getElementById('fileInput');
                            var fileNameDisplay = document.getElementById('selectedFileName');
                            fileNameDisplay.textContent = input.files[0].name;
                        }
                    </script>
                </form>
                <form action="ItemSearch" method="post">
                    <div id="searchContainer">
                        <input type="text" id="searchBar" name="searchBar" placeholder="Search...">
                        <button id="search" type="submit">
                            <img src="photos/searchicon.png" alt="Search Icon">
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
            <%
                Integer itemPgNum = (Integer) session.getAttribute("itemPgNum");
                Integer totalPages = (Integer) session.getAttribute("itemPages");
                
                
                int currentPage = itemPgNum != null ? itemPgNum : 1;
                int totalPg = totalPages != null ? totalPages : 1;
            %>
        <form action="ItemList" method="post">
            <table>
            <tr>
                <%
                    if ((currentPage -2) >= 0 && (currentPage -2) != 0) {
                %>
                <td><input type="submit" name="button" value="<%=currentPage -2%>"></td>
                <%
                    }
                %>
                <%
                    if ((currentPage -1) != 0) {
                %>
                <td><input type="submit" name="button" value="<%=currentPage -1%>"></td>
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
                <td><input type="submit" name="button" value="<%= currentPage + 2%>"></td>
                <%
                    }
                %>
            </tr>
        </table>
        </form>
                    </div>
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

    </body>
</html>
