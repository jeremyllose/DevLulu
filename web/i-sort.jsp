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
        <link rel="stylesheet" href="styles/sort.css">
        <title>Sales Page</title>
        <script src="script/welcome.js" defer></script>
        <title>edit Product Page</title>
    </head>
    <body>
            <div class="dashboardbar">
                <h1 id="dashboardheader">Sort Options</h1></div>
            <form action="SortingItems" method="post">
                <div class="content-container">
                <table>
                    <tr>
                        <th>General Class:</th>
                        <td class="class-options">
                            <%
                                ResultSet genClass = (ResultSet) request.getAttribute("genClass");
                                while (genClass.next()) {%>
                            <label><%=genClass.getString("gen_name")%> <input type="checkbox" name="gc" value="<%=genClass.getString("gen_id")%>" ></label><br>
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
                            <label><%=subClass.getString("sub_name")%> <input type="checkbox" name="sc" value="<%=subClass.getString("sub_id")%>" ></label><br>
                                <%	}
                                %>
                        </td>
                    </tr>
                </table>
                
                <button type="submit">Submit</button>
        </div>
                        </div>
    </form>
</body>
</html>
