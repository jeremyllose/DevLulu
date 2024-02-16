<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="styles/login.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="script\welcome.js" defer></script>
        <title>Login Page</title>
    </head>
    <body>
        <img src="photos/nextgentitle.png" alt="Image" class="title-image">
        <img src="photos/nextgenlogo.png" alt="Image" class="title-logo">
        <img src="photos/greenleaves.png" alt="Image" class="bottom-leaves">   
        <img src="photos/coffeebeans.png" alt="Image" class="top-beans"> 
        
        <div class="container" id="container">
            <div class="form-container log-in-container">
                <form action="Login" method="post">
                    <h1 id="signin">Sign In:</h1>
                    <div class="label-input-group">
                        <label for="uname">Username:</label>
                        <input type="text" id="uname" name="uname" required placeholder="Enter username"><br>
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="pass" required placeholder="Enter password"><br>
                    </div>
                    <br>
                    <input type="submit" id="loginbutton"value="Login"><br>
                    <a href="/forgot-password">Forgot Password?</a><br>
                    <label for="rememberme">Remember me</label>
                        <input type="checkbox" id="rememberme" name="rememberme">    
                </form>
            </div>
            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-right">
                        <img class="mySlides" src="photos/myimage1.jpg" style="width: 150%; height: 100%; object-fit: cover;">
                        <img class="mySlides" src="photos/myimage2.jpg" style="width: 140%; height: 100%; object-fit: cover;"> 
                        <img class="mySlides" src="photos/myimage3.jpg" style="width: 150%; height: 100%; object-fit: cover;">
                    </div>
                </div>
            </div>
        </div>
        <%
            if (session.getAttribute("message") != null) {
        %>
        <h4>${message}</h4>
        <%
            }
        %>
        <script>
            var myIndex = 0;
            carousel();

            function carousel() {
                var i;
                var x = document.getElementsByClassName("mySlides");
                for (i = 0; i < x.length; i++) {
                    x[i].style.display = "none";
                }
                myIndex++;
                if (myIndex > x.length) {
                    myIndex = 1
                }
                x[myIndex - 1].style.display = "block";
                setTimeout(carousel, 2000); // Change image every 2 seconds
            }
        </script>
    </body>
</html>
