<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.yourteam.appointment.utils.DoctorUtil" %>
<%@ page import="java.io.*" %>

<%
    /*
    if (session == null || session.getAttribute("username") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    */

    String userDisplay = (String) session.getAttribute("username");
    if (userDisplay == null || userDisplay.isEmpty()) {
        userDisplay = "Admin";
    }

    String basePath = application.getRealPath(""); // Base path to use for file reading

    String patientFile = basePath + File.separator + "data" + File.separator + "patients.txt";
    String adminFile = basePath + File.separator + "data" + File.separator + "admins.txt";
    String doctorFile = basePath + File.separator + "data" + File.separator + "doctors.txt"; // ✅ Corrected path

    int patientCount = 0;
    int adminCount = 0;
    int doctorCount = DoctorUtil.getDoctorCount(doctorFile);// ✅ Uses correct path

    BufferedReader reader;

    File pf = new File(patientFile);
    if (pf.exists()) {
        reader = new BufferedReader(new FileReader(pf));
        while (reader.readLine() != null) patientCount++;
        reader.close();
    }

    File af = new File(adminFile);
    if (af.exists()) {
        reader = new BufferedReader(new FileReader(af));
        while (reader.readLine() != null) adminCount++;
        reader.close();
    }
%>


<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f6f9;
        }

        .top-bar {
            background-color: white;
            padding: 20px 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .top-logo {
            height: 60px;
            width: auto;
            margin-left: 10px;
        }

        .profile-pic {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .navbar {
            background-color: #343a40;
        }

        .navbar .nav-link {
            color: #ffffff !important;
            font-weight: 500;
            transition: 0.3s;
        }

        .navbar .nav-link:hover {
            color: #ffc107 !important;
            text-decoration: underline;
        }

        .dashboard-box {
            background: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s;
        }

        .dashboard-box:hover {
            transform: scale(1.03);
        }

        .dashboard-box h1 {
            font-size: 48px;
            color: #007bff;
        }

        .footer {
            background-color: #343a40;
            color: #ffffff;
            padding: 20px 0;
            text-align: center;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Admin Top Bar -->
<div class="top-bar">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo-title d-flex align-items-center">
            <h2 style="margin: 0;">MediCare</h2>
            <img src="images/logo.jpg" alt="Logo" class="top-logo">
        </div>

        <div class="dropdown">
            <a class="dropdown-toggle d-flex align-items-center"
               href="#"
               id="adminDropdown"
               role="button"
               data-toggle="dropdown"
               aria-haspopup="true"
               aria-expanded="false">
                <img src="images/user.jpg" class="profile-pic mr-2" alt="Admin Profile">
                <%= userDisplay %>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="adminDropdown">
                <a class="dropdown-item" href="AdminProfile.jsp">Profile</a>
                <a class="dropdown-item" href="LogoutServlet">Logout</a>
            </div>
        </div>
    </div>
</div>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Admin Dashboard</a>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a class="nav-link" href="AdminManagement.jsp">Admin Management</a></li>
            <li class="nav-item"><a class="nav-link" href="doctormanage.jsp">Doctor Management</a></li>
            <li class="nav-item"><a class="nav-link" href="paymentsearch.jsp">Payment Management</a></li>
        </ul>
    </div>
</nav>

<!-- Dashboard Boxes -->
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-5 mb-4">
            <div class="dashboard-box">
                <h5>Registered Patients</h5>
                <h1><%= patientCount %></h1>
            </div>
        </div>
        <div class="col-md-5 mb-4">
            <div class="dashboard-box">
                <h5>Registered Doctors</h5>
                <h1><%= doctorCount %></h1>
            </div>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="dashboard-box">
                <h5>Registered Admins</h5>
                <h1><%= adminCount %></h1>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer mt-auto">
    <div class="container">
        <p>&copy; 2025 MediCare Medical Appointment System. All rights reserved.</p>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
