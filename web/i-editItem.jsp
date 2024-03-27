<%-- 
    Document   : editProduct
    Created on : 02 12, 24, 8:49:05 PM
    Author     : BioStaR
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="commons.jsp"%>
<!DOCTYPE html>
<html>
    <head>
          <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/editProduct.css">
        <script src="script/welcome.js" defer></script>
        <title>edit Product Page</title>
    </head>
    <body>
        <div class="dashboardbar">
                    <h1 id="dashboardheader">Edit Product</h1></div>
                    <h1>Edit Page</h1>
        <%
            if (session.getAttribute("itemCode") != null) {
        %>
        <h4>${itemCode}</h4>
        <%
            }
        %>
        
        <%
            ResultSet results = (ResultSet)request.getAttribute("editRecord");
            ResultSet genResults = (ResultSet)request.getAttribute("genClassEdit");
            ResultSet subResults = (ResultSet)request.getAttribute("subClassEdit");
            ResultSet unitResults = (ResultSet)request.getAttribute("unitClassEdit");
            while (results.next()) { %>
            <form action="EditItem" method="post">
                <input type="hidden" name="itemCode" value="<%= results.getString("item_code") %>">
                <table> 
                    <tr>
                        <th>Item Description</th><th><input type="text" name="itemDescription" value="<%= results.getString("item_description") %>" required/></th>
                    </tr>
                    <tr>
                        <th>Transfer Cost</th><th><input type="number" min="0" step="any" name="transferCost" value="<%= results.getFloat("transfer_cost") %>" required/></th>
                    </tr>
                    <tr>
                    <th>General Class</th>
                    </tr>
                    <tr>
                        <%
                        while (genResults.next()) { 
                        if(genResults.getString("gen_name").equals(results.getString("gen_name"))) {%>
                        <th><label><%=genResults.getString("gen_name") %></label> <input type="radio" name="gc" value="<%=genResults.getString("gen_id")%>" checked required></th>
                        <%	}
                        else{
                        %>
                        <th><label><%=genResults.getString("gen_name") %></label> <input type="radio" name="gc" value="<%=genResults.getString("gen_id")%>" required></th>
                        <%	}}
                        %>
                    </tr>
                    <tr>
                    <th>Sub Class</th>
                    </tr>
                    <tr>
                        <%
                        while (subResults.next()) { 
                        if(subResults.getString("sub_name").equals(results.getString("sub_name"))) {%>
                        <th><label><%=subResults.getString("sub_name") %></label> <input type="radio" name="sc" value="<%=subResults.getString("sub_id")%>" checked required></th>
                        <%	}
                        else{
                        %>
                        <th><label><%=subResults.getString("sub_name") %></label> <input type="radio" name="sc" value="<%=subResults.getString("sub_id")%>" required></th>
                        <%	}}
                        %>
                    </tr>
                    <tr>
                    <th>Unit of Measurement</th>
                    </tr>
                    <tr>
                        <%
                        while (unitResults.next()) { 
                        if(unitResults.getString("unit_name").equals(results.getString("unit_name"))) {%>
                        <th><label><%=unitResults.getString("unit_name") %></label> <input type="radio" name="uom" value="<%=unitResults.getString("unit_id")%>" checked required></th>
                        <%	}
                        else{
                        %>
                        <th><label><%=unitResults.getString("unit_name") %></label> <input type="radio" name="uom" value="<%=unitResults.getString("unit_id")%>" required></th>
                        <%	}}
                        %>
                    </tr>
                    <tr>
                    <th>VAT</th>
                    </tr>
                    <tr>
                        <%
                        if(results.getBoolean("vat") == true) {%>
                        <th>VAT</th><th><input type="checkbox" name="vat" value="on" checked></th>
                        <%	}
                        else{
                        %>
                        <th>VAT</th><th><input type="checkbox" name="vat" value="on"></th>
                        <%	}
                        %>
                    </tr>
                </table>
                    <input type="submit" value="Save"/>
            </form>
        <%	}
        %>
    </body>
</html>
