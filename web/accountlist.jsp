<%-- 
    Document   : accountlist
    Created on : Jan 28, 2024, 1:22:13 PM
    Author     : jeremy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles/accountlist.css">
        <title>Account List</title>
        <script src="script/welcome.js" defer></script>
    </head>
    <body>
         <div class="dashboardbar">
                    <h1 id="dashboardheader">Account List</h1></div>
                    <button class="account" id="addmember" onclick="navigateTo('addaccount.jsp')">Add Member</button>
                     <div class="container">
        <table>
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Role</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                
                <tr>
                    <td>user1</td>
                    <td>password123</td>
                    <td>Admin</td>
                    <td>
                        <button>Edit</button>
                        <button>Delete</button>
                    </td>
                </tr>
                
            </tbody>
        </table>
    </div>
</body>
</html>
