<%-- 
    Document   : addaccount
    Created on : Jan 28, 2024, 10:41:32 PM
    Author     : jeremy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/addaccount.css">
        <title>Add Account</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
          <div class="dashboardbar">
                    <h1 id="dashboardheader">Add Account</h1></div>
         <div class="container">
             <div class="user">
              <label for="myText">Username:</label>
        <input type="text" id="user" name="myText">
             </div>
             <div class="role">
         <label for="myText">Role:</label>
        <input type="text" id="role" name="myText">
         </div>
             <div class="pass">
         <label for="myText">Password:</label>
         <input type="text" id="pass" name="myText">
             </div>
             <div class="conpass">
          <label for="myText">Confirm Password:</label>
        <input type="text" id="conpass" name="myText">
             </div>
        
         </div>   
        <button class="account" id="savechanges" onclick="navigateTo('accountlist.jsp')">Save Changes</button>
        <button class="account" id="cancel" onclick="navigateTo('accountlist.jsp')">Cancel</button>
    </body>
</html>
