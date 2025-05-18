<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="com.yourteam.appointment.model.Admin" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin Profile - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .profile-pic { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
        .admin-navbar { background-color: #343a40; padding: 10px 0; }
        .admin-navbar a { color: white; margin: 0 15px; font-weight: 500; }
        .admin-navbar a:hover { text-decoration: underline; }
        .footer-section { background-color: #343a40; color: #ffffff; padding: 20px 0; }
    </style>

    <script>
        function enableEdit() {
            document.querySelectorAll("input").forEach(e => e.removeAttribute("readonly"));
            document.getElementById("updateBtn").disabled = false;
        }
    </script>
</head>
<body>

<%@ include file="includes/admintopbar.jsp" %>
<%@ include file="includes/adminavbar.jsp" %>

<%
    String adminFile = application.getRealPath("data/admins.txt");
    String username = (String) session.getAttribute("username");
    Admin loggedAdmin = null;

    try (BufferedReader reader = new BufferedReader(new FileReader(adminFile))) {
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split("\\|");
            if (parts.length == 6 && parts[0].equalsIgnoreCase(username)) {
                loggedAdmin = new Admin(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
                break;
            }
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
%>

<div class="container mt-5">
    <h2 class="text-center">Admin Profile</h2>
    <form action="UpdateAdminServlet" method="post" class="mt-4">
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="fullname" class="form-control" value="<%= loggedAdmin != null ? loggedAdmin.getName() : "" %>" readonly>
        </div>
        <div class="form-group">
            <label>Email</label>
            <input type="text" name="email" class="form-control" value="<%= loggedAdmin != null ? loggedAdmin.getEmail() : "" %>" readonly>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="text" name="password" class="form-control" value="<%= loggedAdmin != null ? loggedAdmin.getPassword() : "" %>" readonly>
        </div>
        <div class="form-group">
            <label>NIC</label>
            <input type="text" name="nic" class="form-control" value="<%= loggedAdmin != null ? loggedAdmin.getNic() : "" %>" readonly>
        </div>
        <div class="form-group">
            <label>Gender</label>
            <input type="text" name="gender" class="form-control" value="<%= loggedAdmin != null ? loggedAdmin.getGender() : "" %>" readonly>
        </div>
        <div class="form-group">
            <label>Role</label>
            <input type="text" name="role" class="form-control" value="<%= loggedAdmin != null ? loggedAdmin.getRole() : "" %>" readonly>
        </div>
        <button type="button" class="btn btn-secondary" onclick="enableEdit()">Edit</button>
        <button type="submit" class="btn btn-primary" id="updateBtn" disabled>Update</button>
    </form>
</div>

<%@ include file="includes/adminfooter.jsp" %>
</body>
</html>
