%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ page import="java.util.*, com.yourteam.appointment.model.*, com.yourteam.appointment.utils.PaymentUtil" %>

<%
  String userDisplay = (String) session.getAttribute("username");
  if (userDisplay == null || userDisplay.isEmpty()) {
    userDisplay = "Admin";
  }
  String error = (String) request.getAttribute("error");

  List<Patient> matchedPatients = (List<Patient>) session.getAttribute("matchedPatients");
  if (matchedPatients == null || matchedPatients.isEmpty()) {
    response.sendRedirect("paymentsearch.jsp");
    return;
  }

  // Extract NIC and name
  String patientName = matchedPatients.get(0).getName();
  String patientNIC = matchedPatients.get(0).getNic();

  // Load unpaid appointments using PaymentUtil
  String path = application.getRealPath("data/appointments.txt");
  List<Appointment> unpaidAppointments = PaymentUtil.getUnpaidAppointmentsFor(patientNIC, path);
%>

<!DOCTYPE html>
<html>
<head>
  <title>Unpaid Appointments - MediCare</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/style.css">
  <style>
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
  <a href="admindashboard.jsp">Admin Dashboard</a>
  <a href="adminmanagement.jsp">Admin Management</a>
  <a href="doctormanage.jsp">Doctor Management</a>
  <a href="paymentsearch.jsp">Payment Management</a>
</div>

<!-- Main Content -->
<div class="container mt-5">
  <h3 class="text-center mb-4">Unpaid Appointments for <%= patientName %> (NIC: <%= patientNIC %>)</h3>

  <div class="text-right mb-3">
    <a href="paidappointments.jsp" class="btn btn-outline-primary">View Paid Appointments</a>
  </div>

  <% if (unpaidAppointments == null || unpaidAppointments.isEmpty()) { %>
  <div class="alert alert-info text-center">No unpaid appointments found.</div>
  <% } else { %>
  <table class="table table-bordered">
    <thead class="thead-dark">
    <tr>
      <th>Doctor</th>
      <th>Date</th>
      <th>Time</th>
      <th>Fee</th>
      <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <% for (Appointment a : unpaidAppointments) { %>
    <tr>
      <td><%= a.getDoctorName() %></td>
      <td><%= a.getDate() %></td>
      <td><%= a.getTimeSlot() %></td>
      <td>Rs. <%= a.getFee() %></td>
      <td>
        <form action="MarkAsPaidServlet" method="post" class="d-inline">
          <input type="hidden" name="nic" value="<%= a.getNic() %>">
          <input type="hidden" name="date" value="<%= a.getDate() %>">
          <input type="hidden" name="doctor" value="<%= a.getDoctorName() %>">
          <input type="hidden" name="timeSlot" value="<%= a.getTimeSlot() %>">
          <button type="submit" class="btn btn-success btn-sm">Mark as Paid</button>
        </form>

        <form action="CancelAppointmentServlet" method="post" class="d-inline ml-1">
          <input type="hidden" name="nic" value="<%= a.getNic() %>">
          <input type="hidden" name="date" value="<%= a.getDate() %>">
          <input type="hidden" name="doctorName" value="<%= a.getDoctorName() %>">
          <input type="hidden" name="timeSlot" value="<%= a.getTimeSlot() %>">
          <button type="submit" class="btn btn-danger btn-sm">Cancel</button>
        </form>

      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <% } %>
</div>

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
