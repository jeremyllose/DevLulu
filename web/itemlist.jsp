<%-- 
    Document   : itemlist
    Created on : Feb 16, 2024, 1:36:51 PM
    Author     : Cesar
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Item List</h1>
        <form action="AddItemPageRedirect" method="post">
             <button type="submit">Add Item</button>
         </form>
        
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
        </form>
    </body>
</html>
