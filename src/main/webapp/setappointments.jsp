<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.io.*" %>

<%
    String doctorId = request.getParameter("doctorId");
    String[] matchedParts = null;

    if (doctorId != null && !doctorId.trim().isEmpty()) {
        BufferedReader reader = new BufferedReader(new FileReader(application.getRealPath("data/doctors.txt")));
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split("\\|");
            if (parts.length >= 5 && parts[3].equalsIgnoreCase(doctorId.trim())) {
                matchedParts = parts;
                break;
            }
        }
        reader.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Set Doctor Availability - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .top-logo { height: 50px; }
        .profile-pic { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
        .admin-navbar { background-color: #343a40; padding: 10px 0; }
        .admin-navbar a { color: white; margin: 0 15px; font-weight: 500; }
        .admin-navbar a:hover { text-decoration: underline; }
        .footer-section { background-color: #343a40; color: #ffffff; padding: 20px 0; }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- ✅ Admin Topbar and Navbar -->
<%@ include file="includes/admintopbar.jsp" %>
<%@ include file="includes/adminavbar.jsp" %>

<!-- 🔍 Search Doctor -->
<div class="container mt-4">
    <h3 class="text-center mb-4">Set Doctor Availability</h3>

    <form class="form-inline justify-content-center mb-4" method="get" action="setappointments.jsp">
        <input type="text" name="doctorId" class="form-control mr-2" placeholder="Enter Doctor ID" required>
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <% if (doctorId != null && matchedParts == null) { %>
    <div class="alert alert-danger text-center">❌ Doctor not found with ID: <%= doctorId %></div>
    <% } %>

    <% if (matchedParts != null) { %>
    <form method="post" action="SetAvailabilityServlet">
        <input type="hidden" name="doctorID" value="<%= matchedParts[3] %>">
        <input type="hidden" name="doctorName" value="<%= matchedParts[0] %>">
        <input type="hidden" name="specialization" value="<%= matchedParts[5] %>">
        <input type="hidden" name="gender" value="<%= matchedParts[4] %>">

        <!-- 👨‍⚕️ Doctor Info -->
        <div class="mb-3">
            <h5>👨‍⚕️ Doctor: <strong><%= matchedParts[0] %></strong> (ID: <%= matchedParts[3] %>)</h5>
            <h6>🔬 Specialization: <strong><%= matchedParts[5] %></strong></h6>
        </div>

        <!-- 📅 Availability Settings -->
        <div class="form-group">
            <label>Available Dates</label>
            <input type="text" name="dates" id="datePicker" class="form-control" placeholder="Pick multiple dates" required>
        </div>

        <div class="form-group">
            <label>Start Time</label>
            <input type="time" name="startTime" class="form-control" required>
        </div>

        <div class="form-group">
            <label>End Time</label>
            <input type="time" name="endTime" class="form-control" required>
        </div>

        <div class="form-group">
            <label>Consultation Fee (Rs)</label>
            <input type="number" name="fee" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-success">Update Availability</button>
    </form>
    <% } %>
</div>

<!-- ✅ Footer -->
<%@ include file="includes/adminfooter.jsp" %>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script>
    $('#datePicker').datepicker({
        format: 'yyyy-mm-dd',
        multidate: true,
        todayHighlight: true
    });
</script>
</body>
</html>
