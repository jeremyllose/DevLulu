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
        <link rel="stylesheet" href="styles/addProduct.css">
        <script src="script/welcome.js" defer></script>
        <title>add Product Page</title>
    </head>
    <body>
         <div class="dashboardbar">
                    <h1 id="dashboardheader">Add Item</h1>
         </div>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <h1>Add Item Page</h1>
        <form action="AddItem" method="post">
            <table> 
                <tr>
                    <th>Item Code:</th><th><input type="text" name="itemCode" minlength="8" pattern="[A-Za-z0-9]+" required/></th>
                </tr>
                <tr>
                    <th>Item Description</th><th><input type="text" name="itemDescription" required/></th>
                </tr>
                <tr>
                    <th>Quantity</th><th><input type="number" min="0" name="qty" value="0" required/></th>
                    <th>Max Quantity</th><th><input type="number" min="0" name="max" value="0" required/></th>
                    <th>Reorder Quantity</th><th><input type="number" min="0" name="rod" value="0" required/></th>
                </tr>
                <tr>
                    <th>Unit of Measurement</th>
                </tr>
                <tr>
                    <%
                        ResultSet uotClass = (ResultSet)request.getAttribute("unitClass");
                        while (uotClass.next()) { %>
                        <th><label><%=uotClass.getString("unit_name") %></label> <input type="radio" name="uom" value="<%=uotClass.getString("unit_id")%>" required></th>
                    <%	}
                    %>
                </tr>
                <tr>
                    <th>Transfer Cost</th><th><input type="number" min="0" step="any" name="transferCost" required/></th>
                </tr>
                <tr>
                    <th>General Class</th>
                </tr>
                <tr>
                    <%
                        ResultSet genClass = (ResultSet)request.getAttribute("genClass");
                        while (genClass.next()) { %>
                        <th><label><%=genClass.getString("gen_name") %></label> <input type="radio" name="gc" value="<%=genClass.getString("gen_id")%>" required></th>
                    <%	}
                    %>
                </tr>
                <tr>
                    <th>Sub Class</th>
                </tr>
                <tr>
                    <%
                        ResultSet subClass = (ResultSet)request.getAttribute("subClass");
                        while (subClass.next()) { %>
                        <th><label><%=subClass.getString("sub_name") %></label> <input type="radio" name="sc" value="<%=subClass.getString("sub_id")%>" required></th>
                    <%	}
                    %>
                </tr>
                <tr>
                    <th>VAT</th><th><input type="checkbox" name="vat" value="on"></th>
                </tr>
                <tr>
                    <th><input type="submit" value="Add Item"/></th>
                </tr>
            </table>
        </form>
            <%
                if (session.getAttribute("existing") != null) {
            %>
            <h4>${existing}</h4>
            <%
                }
            %>
    </body>
</html>
