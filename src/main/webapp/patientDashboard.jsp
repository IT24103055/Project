<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.yourteam.appointment.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Dashboard - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/profileDashboard.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Header -->
<div class="top-bar">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo-title d-flex align-items-center">
            <h2 style="margin: 0;">MediCare</h2>
            <img src="images/medical-heart-logo-icon-vector-260nw-2477158081.webp" alt="Logo" class="top-logo">
        </div>
    </div>
</div>

<%@ include file="includes/navbar2.jsp" %>

<%
    Patient patient = (Patient) session.getAttribute("user");
    if (patient == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!-- Profile Section -->
<div class="container mt-5">
    <div class="row">

        <!-- Left Side: Quick Actions -->
        <div class="col-md-4 d-flex justify-content-center">
            <div class="card text-center p-4 shadow-sm w-100">
                <img src="images/icon.jpeg" alt="Profile Picture" class="rounded-circle mb-3 profile-img">
                <h5 class="mb-3">Welcome, <%= patient.getName() %>!</h5>
                <a href="editProfile.jsp" class="btn btn-primary btn-block mb-2">Edit Profile</a>
                <a href="resetPassword.jsp" class="btn btn-warning btn-block mb-2">Reset Password</a>
                <a href="LogoutServlet" class="btn btn-danger btn-block">Logout</a>
            </div>
        </div>

        <!-- Right Side: Patient Info Table -->
        <div class="col-md-8">
            <div class="profile-box shadow-sm p-4">
                <h4 class="mb-4 font-weight-bold text-center">My Profile</h4>
                <table class="table table-bordered">
                    <tr>
                        <th>Full Name</th>
                        <td><%= patient.getName() %></td>
                    </tr>
                    <tr>
                        <th>Email Address</th>
                        <td><%= patient.getEmail() %></td>
                    </tr>
                    <tr>
                        <th>NIC</th>
                        <td><%= patient.getNic() %></td>
                    </tr>
                    <tr>
                        <th>Gender</th>
                        <td><%= patient.getGender() %></td>
                    </tr>
                </table>

                <!-- Delete Account Button -->
                <div class="text-right mt-4">
                    <form action="DeleteAccountServlet" method="post" onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.');">
                        <input type="hidden" name="nic" value="<%= patient.getNic() %>">
                        <button type="submit" class="btn btn-danger">Delete My Account</button>
                    </form>
                </div>
            </div>
        </div>

    </div> <!-- End Row -->
</div> <!-- End Container -->

<%@ include file="includes/footer2.jsp" %>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>
