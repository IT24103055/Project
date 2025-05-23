<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.yourteam.appointment.model.Patient" %>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Profile - MediCare</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/profileDashboard.css">
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

<%@ include file="includes/navbar2.jsp" %>

<%
  Patient patient = (Patient) session.getAttribute("user");
  if (patient == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>

<!-- Profile and Form Section -->
<div class="container mt-5">
  <div class="row">

    <!-- Left Side -->
    <div class="col-md-4 d-flex justify-content-center">
      <div class="card text-center p-4 shadow-sm w-100">
        <img src="images/icon.jpeg" alt="Profile Picture" class="rounded-circle mb-3 profile-img">
        <h5 class="mb-3">Welcome, <%= patient.getName() %>!</h5>
        <a href="patientDashboard.jsp" class="btn btn-primary btn-block mb-2">My Profile</a>
        <a href="resetPassword.jsp" class="btn btn-warning btn-block mb-2">Reset Password</a>
        <a href="logout.jsp" class="btn btn-danger btn-block">Logout</a>
      </div>
    </div>

    <!-- Right Side: Form -->
    <div class="col-md-8">
      <div class="profile-box shadow-sm p-4">
        <h4 class="mb-4 font-weight-bold text-center">Edit Profile</h4>
        <form action="ProfileServlet" method="post">

          <div class="form-group">
            <label for="fullname">Full Name</label>
            <input type="text" class="form-control" id="fullname" name="fullname" required value="<%= patient.getName() %>">
          </div>

          <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" class="form-control" id="email" name="email" required value="<%= patient.getEmail() %>">
          </div>

          <div class="form-group">
            <label for="nic">NIC</label>
            <input type="text" class="form-control" id="nic" name="nic" readonly value="<%= patient.getNic() %>">
          </div>

          <div class="form-group">
            <label for="gender">Gender</label>
            <select class="form-control" id="gender" name="gender" required>
              <option value="" disabled>Select your gender</option>
              <option value="Male" <%= "Male".equals(patient.getGender()) ? "selected" : "" %>>Male</option>
              <option value="Female" <%= "Female".equals(patient.getGender()) ? "selected" : "" %>>Female</option>
              <option value="Other" <%= "Other".equals(patient.getGender()) ? "selected" : "" %>>Other</option>
            </select>
          </div>

          <!-- Action Buttons -->
          <div class="d-flex justify-content-end mt-4">
            <a href="patientDashboard.jsp" class="btn btn-secondary mr-2">Cancel</a>
            <button type="submit" class="btn btn-primary">Update</button>
          </div>

        </form>
      </div>
    </div>

  </div>
</div>

<%@ include file="includes/footer2.jsp" %>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>
