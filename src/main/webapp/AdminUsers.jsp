<%@ page import="java.util.*, java.io.*" %>
<%@ page import="com.yourteam.appointment.model.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    List<Admin> admins = new ArrayList<>();
    String filePath = application.getRealPath("/data/admins.txt");
    File file = new File(filePath);

    if (file.exists()) {
        BufferedReader reader = new BufferedReader(new FileReader(file));
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split("\\|");
            if (parts.length == 6) {
                admins.add(new Admin(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]));
            }
        }
        reader.close();
    }

    request.setAttribute("admins", admins);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Users</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/AdminUsers.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .top-logo { width: 50px; margin-left: 10px; }
        .profile-pic { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
        .admin-navbar { background-color: #343a40; padding: 10px 0; }
        .admin-navbar a { color: white; margin: 0 15px; font-weight: 500; }
        .admin-navbar a:hover { text-decoration: underline; }
        .container { flex: 1; }
        .footer-section { background-color: #343a40; color: #ffffff; padding: 20px 0; text-align: center; }
    </style>
</head>
<body>
<%@ include file="includes/admintopbar.jsp" %>
<%@ include file="includes/adminavbar.jsp" %>

<div class="container mt-4">
    <h4 class="text-center font-weight-bold mb-4">Registered Admin Users</h4>

    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
        <tr>
            <th>Full Name</th>
            <th>Email</th>
            <th>NIC</th>
            <th>Gender</th>
            <th>Role</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty admins}">
                <c:forEach var="admin" items="${admins}">
                    <tr>
                        <td>${admin.name}</td>
                        <td>${admin.email}</td>
                        <td>${admin.nic}</td>
                        <td>${admin.gender}</td>
                        <td>${admin.role}</td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr><td colspan="5" class="text-center">No admins found.</td></tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>
<%@ include file="includes/adminfooter.jsp" %>

</body>
</html>
