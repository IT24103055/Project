<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.yourteam.appointment.model.Admin" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Management - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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

<%@ include file="includes/admintopbar.jsp" %>
<%@ include file="includes/adminavbar.jsp" %>

<div class="container mt-5">
    <div class="row">

        <!-- Left Side -->
        <div class="col-md-4 d-flex justify-content-center">
            <div class="card text-center p-4 shadow-sm w-100">
                <img src="images/img.jpg" alt="Profile Picture" class="rounded-circle mb-3 profile-img">
                <h5 class="mb-3">Welcome!!!</h5>
                <a href="AdminManagement.jsp" class="btn btn-primary btn-block mb-2">Admin Registration</a>
                <a href="AdminProfile.jsp" class="btn btn-primary btn-block mb-2">My Profile</a>
                <a href="AdminUsers.jsp" class="btn btn-primary btn-block mb-2">Admin Users</a>
                <a href="AdminDelete.jsp" class="btn btn-danger btn-block">Delete Account</a>
                <a href="DeleteFeedback.jsp" class="btn btn-danger btn-block">Delete Feedbacks</a>
            </div>
        </div>

        <!-- Right Side -->
        <div class="col-md-8">
            <div class="profile-box shadow-sm p-4">
                <h4 class="mb-4 font-weight-bold text-center">Admin Registration</h4>

                <!-- Show Success or Error -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success text-center">${successMessage}</div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger text-center">${errorMessage}</div>
                </c:if>

                <form action="AdminRegisterServlet" method="post">
                    <div class="form-group">
                        <label for="fullname">Full Name</label>
                        <input type="text" class="form-control" id="fullname" name="fullname" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>

                    <div class="form-group">
                        <label for="nic">NIC</label>
                        <input type="text" class="form-control" id="nic" name="nic" required>
                    </div>

                    <div class="form-group">
                        <label for="gender">Gender</label>
                        <select class="form-control" id="gender" name="gender" required>
                            <option value="" disabled selected>Select your gender</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>

                    <div class="form-group">
                        <label for="confirm">Confirm Password</label>
                        <input type="password" class="form-control" id="confirm" name="confirm" required>
                    </div>

                    <!-- ✅ Role Dropdown -->
                    <div class="form-group">
                        <label for="role">Role</label>
                        <select class="form-control" id="role" name="role" required>
                            <option value="" disabled selected>Select role</option>
                            <option value="standard">Standard</option>
                            <option value="main">Main</option>
                        </select>
                    </div>

                    <div class="d-flex justify-content-end mt-4">
                        <button type="submit" class="btn btn-primary">Register</button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>

<%@ include file="includes/adminfooter.jsp" %>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script>
    document.querySelector("form").addEventListener("submit", function (e) {
        const password = document.getElementById("password");
        const confirm = document.getElementById("confirm");
        if (password && confirm && password.value !== confirm.value) {
            e.preventDefault();
            alert("Passwords do not match. Please try again.");
        }
    });
</script>

</body>
</html>
