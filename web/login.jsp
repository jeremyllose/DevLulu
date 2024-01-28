<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <style>
            @font-face {
                font-family: 'YourCustomFont';
                src: url('web/fonts/Lato-Black.ttf') format('truetype');
                src: url('web/fonts/Montserrat-Italic-VariableFont_wght.ttf') format('truetype');
            }
        </style>
        <link rel="stylesheet" type="text/css" href="styles/login.css">
        <script src="script\welcome.js" defer></script>
    </head>
    <body>
        <%
            if (session.getAttribute("attempts") != null) {
                if ((Integer) session.getAttribute("attempts") <= 0) {
                    response.sendRedirect("attempts.jsp");
                }
            }
        %>
        <form action="Login" method="post">
            <h1 id="title">Next Gen Cafe Inventory</h1>
            <h1 id="signin">Sign In:</h1>
            <h2 id="tosign">Sign In with username and password</h2>
            <div class="label-input-group">
                <label for="username">Your Username:</label>
                <input type="text" id="uname" name="uname" required placeholder="Enter username"><br>
                <label for="password">Your Password:</label>
            </div>

            <div class="label-input-group">
                <input type="password" id="password" name="pass" required placeholder="Enter password"><br>
            </div>

            <input type="submit" id="loginbutton"value="Login"><br>
            <a href="/forgot-password">Forgot Password?</a><br>
            <label for="rememberme">
                <input type="checkbox" id="rememberme" name="rememberme"> Remember me
            </label>

        </form>
        <%
            if (session.getAttribute("message") != null) {
        %>
        <h4>${message}</h4>
        <%
            }
        %>
    </body>
</html>
