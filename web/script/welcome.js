
document.addEventListener("DOMContentLoaded", function () {
    const logoutButton = document.getElementById('logout');
    const sidebar = document.getElementById('sidebar');
    const accountListButton = document.getElementById('accountlist');
    const homeButton = document.getElementById('homebutton'); // Added this line

    // Add the click event handler for the "Logout" button
    if (logoutButton) {
        logoutButton.addEventListener('click', function (event) {
            event.preventDefault();

            // Confirm the logout action with the user
            const confirmLogout = confirm("Are you sure you want to log out?");

            if (confirmLogout) {
                // Redirect to the login page only if the user clicked "OK"
                window.location.href = 'login.jsp';
            } else {
                // Handle the case where the user clicked "Cancel" (optional)
                console.log("Logout canceled. User remains logged in.");
                // Navigate to welcome.jsp
                window.location.href = 'welcome.jsp';
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
        accountListButton.addEventListener('click', function () {
            // Use the navigateTo function for accountlist.jsp
            navigateTo('accountlist.jsp');
        });
    }

});

function navigateTo(url) {
    const mainContent = document.getElementById('mainContent');
    const dashboardBar = document.querySelector('.dashboard-bar');

    // Use AJAX or other means to load content dynamically
    fetch(url)
            .then(response => response.text())
            .then(data => {
                // Update only the main content
                mainContent.innerHTML = data;

                // Check if dashboardBar exists before modifying its style
                if (dashboardBar) {
                    dashboardBar.style.display = 'block';
                }
            })
            .catch(error => console.error('Error loading content:', error));
}
function redirectTo(url) {
    // Redirect to another page
    window.location.href = url;
}
document.addEventListener("DOMContentLoaded", function () {
    // Your existing script content
});
