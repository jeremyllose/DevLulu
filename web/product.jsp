<%-- 
    Document   : inventory
    Created on : Jan 30, 2024, 9:34:46 PM
    Author     : jeremy
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
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
                <h1 id="dashboardheader">Recipe</h1>
            </div>

            <div class="others">
                <form action="AddProductRedirect" method="post">
                    <button type="submit" class="inventory" id="add">
                        <img src="photos/plus.png" alt="plus Button" style="width: 20px; height: 20px; margin-right: 5px;"> <span style="margin-right: 5px;">Add Product</span></button>
                </form>

                <form action="ProductSearch" method="post">
                    <div class="searchContainer">
                        <input type="text" id="searchBar" name="searchBar" placeholder="Search...">
                        <button id="search" type="submit">
                            <img src="photos/greensearch.png" style="width: 46.5px; height: 46.5px;" alt="Search Icon">
                        </button></div>
                </form>
            </div>
            <form action="ProductAction" method="post">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th><button id="disable-css" type="submit" name="button" value="disable">
                                        <image id="disablebutton" src="photos/DisableFR.png" alt="Disable Button"></button>
                                </th>
                                <th>Product Code</th>
                                <th>Product Description</th>                       
                                <th>Product Price <button  class="sorting" type="submit" name="button" value="PByPrice"><span id="productPriceIcon">&#8597;</span></button></th>
                                <th>Quantity <button class="sorting" type="submit" name="button" value="PByQuantity"><span id="productQuantityIcon">&#8597;</span></button> </th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                DecimalFormat formatter = new DecimalFormat("#,##0.00");
                                ResultSet results = (ResultSet) request.getAttribute("product");
                                while (results.next()) {%>
                            <tr>
                                <%
                                    if (results.getBoolean("disabled") == false) {
                                %>
                                <td><input type="checkbox" name="selectProduct" value="<%= results.getString("product_code")%>"></td>
                                    <%
                                    } else {
                                    %>
                                <td>
                                    <input id="button-css" type="submit" name="button" value="Enable">
                                    <input type="hidden" name="enable" value="<%= results.getString("product_code")%>">
                                </td>
                                <%
                                    }
                                %>
                                <td><%=results.getString("product_code")%></td>
                                <td><%=results.getString("product_description")%></td>
                                <td>₱<% 
                                    String formattedValue = formatter.format(results.getDouble("product_price"));
                                    out.print(formattedValue);%></td>
                                
                                <%
                                    if (results.getBoolean("disabled") == false) {
                                %>
                                <td><input type="number" min="0" name="qty" value="<%=results.getString("quantity")%>" required/></td>
                                    <%
                                    } else {
                                    %>
                                <td>
                                    PRODUCT DISABLED
                                </td>
                                <%
                                    }
                                %>
                                
                                <td>
                                    <%
                                        if (results.getBoolean("disabled") == false) {
                                    %>
                                    <button id="button-css" type="submit" name="button" value="edit <%= results.getString("product_code")%>">
                                        <img id="edit-picture" src="photos/edit-button.png" alt="Edit Button">  Edit
                                    </button>
                                    <input type="hidden" name="products" value="<%= results.getString("product_code")%>">
                                    <%
                                    } else {
                                    %>
                                    PRODUCT DISABLED
                                    <%
                                        }
                                    %>
                                </td>
    <!--                            <td class="hide-column"><input type="hidden" name="products" value="<%= results.getString("product_code")%>"></td>-->
                            </tr>
                            <%	}
                            %>
                        </tbody>
                    </table>
                </div>
                <!--                <th><button type="submit" class="inventory">
                                        <image src="photos/save.png" alt="Save Button" style="width: 20px; height: 20px;"> <span style=" padding-left: 5px;">Save Changes</span></button></th>-->
                
                <div class="others"><button id="savechanges" type="submit" class="inventory" name="button" value="save">
                        <image src="photos/save.png" alt="Save Button" style="width: 20px; height: 20px;"> <span style=" padding-left: 5px;">Save Changes</span></div>
                
            </form>
                        <%
                // Check if the session attribute for addItemMessage exists and display it
                String addItemMessage = (String) request.getAttribute("productMessage");
                String itemMessage = (String) session.getAttribute("productMessage");
                if (addItemMessage != null) {
            %>
            <div class="message">
                <%= addItemMessage%>
            </div>
            <%
                }else if (itemMessage!= null){
            %>
            <div class="success">
                <%= itemMessage%>
            </div>
            <%
                session.removeAttribute("productMessage");
                }
            %>
        </div>


    </body>
</html> 
