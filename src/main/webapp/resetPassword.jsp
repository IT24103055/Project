<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .profile-pic {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
        }
    </style>
</head>
<body>

<%@ include file="includes/topbar2.jsp" %>
<%@ include file="includes/navbar2.jsp" %>

<!-- Password Reset Form -->
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm p-4">
                <h4 class="mb-4 text-center font-weight-bold">Reset Your Password</h4>
                <form action="ResetPasswordServlet" method="post">
                    <div class="form-group">
                        <label for="email">Registered Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>

                    <div class="form-group">
                        <label for="newPassword">New Password</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>

                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-warning">Reset Password</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="includes/footer2.jsp" %>

<script>
    document.querySelector("form").addEventListener("submit", function (e) {
        const newPassword = document.getElementById("newPassword");
        const confirmPassword = document.getElementById("confirmPassword");
        if (newPassword.value !== confirmPassword.value) {
            e.preventDefault();
            alert("Passwords do not match.");
        }
    });
</script>

</body>
</html>
