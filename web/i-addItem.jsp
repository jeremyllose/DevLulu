<%-- 
    Document   : addProduct
    Created on : 02 11, 24, 2:39:14 PM
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
        <link rel="stylesheet" href="styles/addItem.css">
        <script src="script/welcome.js" defer></script>
        <title>Add Item</title>
    </head>
    <body>
        <script>
            if ( window.history.replaceState ) 
            {
                window.history.replaceState( null, null, window.location.href );
            }
        </script>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <div class="dashboardbar">
            <h1 id="dashboardheader">Add Item</h1> 
        </div>
        <br>
        <br>
        <br>
        <br>
        <br>

        <form action="AddItem" method="post">
            <div class="item-container">
                <table>
                    <tr>
                        <th>Markup %:</th>
                        <td><input type="number" min="0" name="itemMarkup" value="0" required></td>
                    </tr>
                    <tr>
                        <th>Item Description:</th>
                        <td><input type="text" name="itemDescription" required></td>
                    </tr>
                    <tr>
                        <th>Unit of Measurement:</th>
                        <td class="class-options">
                            <%
                                ResultSet unitClass = (ResultSet) request.getAttribute("unitClass");
                                while (unitClass.next()) {%>
                            <label><%=unitClass.getString("unit_name")%> <input type="radio" name="uom" value="<%=unitClass.getString("unit_id")%>" required></label><br>
                                <%	}
                                %>
                        </td>
                    </tr>
                    <tr>
                        <th>Transfer Cost:</th>
                        <td><input type="number" min="0" step="any" name="transferCost" required></td>
                    </tr>
                    <tr>
                        <th>Quantity:</th>
                        <td><input type="number" min="0" name="qty" required></td>
                    </tr>
                    <tr>
                        <th>Max Quantity:</th>
                        <td><input type="number" min="0" name="max" required></td>
                    </tr>
                    <tr>
                        <th>Reorder Quantity:</th>
                        <td><input type="number" min="0" name="rod" required></td>
                    </tr>
                    <tr>
                        <th>General Class:</th>
                        <td class="class-options">
                            <%
                                ResultSet genClass = (ResultSet) request.getAttribute("genClass");
                                while (genClass.next()) {%>
                            <label><%=genClass.getString("gen_name")%> 
                                <input type="radio" name="gc" value="<%=genClass.getString("gen_id")%>" required>
                                <input type="hidden" name="gcode" value="<%=genClass.getString("code")%>">
                            </label><br>
                                <%	}
                                %>
                        </td>
                    </tr>
                    <tr>
                        <th>Sub Class:</th>
                        <td class="box-container">
                            <%
                                ResultSet subClass = (ResultSet) request.getAttribute("subClass");
                                while (subClass.next()) {%>
                            <label><%=subClass.getString("sub_name")%> 
                                <input type="radio" name="sc" value="<%=subClass.getString("sub_id")%>" required>
                                <input type="hidden" name="scode" value="<%=subClass.getString("code")%>">
                            </label><br>
                                <%	}
                                %>
                        </td>
                    </tr>
                    <tr>
                        <th>Include VAT:</th>
                        <td><input type="checkbox" name="vat" value="on"></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Add Item"></td>
                    </tr>
                    <button class="inventory" id="return" onclick="redirectTo('ItemList')">Return</button>
                </table>
            </div>
        </form>
                        <script>
        function redirectToItemList() {
        // Hide the success message element (optional)
        // document.querySelector('.message').style.display = 'none';

        // Clear the success attribute
        sessionStorage.removeItem("addItemMessage"); // Use sessionStorage for temporary data

        // Redirect to the ItemList page
        window.location.href = 'ItemList';
        }      
        </script>
        <div>   
            <% if (session.getAttribute("existing") != null) { %>
            <div class="error">
                <span class="error-symbol">&#9888;</span> Error! ${existing}
            </div>
            <% }%>
        </div>
    </body>
</html>