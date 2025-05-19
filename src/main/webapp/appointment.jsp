<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.io.*" %>
<%
    /*
    if (session == null || session.getAttribute("username") == null || !"patient".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp?redirect=book");
        return;
    }

     */

    String doctorName = request.getParameter("doctorName");
    String specialization = request.getParameter("specialization");
    List<String[]> matchedDoctors = new ArrayList<>();

    if (doctorName != null && !doctorName.trim().isEmpty()) {
        BufferedReader reader = new BufferedReader(new FileReader(application.getRealPath("data/doctors.txt")));
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split("\\|"); // ID|Name|Spec|Status|TimeSlots|Gender|Fee
            if (parts.length >= 6 &&
                    parts[0].toLowerCase().contains(doctorName.toLowerCase()) &&
                    (specialization == null || specialization.isEmpty() || parts[5].equalsIgnoreCase(specialization))) {
                matchedDoctors.add(parts);
            }
        }
        reader.close();

        if (!matchedDoctors.isEmpty()) {
            session.setAttribute("matchedDoctors", matchedDoctors);
            response.sendRedirect("bookappointment.jsp");
            return;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Appointment - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/appointment.css">
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
<div class="main-content container mt-5">
    <h3 class="text-center mb-4">Search and Book an Appointment</h3>
    <form method="get" action="appointment.jsp" class="form-row">
        <div class="form-group col-md-6">
            <label for="doctorName">Doctor name</label>
            <input type="text" class="form-control" id="doctorName" name="doctorName" placeholder="Search Doctor Name" required>
        </div>
        <div class="form-group col-md-4">
            <label for="specialization">Specialization</label>
            <select class="form-control" id="specialization" name="specialization">
                <option value="">Select Specialization</option>
                <option value="Cardiologist">Cardiologist</option>
                <option value="Neurologist">Neurologist</option>
                <option value="General Physician">General Physician</option>
                <option value="Orthopaedic Surgeon">Orthopaedic Surgeon</option>
                <option value="Dermatologist">Dermatologist</option>
                <option value="Psychiatrist">Psychiatrist</option>
                <option value="Cardiothoracic Surgeon">Cardiothoracic Surgeon</option>
                <option value="Plastic Surgeon">Plastic Surgeon</option>
                <option value="ENT Surgeon">ENT Surgeon</option>
            </select>
        </div>
        <div class="form-group col-md-2 d-flex align-items-end">
            <button type="submit" class="btn btn-primary btn-block">Search</button>
        </div>
    </form>
    <% if (doctorName != null && matchedDoctors.isEmpty()) { %>
    <div class="alert alert-danger mt-4">❌ No matching doctor found. Please try again.</div>
    <% } %>

</div>
<%@ include file="includes/footer2.jsp" %>
</body>
</html>
