<%-- 
    Document   : 500 Internal Server Error Page
    Created on : 04 16, 24, 6:10:19 AM
    Author     : BioStaR
--%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="styles/errorpage.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="icon" type="image/png" href="photos/cafeicon.png">
        <title>403 Forbidden</title>
    </head>
    <body>
        <div class="logo">
            <img src="photos/nextgentitle.png" alt="Image" class="title-image">
            <img src="photos/nextgenlogo.png" alt="Image" class="title-logo">
        </div>
        <img src="photos/greenleaves.png" alt="Image" class="bottom-leaves">   
        <img src="photos/coffeebeans.png" alt="Image" class="top-beans"> 

        <div class="Error-Form">
            <h1>500 Internal Server Error</h1>
            <img id="cup" src="photos/errorcup.png" alt="Image" >   
            <p>Sorry, something went wrong on our end. Please try again later.</p>

            <%
                if (session.getAttribute("username") == null) {
            %>
            <a href="login.jsp">Return to Login Page</a>
            <%
            } else {
            %>
            <a href="WelcomePageRedirect">Return to Dashboard</a>
            <%
                }
            %>
    </body>