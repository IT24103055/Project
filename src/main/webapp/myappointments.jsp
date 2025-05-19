<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="com.yourteam.appointment.model.Appointment" %>

<%
    String filter = (String) request.getAttribute("filter");
    if (filter == null) filter = "";

    List<Appointment> allAppointments = (List<Appointment>) session.getAttribute("appointments");
    if (allAppointments == null) {
        allAppointments = new ArrayList<>();
    }

    List<Appointment> filteredAppointments = allAppointments;
    if ("paid".equals(filter)) {
        filteredAppointments = allAppointments.stream()
                .filter(Appointment::isPaid)
                .collect(Collectors.toList());
    } else if ("unpaid".equals(filter)) {
        filteredAppointments = allAppointments.stream()
                .filter(appt -> !appt.isPaid())
                .collect(Collectors.toList());
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Appointments – MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/myappointments.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="includes/topbar2.jsp" %>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
    <div class="container">
        <ul class="navbar-nav mx-auto">
            <li class="nav-item"><a class="nav-link" href="dashboard.jsp">HOME</a></li>
            <li class="nav-item"><a class="nav-link" href="MyAppointmentsServlet">MY APPOINTMENTS</a></li>
            <li class="nav-item"><a class="nav-link" href="doctor_list2.jsp">DOCTORS</a></li>
            <li class="nav-item"><a class="nav-link" href="feedback.jsp">FEEDBACK</a></li>
            <li class="nav-item"><a class="nav-link" href="about.jsp">ABOUT US</a></li>
        </ul>
    </div>
</nav>

<div class="content-wrapper my-5">
    <h2 class="mb-4 text-center">My Appointments</h2>

    <div class="text-center mb-4">
        <a href="MyAppointmentsServlet?filter=unpaid" class="btn <%= "unpaid".equals(filter) ? "btn-warning" : "btn-outline-warning" %> mr-2">Appointments</a>
        <a href="MyAppointmentsServlet?filter=paid" class="btn <%= "paid".equals(filter) ? "btn-success" : "btn-outline-success" %>">Appointment History</a>
    </div>

    <%
        if (filteredAppointments.isEmpty()) {
    %>
    <div class="alert alert-info text-center">No Appointments Found.</div>
    <%
    } else {
    %>
    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead class="thead-light">
            <tr>
                <th>Doctor Name</th>
                <th>Specialization</th>
                <th>Date</th>
                <th>Urgency</th>
                <th>Time Slot</th>
                <th>Queue # / Cancel</th>
                <th>Fee (Rs.)</th>
                <th>Payment Status</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Appointment appt : filteredAppointments) {
            %>
            <tr>
                <td><%= appt.getDoctorName() %></td>
                <td><%= appt.getSpecialization() %></td>
                <td><%= appt.getDate() %></td>
                <td><%= appt.getUrgency() %></td>
                <td><%= appt.getTimeSlot() %></td>
                <td>
                    <%= appt.getQueueNumber() %><br/>
                    <% if (!appt.isPaid()) { %>
                    <form method="post" action="CancelAppointmentServlet">
                        <input type="hidden" name="doctorName" value="<%= appt.getDoctorName() %>" />
                        <input type="hidden" name="date" value="<%= appt.getDate() %>" />
                        <input type="hidden" name="timeSlot" value="<%= appt.getTimeSlot() %>" />
                        <button type="submit" class="btn btn-sm btn-danger mt-2">Cancel</button>
                    </form>
                    <% } %>
                </td>
                <td><%= String.format("%.2f", appt.getFee()) %></td>
                <td>
                    <span class="<%= appt.isPaid() ? "text-success" : "text-danger" %>">
                        <%= appt.isPaid() ? "Paid" : "Pending" %>
                    </span>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <% } %>
</div>

<%@ include file="includes/footer.jsp" %>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
