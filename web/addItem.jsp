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
                    <th>Unit of Measurement</th>
                </tr>
                <tr>
                    <th><label for="pc">PC</label> <input type="radio" id="pc" name="uom" value="PC" required></th>
                        
                    <th><label for="gal">GAL</label> <input type="radio" id="gal" name="uom" value="GAL"></th>
                        
                    <th><label for="pac">PAC</label> <input type="radio" id="pac" name="uom" value="PAC"></th>
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