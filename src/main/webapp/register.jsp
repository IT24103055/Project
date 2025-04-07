<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/register.css">
    <link rel="stylesheet" href="css/style.css">

</head>
<body>
<!-- Header -->
<div class="top-bar">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo-title d-flex align-items-center">
            <h2 style="margin: 0;">MediCare</h2>
            <img src="images/logo.jpg" alt="Logo" class="top-logo">
        </div>
    </div>
</div>

<%@ include file="includes/navbar.jsp" %>

<% String error = (String) request.getAttribute("errorMessage");
    String success = (String) request.getAttribute("successMessage");
    if (error != null) { %>
<div class="alert alert-danger text-center"><%= error %></div>
<% } else if (success != null) { %>
<div class="alert alert-success text-center"><%= success %></div>
<% } %>

<!-- Register Form -->
<div class="register-box shadow-sm">
    <h4 class="mb-4 font-weight-bold text-center">Patient Registration</h4>
    <form action="RegisterServlet" method="post">
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

        <button type="submit" class="btn btn-register btn-block">Register</button>

        <div class="text-center mt-3">
            <p>Already have an account? <a href="login.jsp">Sign in</a></p>
        </div>
    </form>
</div>

<%@ include file="includes/footer.jsp" %>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script>
    document.querySelector("form").addEventListener("submit", function (e) {
        const password = document.getElementById("password").value;
        const confirm = document.getElementById("confirm").value;

        if (password !== confirm) {
            e.preventDefault(); // stop form submission
            alert("Passwords do not match. Please try again.");
        }
    });
</script>

</body>
</html>
