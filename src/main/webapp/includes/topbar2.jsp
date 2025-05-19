<%
// Safely fetch the display name
String userDisplay = (String) session.getAttribute("username");
if (userDisplay == null || userDisplay.isEmpty()) {
userDisplay = "User";
}
%>


<!-- Top Bar with Profile Dropdown -->
<div class="top-bar">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo-title d-flex align-items-center">
            <h2 style="margin: 0;">MediCare</h2>

        </div>

        <div class="dropdown">
            <a class="dropdown-toggle d-flex align-items-center"
               href="#"
               id="userDropdown"
               role="button"
               data-toggle="dropdown"
               aria-haspopup="true"
               aria-expanded="false">

                <%= userDisplay %>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="patientDashboard.jsp">Profile</a>
                <a class="dropdown-item" href="LogoutServlet">Logout</a>
            </div>
        </div>
    </div>
</div>
