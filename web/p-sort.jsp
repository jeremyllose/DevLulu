<%-- 
    Document   : p-sort
    Created on : Apr 16, 2024, 9:13:19 PM
    Author     : Cesar
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Sort Page</title>
    </head>
    <body>
        <script>
            if ( window.history.replaceState ) 
            {
                window.history.replaceState( null, null, window.location.href );
            }
        </script>
            <div class="dashboardbar">
                <h1 id="dashboardheader">Sort Options</h1></div>
            <form action="SortingProduct" method="post">
                <div class="content-container">
                <table>
                    <tr>
                        <th>General Class:</th>
                        <td class="class-options">
                            <%
                                ResultSet genClass = (ResultSet) request.getAttribute("genClass");
                                while (genClass.next()) {%>
                            <label><%=genClass.getString("item_description")%> <input type="checkbox" name="gc" value="<%=genClass.getString("item_code")%>" ></label><br>
                                <%	}
                                %>
                        </td>
                    </tr>
                </table>
                <button class="inventory" id="return" onclick="redirectTo('ProductRedirect')">Return</button>
                <button id="sorted" type="submit">Sort</button>
        </div>
                        </div>
    </form>
</body>
</html> 
