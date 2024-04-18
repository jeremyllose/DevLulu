<%-- 
    Document   : p-sort
    Created on : Apr 16, 2024, 9:13:19 PM
    Author     : Cesar
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="commons.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/sort.css">
        <title>Sales Page</title>
        <script src="script/welcome.js" defer></script>
        <title>Recipe Sort Page</title>
    </head>
    <body>
        <script>
            if (window.history.replaceState)
            {
                window.history.replaceState(null, null, window.location.href);
            }
        </script>
        <div class="dashboardbar">
            <h1 id="dashboardheader">Filter Options</h1></div>
        <form action="SortingProduct" method="post">
            <div style="width: 50%; height: 50%; position: relative; right: 10rem;" class="content-container">
                <table>
                    <tr>
                        <th>General Class:</th>
                        <td class="class-options">
                            <%                                ResultSet genClass = (ResultSet) request.getAttribute("genClass");
                                while (genClass.next()) {%>
                            <label><%=genClass.getString("item_description")%> <input type="checkbox" name="gc" value="<%=genClass.getString("item_code")%>" ></label><br>
                                <%	}
                                %>
                        </td>
                    </tr>
                </table>

                <button id="sorted" type="submit">Sort</button>
            </div>
        </div>
    </form>
    <button  class="inventory" id="return" onclick="redirectTo('ProductRedirect')">Return</button>
</body>
</html> 
