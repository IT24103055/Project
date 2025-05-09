<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign in - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .top-bar {
            background-color: white;
            padding:25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .top-logo {
            height: 90px;
            width: auto;
            margin-left: 10px;
        }
            .login-box {
            max-width: 500px;
            margin: 60px auto;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 30px;
            background-color: #f9f9f9;
        }

        .form-control {
            border-radius: 8px;
        }

        .login-title {
            font-weight: bold;
        }

        .btn-login {
            background-color: #005eb8;
            color: #fff;
            font-weight: bold;
            border-radius: 8px;
        }

        .or-divider {
            text-align: center;
            margin: 20px 0;
            position: relative;
        }

        .or-divider::before,
        .or-divider::after {
            content: "";
            position: absolute;
            top: 50%;
            width: 45%;
            height: 1px;
            background: #ccc;
        }

        .or-divider::before {
            left: 0;
        }

        .or-divider::after {
            right: 0;
        }

        .or-divider span {
            background: #f9f9f9;
            padding: 0 10px;
            color: #888;
        }

        .forgot-link, .signup-link {
            color: #005eb8;
            font-weight: bold;
        }

        .mobile-login-btn {
            border-radius: 8px;
        }
    </style>
</head>
<body>
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
    if (error != null) { %>
<div class="alert alert-danger text-center" role="alert">
    <%= error %>
</div>
<% } %>



<div class="login-box shadow-sm">
    <h4 class="login-title mb-3">Sign in</h4>
    <p class="text-muted">Please enter your username or email and password to sign in.</p>

    <form action="LoginServlet" method="post">
        <div class="form-group">
            <label for="username">User Name/ Email / NIC</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username or email" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
        </div>

        <div class="form-group d-flex justify-content-between align-items-center">
            <div>
                <input type="checkbox" id="remember" name="remember">
                <label for="remember">Keep me signed in</label>
            </div>

        </div>

        <button type="submit" class="btn btn-login btn-block">Sign In</button>

        <div class="text-center mt-3">
            <p>Don’t have an account? <a href="register.jsp" class="signup-link">Sign up</a></p>
        </div>
        <%
            String redirect = request.getParameter("redirect");
            if (redirect != null) {
                session.setAttribute("redirectAfterLogin", redirect);
            }
        %>

    </form>
</div>

<%@ include file="includes/footer.jsp" %>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>
