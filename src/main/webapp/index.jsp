<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Redirect user to respective dashboard if already logged in

    if (session != null && session.getAttribute("username") != null) {
        String role = (String) session.getAttribute("role");

        if ("patient".equals(role)) {
            response.sendRedirect("dashboard.jsp");
        } else if ("admin".equals(role)) {
            response.sendRedirect("admin_dashboard.jsp");
        } else if ("doctor".equals(role)) {
            response.sendRedirect("doctor_dashboard.jsp");
        }
    }
%>
<html>
<head>
    <title>Medical Appointment System</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Top Header Bar -->
<div class="top-bar">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo-title d-flex align-items-center">
            <h2 style="margin: 0;">MediCare</h2>
            <img src="images/medical-heart-logo-icon-vector-260nw-2477158081.webp" alt="Logo" class="top-logo">
        </div>
        <div class="top-login">
            <a href="login.jsp" class="btn btn-outline-primary btn-lg">Sign in</a>
        </div>
    </div>
</div>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
    <div class="container justify-content-center">
        <ul class="navbar-nav d-flex justify-content-center gap-5">
            <li class="nav-item">
                <a class="nav-link text-white font-weight-bold" href="index.jsp">HOME</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white font-weight-bold" href="doctor_list.jsp">DOCTORS</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white font-weight-bold" href="feedback.jsp">FEEDBACK</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white font-weight-bold" href="about.jsp">ABOUT US</a>
            </li>
        </ul>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="hero-overlay"></div>
    <div class="hero-container d-flex justify-content-between align-items-center px-5">
        <div class="hero-text">
            <h1 id="hero-heading" class="display-4 font-weight-bold">We Care For Your Health</h1>
            <p id="hero-subtext" class="lead">
                Trusted healthcare at your fingertips. Book appointments, manage your visits, and get expert support easily.
            </p>
            <a href="login.jsp?redirect=book" class="btn btn-primary btn-lg mt-3">Book an Appointment</a>
        </div>
        <div class="hero-content">
            <img src="images/banner-main.png" alt="Doctor Image">
        </div>
    </div>
</section>

<!-- Rotating Hero Text Script -->
<script>
    const headings = [
        "We Care For Your Health",
        "Your Health, Our Priority",
        "Expert Doctors. Quality Care."
    ];
    const subtexts = [
        "Trusted healthcare at your fingertips. Book appointments, manage your visits, and get expert support easily.",
        "Book appointments easily and manage visits seamlessly with our reliable system.",
        "Connecting you with professionals for the best care and timely medical support."
    ];

    let index = 0;
    function rotateHeroText() {
        const headingEl = document.getElementById("hero-heading");
        const subtextEl = document.getElementById("hero-subtext");

        headingEl.textContent = headings[index];
        subtextEl.textContent = subtexts[index];
        index = (index + 1) % headings.length;
    }
    setInterval(rotateHeroText, 4000);
</script>

<!-- Footer -->
<footer class="footer-section pt-4">
    <div class="container">
        <div class="row">
            <div class="col-12 col-md-4">
                <h5>MediCare</h5>
                <p>Your trusted partner in healthcare. We’re here to help you stay healthy and informed.</p>
            </div>
            <div class="col-md-4">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="doctor_list.jsp">Doctors</a></li>
                    <li><a href="feedback.jsp">Feedback</a></li>
                    <li><a href="about.jsp">About Us</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5>Contact Us</h5>
                <p>Email: info@medicare.com</p>
                <p>Phone: +94 77 123 4567</p>
            </div>
        </div>
        <hr>
        <div class="text-center pb-3">
            &copy; 2025 MediCare. All rights reserved.
        </div>
    </div>
</footer>

<%
    boolean loggedIn = (session != null && session.getAttribute("username") != null);
    String role = loggedIn ? (String) session.getAttribute("role") : "";
%>

<script>
    window.onpopstate = function () {
        <% if (loggedIn) { %>
        <% if ("patient".equals(role)) { %>
        window.location.href = "dashboard.jsp";
        <% } else if ("admin".equals(role)) { %>
        window.location.href = "admin_dashboard.jsp";
        <% } else if ("doctor".equals(role)) { %>
        window.location.href = "doctor_dashboard.jsp";
        <% } %>
        <% } %>
    };
</script>

</body>
</html>
