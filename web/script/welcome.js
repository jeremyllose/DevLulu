document.addEventListener("DOMContentLoaded", function() {
    const logoutButton = document.getElementById('logout');
    const sidebar = document.getElementById('sidebar');
    const accountListButton = document.getElementById('accountlist');
    const homeButton = document.getElementById('homebutton'); // Added this line

    // Add the click event handler for the "Logout" button
    if (logoutButton) {
        logoutButton.addEventListener('click', function(event) {
            event.preventDefault();

            // Confirm the logout action with the user
            const confirmLogout = confirm("Are you sure you want to log out?");
            
            if (confirmLogout) {
                // Redirect to the login page
                window.location.href = 'login.jsp';
            }
        });
    }

    // Check if the current page is not the login page, then display the sidebar
    if (sidebar && window.location.pathname !== '/login.jsp') {
        // Code to show the sidebar (modify as needed)
        sidebar.style.display = 'block';
    }

    // Add the click event handler for the "Account List" button
    if (accountListButton) {
        accountListButton.addEventListener('click', function() {
            // Use the navigateTo function for accountlist.jsp
            navigateTo('accountlist.jsp');
        });
    }

    // Add the click event handler for the "Home" button
    if (homeButton) {
        homeButton.addEventListener('click', function() {
            // Use the navigateTo function for welcome.jsp
           window.location.href = 'welcome.jsp';
        });
    }
});

function navigateTo(url) {
    const mainContent = document.getElementById('mainContent');
    mainContent.innerHTML = `<iframe src="${url}" width="100%" height="100%" frameborder="0"></iframe>`;
}
