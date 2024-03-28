/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function redirectToWithTransition(url) {
    var mainContent = document.getElementById('mainContent');

    // Add the 'fade-out' class for the fade-out effect
    mainContent.classList.add('fade-out');

    setTimeout(function () {
        // Redirect to the new page after the fade-out effect
        window.location.href = url;
    }, 500); // Adjust the timeout based on your transition duration
}

// Add this function to remove the 'fade-out' class and add 'fade-in' class when the new page is loaded
function onPageLoad() {
    var mainContent = document.getElementById('mainContent');

    // Remove the 'fade-out' class to reset opacity
    mainContent.classList.remove('fade-out');

    // Add the 'fade-in' class to apply the fade-in effect
    mainContent.classList.add('fade-in');
}