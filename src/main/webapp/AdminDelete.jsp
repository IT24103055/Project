<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Management - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="css/AdminManagement.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .top-logo { width: 50px; margin-left: 10px; }
        .profile-pic { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
        .admin-navbar { background-color: #343a40; padding: 10px 0; }
        .admin-navbar a { color: white; margin: 0 15px; font-weight: 500; }
        .admin-navbar a:hover { text-decoration: underline; }
        .footer-section { background-color: #343a40; color: #ffffff; padding: 20px 0; }
    </style>
</head>
<body>

<!-- Header -->
<%@ include file="includes/admintopbar.jsp" %>

<!-- Navbar Include -->
<%@ include file="includes/adminavbar.jsp" %>

<!-- Profile and Form Section -->
<div class="container mt-5">
    <div class="row">

        <!-- Left Side: Profile Info -->
        <div class="col-md-4 d-flex justify-content-center">
            <div class="card text-center p-4 shadow-sm w-100">
                <img src="images/img.jpg" alt="Profile Picture" class="rounded-circle mb-3 profile-img">
                <h5 class="mb-3">Welcome!!!</h5>
                <a href="AdminManagement.jsp" class="btn btn-primary btn-block mb-2">Registration</a>
                <a href="AdminProfile.jsp" class="btn btn-primary btn-block mb-2">My Profile</a>
                <a href="AdminUsers.jsp" class="btn btn-primary btn-block mb-2">Admin Users</a>
                <a href="AdminDelete.jsp" class="btn btn-danger btn-block">Delete Account</a>
                <a href="DeleteFeedback.jsp" class="btn btn-danger btn-block">Delete Feedbacks</a>
            </div>
        </div>

        <!-- Right Side: Delete Form -->
        <div class="col-md-8">
            <div class="profile-box shadow-sm p-4">
                <h4 class="mb-4 font-weight-bold text-center">Delete Account</h4>
                <div id="delete-section">
                    <form action="AdminDeleteServlet" method="post" class="p-4 rounded-lg"
                          style="background: #ffffff; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border-radius: 12px;">
                        <div class="form-group">
                            <label for="nic" class="font-weight-bold text-secondary">Enter NIC to Delete</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-white border-right-0">
                                        <i class="fas fa-id-card text-primary"></i>
                                    </span>
                                </div>
                                <input type="text" id="nic" name="nic" class="form-control border-left-0"
                                       placeholder="Enter NIC" required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-danger btn-block mt-4 py-2"
                                style="border-radius: 8px; font-weight: 600;">
                            <i class="fa-solid fa-trash-can mr-2"></i> Delete My Account
                        </button>

                        <!-- Success or Error Message -->
                        <c:if test="${not empty errorMessage}">
                            <div class="mt-3 text-center text-danger font-weight-bold">${errorMessage}</div>
                        </c:if>
                        <c:if test="${not empty successMessage}">
                            <div class="mt-3 text-center text-success font-weight-bold">${successMessage}</div>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Footer Include -->
<%@ include file="includes/adminfooter.jsp" %>

<!-- FontAwesome Script -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

</body>
</html>
