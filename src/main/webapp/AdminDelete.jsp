<!DOCTYPE html>
<html>
<head>
    <title>Admin Management - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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

        <!-- Right Side: Profile Form -->
        <div class="col-md-8">
            <div class="profile-box shadow-sm p-4">
                <h4 class="mb-4 font-weight-bold text-center">Delete Account</h4>
                <div id="delete-section">
                    <form id="deleteForm" class="p-4 rounded-lg" style="background: #ffffff; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border-radius: 12px;">
                        <div class="form-group">
                            <label for="delete-username" class="font-weight-bold text-secondary">Confirm Your Username</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                            <span class="input-group-text bg-white border-right-0">
                                <i class="fas fa-user text-primary"></i>
                            </span>
                                </div>
                                <input type="text" id="delete-username" name="delete-username" class="form-control border-left-0" placeholder="Enter your username" required>
                            </div>
                        </div>

                        <button type="button" onclick="deleteAccount()" class="btn btn-danger btn-block mt-4 py-2" style="border-radius: 8px; font-weight: 600;">
                            <i class="fa-solid fa-trash-can mr-2"></i> Delete My Account
                        </button>

                        <div id="delete-message" class="mt-3 text-center text-danger font-weight-bold"></div>
                    </form>
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
