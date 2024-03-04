<%-- 
    Document   : test
    Created on : Feb 2, 2024, 6:25:34 AM
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
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("userRole").equals("Manager") ) {
                session.setAttribute("verification", "You have no Permission to Open the Account List");
                response.sendRedirect("welcome.jsp");
            }
        %>
        <h1>Variance Test</h1>
        <%
            int itemCount = (Integer) request.getAttribute("inventoryCount");
        %>
        <h1>Inventory Count: <%= itemCount %></h1>
        <%
            float inventoryCost = (Float) request.getAttribute("inventoryValue");
        %>
        <h1>Inventory Count: <%= inventoryCost %></h1>
        <form action="SaveVariance" method="post">
            <button type="submit" name="button" value="save">Save Changes</button>
        <table>
            <thead>
                <tr>
                    <th>Item Description</th>
                    <th>General Class</th>
                    <th>Sub Class</th>
                    <th>UOM</th>
                    <th>BEG</th>
                    <th>Deliveries</th>
                    <th>Others</th>
                    <th>Total On Main</th>
                    <th>Sold</th>
                    <th>Waste</th>
                    <th>Others</th>
                    <th>Total</th>
                    <th>Expected End</th>
                    <th>Actual End</th>
                    <th>Variance</th>
                </tr>
            </thead>
            <tbody>
                <%
                            ResultSet results = (ResultSet) request.getAttribute("inventory");
                            while (results.next()) {%>
                <tr>
                    <td><%=results.getString("item_description")%></td>
                    <td><%=results.getString("gen_name")%></td>
                    <td><%=results.getString("sub_name")%></td>
                    <td><%=results.getString("unit_name")%></td>
                    <td><input type="number" min="0" name="beg" value="<%=results.getString("beginning_quantity")%>" required/></td>
                    <td><%=results.getString("delivery")%></td>
                    <td><%=results.getString("otheradds")%></td>
                    <%
                        int totalOnMain = results.getInt("beginning_quantity") + results.getInt("delivery") + results.getInt("otheradds");
                    %>
                    <td><%=totalOnMain%></td>
                    <td><%=results.getString("sold")%></td>
                    <td><%=results.getString("waste")%></td>
                    <td><%=results.getString("othersubs")%></td>
                    <%
                        int totalOutput = totalOnMain - results.getInt("sold") - results.getInt("waste") - results.getInt("othersubs");
                    %>
                    <td><%=totalOutput%></td>
                    <td><%=totalOutput%></td>
                    <td><input type="number" min="0" name="end" value="<%=results.getString("end_quantity")%>" required/></td>
                    <%
                        int variance = results.getInt("end_quantity") -  totalOutput;
                    %>
                    <td><%=variance%></td>
                    <td>
                        <button type="submit" name="button" value="edit <%= results.getString("item_code")%>">Edit</button>
                    </td>
                </tr>	
                <%	}
                %>
            </tbody>
        </table>
        </form>
    </body>
</html>
