<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.io.*" %>

<%
  String userDisplay = (String) session.getAttribute("username");
  if (userDisplay == null || userDisplay.isEmpty()) {
    userDisplay = "Admin";
  }

  String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
  <title>Search Patient for Payment</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/style.css">
  <style>
    body, html { height: 100%; }
    body { display: flex; flex-direction: column; }
    main { flex: 1; }
    .top-logo { width: 50px; margin-left: 10px; }
    .profile-pic { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
    .admin-navbar { background-color: #343a40; padding: 10px 0; }
    .admin-navbar a { color: white; margin: 0 15px; font-weight: 500; }
    .admin-navbar a:hover { text-decoration: underline; }
    .footer-section { background-color: #343a40; color: #ffffff; padding: 20px 0; }
  </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Top Bar -->
<div class="top-bar py-2 bg-white shadow-sm">
  <div class="container d-flex justify-content-between align-items-center">
    <div class="d-flex align-items-center">
      <h4 class="mb-0 mr-2">MediCare</h4>
      <img src="images/logo.jpg" alt="Logo" class="top-logo">
    </div>

    <div class="dropdown">
      <a class="dropdown-toggle d-flex align-items-center" href="#" id="adminDropdown"
         role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <img src="images/user.jpg" class="profile-pic mr-2" alt="Admin Profile">
        <%= userDisplay %>
      </a>
      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="adminDropdown">
        <a class="dropdown-item" href="adminprofile.jsp">Profile</a>
        <a class="dropdown-item" href="LogoutServlet">Logout</a>
      </div>
    </div>
  </div>
</div>

<!-- Admin Navbar -->
<div class="admin-navbar text-center">
  <a href="AdminDashboard.jsp">Admin Dashboard</a>
  <a href="AdminManagement.jsp">Admin Management</a>
  <a href="doctormanage.jsp">Doctor Management</a>
  <a href="paymentsearch.jsp">Payment Management</a>
</div>

<!-- Main Content -->
<main>
  <div class="container mt-5">
    <h3 class="text-center mb-4">Search Patient for Payment</h3>

    <% if (error != null) { %>
    <div class="alert alert-danger text-center"><%= error %></div>
    <% } %>

    <form action="PaymentSearchServlet" method="post" class="d-flex justify-content-center align-items-center">
      <div class="form-group mx-2">
        <label>Search by NIC or Name</label>
        <input type="text" name="searchQuery" class="form-control" placeholder="Enter NIC or Name" required>
      </div>
      <div class="form-group mt-4 mx-2">
        <button type="submit" class="btn btn-primary">Search</button>
      </div>
    </form>
  </div>
</main>

<!-- Footer -->
<footer class="footer-section text-center mt-auto">
  <div class="container">
    <p>&copy; 2025 MediCare Medical Appointment System. All rights reserved.</p>
  </div>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

