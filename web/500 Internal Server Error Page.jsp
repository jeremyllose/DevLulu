<%-- 
    Document   : 500 Internal Server Error Page
    Created on : 04 16, 24, 6:10:19 AM
    Author     : BioStaR
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 Internal Server Error</title>
</head>
<body>
    <h1>500 Internal Server Error</h1>
    <p>Sorry, something went wrong on our end. Please try again later.</p>
    <%
                if (session.getAttribute("username") == null) {
            %>
    <a href="login.jsp">Return to Login Page</a>
    <%
        }
else
{
            %>
            <a href="WelcomePageRedirect">Return to Dashboard</a>
            <%
                }
            %>
</body>
</html>
