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
                <a href="AdminManagement.jsp" class="btn btn-primary btn-block mb-2">Admin Registation</a>
                <a href="AdminProfile.jsp" class="btn btn-primary btn-block mb-2">My Profile</a>
                <a href="AdminUsers.jsp" class="btn btn-primary btn-block mb-2">Admin Users</a>
                <a href="AdminDelete.jsp" class="btn btn-danger btn-block">Delete Account</a>
                <a href="DeleteFeedback.jsp" class="btn btn-danger btn-block">Delete Feedbacks</a>
            </div>
        </div>

        <!-- Right Side: Profile Form -->
        <div class="col-md-8">
            <div class="profile-box shadow-sm p-4">
                <h4 class="mb-4 font-weight-bold text-center">Admin Registration</h4>
                <form action="ProfileServlet" method="post">
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

                    <div class="d-flex justify-content-end mt-4">
                        <button type="submit" class="btn btn-primary">Register</button>
                    </div>
                </form>
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
