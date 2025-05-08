<!DOCTYPE html>
<html>
<head>
    <title>Admin Management - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/AdminManagement.css">
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

<!-- Navbar Include -->
<%@ include file="includes/navbar.jsp" %>

<!-- Profile and Form Section -->
<div class="container mt-5">
    <div class="row">

        <!-- Left Side: Profile Info -->
        <div class="col-md-4 d-flex justify-content-center">
            <div class="card text-center p-4 shadow-sm w-100">
                <img src="images/img.png" alt="Profile Picture" class="rounded-circle mb-3 profile-img">
                <h5 class="mb-3">Welcome!!!</h5>
                <a href="AdminManagement.jsp" class="btn btn-primary btn-block mb-2">Registation</a>
                <a href="AdminProfile.jsp" class="btn btn-primary btn-block mb-2">My Profile</a>
                <a href="AdminUsers.jsp" class="btn btn-primary btn-block mb-2">Admin Users</a>
                <a href="AdminDelete.jsp" class="btn btn-danger btn-block">Delete Account</a>
                <a href="DeleteFeedback.jsp" class="btn btn-danger btn-block">Delete Feedbacks</a>
            </div>
        </div>

        <div class="col-md-8">
            <div class="profile-box shadow-sm p-4">
                <h4 class="mb-4 font-weight-bold text-center">Admin Profile</h4>
                <ul class="list-unstyled">
                    <li><i class="fas fa-fingerprint text-primary"></i> <strong>Full Name:</strong> -</li>
                    <li><i class="fas fa-user text-primary"></i> <strong>Email Address:</strong> -</li>
                    <li><i class="fas fa-envelope text-primary"></i> <strong>NIC:</strong> -</li>
                    <li><i class="fas fa-briefcase text-primary"></i> <strong>Gender:</strong> -</li>
                </ul>
                <div class="text-center mt-4">
                    <a href="Registration.jsp" class="btn btn-primary btn-block">
                        <i class="fas fa-eye"></i> Update Profile
                    </a>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Footer Include -->
<%@ include file="includes/footer.jsp" %>

<!-- Scripts -->
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

