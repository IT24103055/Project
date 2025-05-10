<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
   /*
    // Ensure only logged-in patients can access
    if (session == null || session.getAttribute("username") == null || !"patient".equals(session.getAttribute("role"))) {
        response.sendRedirect("index.jsp");
        return;
    }

    */









    String currentUser = (String) session.getAttribute("username");
 %>

<!DOCTYPE html>
<html>
<head>
    <title>Patient Dashboard - MediCare</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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

<jsp:include page="includes/topbar2.jsp" />
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
    <div class="container justify-content-center">
        <ul class="navbar-nav d-flex justify-content-center gap-5">
            <li class="nav-item">
                <a class="nav-link text-white font-weight-bold" href="dashboard.jsp">HOME</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white font-weight-bold" href="myappointments.jsp">MY APPOINTMENTS</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white font-weight-bold" href="doctor_list2.jsp">DOCTORS</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white font-weight-bold" href="myfeedback.jsp">FEEDBACK</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white font-weight-bold" href="about2.jsp">ABOUT US</a>
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
            <a href="appointment.jsp" class="btn btn-primary btn-lg mt-3">Book an Appointment</a>
        </div>
        <div class="hero-content">
            <img src="images/banner-main.png" alt="Doctor Image">
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer-section pt-4">
    <div class="container">
        <div class="row">
            <!-- About -->
            <div class="col-12 col-md-4">
                <h5>MediCare</h5>
                <p>Your trusted partner in healthcare. We’re here to help you stay healthy and informed.</p>
            </div>
            <!-- Quick Links -->
            <div class="col-md-4">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="dashboard.jsp">Home</a></li>
                    <li><a href="myappointments.jsp">My Appointments</a></li>
                    <li><a href="doctor_list2.jsp">Doctors</a></li>
                    <li><a href="feedback.jsp">Feedback</a></li>
                    <li><a href="about.jsp">About Us</a></li>
                </ul>
            </div>
            <!-- Contact -->
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

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

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
        document.getElementById("hero-heading").textContent = headings[index];
        document.getElementById("hero-subtext").textContent = subtexts[index];
        index = (index + 1) % headings.length;
    }
    setInterval(rotateHeroText, 4000);
</script>

</body>
</html>
