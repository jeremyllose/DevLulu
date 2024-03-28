<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="styles/login.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="icon" type="image/png" href="photos/cafeicon.png">
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
                <form id="login-form" action="Login" method="post">
                    <h1 id="signin">Sign In:</h1>
                    <div class="label-input-group">
                        <label for="uname">Username:</label>
                        <%
                            if (session.getAttribute("rememberUsername") != null) {
                        %>
                        <input type="text" id="uname" name="uname" required placeholder="Enter username" value="${rememberUsername}"><br>
                        <%
                            }
                            else
                            {
                        %>
                        <input type="text" id="uname" name="uname" required placeholder="Enter username"><br>
                        <%
                            }
                        %>
                        <label for="password">Password:</label>
                        <%
                            if (session.getAttribute("rememberPassword") != null) {
                        %>
                        <input type="password" id="password" name="pass" required placeholder="Enter password" value="${rememberPassword}"><br>
                        <%
                            }
                            else
                            {
                        %>
                        <input type="password" id="password" name="pass" required placeholder="Enter password"><br>
                        <%
                            }
                        %>
                    </div>
                    <br>
                    <input type="submit" id="loginbutton"value="Login"><br>
                    <a id="forgot-password" href="#" onclick="openForgotPasswordForm()">Forgot Password?</a><br>
                    <label for="rememberme">Remember me</label>
                    <%
                            if (session.getAttribute("rememberUsername") != null) {
                    %>
                    <input type="checkbox" id="rememberme" name="rememberme" value="on" checked>    
                    <%
                        }
                            else
                        {
                    %>
                    <input type="checkbox" id="rememberme" name="rememberme" value="on">  
                    <%
                        }
                    %>
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
        <div id="forgotPasswordModal" class="modal">
            <div class="modal-content">
                <span class="close-modal">&times;</span>
                <form id="forgot-password-form">
                    <h2 style="font-size: 36px; font-family: Karma;  position: relative; left: 0rem; top: -1rem; ">Forgot Password</h2>       
                    <h3 style="font-size: 20px; font-family: Lohit Bengali; color: #696969; font-weight:lighter; position: relative; left: 0rem; top: -3rem;">Please provide your username to request a password reset.</h2>
                        <label style="font-size: 18px; font-family: Lohit Bengali; font-weight:bold; position: relative; left: -5.9rem; top: -2.5rem;" for="forgot-email">Username:</label>
                        <input style=" width: 18rem;border-radius: 10px; position: relative; left: 0rem; top: -2.2rem;" type="text" id="forgot-email" name="forgot-email" placeholder="Enter username">
                        <br>    
                        <button id="FPsubmit" type="submit">Submit</button>
                        <button class="close-forgot-form">&times;</button>
                </form>
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
                    myIndex = 1;
                }
                x[myIndex - 1].style.display = "block";
                setTimeout(carousel, 5000); // Change image every 5 seconds
            }
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const loginButton = document.getElementById('loginbutton');

                loginButton.addEventListener('click', function (event) {
                    // Prevent default form submission
                    event.preventDefault();

                    // Trigger page transition animation
                    document.body.style.opacity = 0;

                    // After animation (adjust time based on your animation duration)
                    setTimeout(function () {
                        // Revert animation
                        document.body.style.opacity = 1;

                        // Submit the form after animation completes
                        document.getElementById('login-form').submit();
                    }, 500); // Adjust this value based on your transition duration (in milliseconds)
                });
            });
            function openForgotPasswordForm() {
                // Get the modal element
                const modal = document.getElementById("forgotPasswordModal");

                // Display the modal
                modal.style.display = "block";
            }
            const closeButton = document.querySelector('.close-forgot-form');
            const modal = document.querySelector('.modal');

            closeButton.addEventListener('click', () => {
                modal.style.display = 'none'; // Hides the entire modal
            });
        </script>
    </body>
</html>
