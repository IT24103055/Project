<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="com.yourteam.appointment.model.*" %>
<%@ page import="com.yourteam.appointment.utils.FeedbackUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Delete Feedback - MediCare</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        .top-logo { width: 50px; margin-left: 10px; }
        .profile-pic { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
        .admin-navbar { background-color: #343a40; padding: 10px 0; }
        .admin-navbar a { color: white; margin: 0 15px; font-weight: 500; }
        .admin-navbar a:hover { text-decoration: underline; }
        .top-bar {
            background-color: white;
            padding:25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            flex-direction: column;
        }
        .container {
            flex: 1 0 auto;
        }
        .footer-section {
            flex-shrink: 0;
            background-color: #343a40;
            color: #ffffff;
            padding: 30px 0;
            text-align: center;
            border-top: 1px solid #0056b3;
        }
        .footer-section a {
            color: #ffffff;
            text-decoration: none;
        }
        .footer-section a:hover {
            text-decoration: underline;
        }
        .table thead th {
            background-color: #343a40;
            color: white;
        }
    </style>
</head>
<body>

<%@ include file="includes/admintopbar.jsp" %>
<%@ include file="includes/adminavbar.jsp" %>

<div class="container mt-5">
    <h4 class="text-center font-weight-bold mb-4">All Feedback</h4>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger text-center">${errorMessage}</div>
    </c:if>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success text-center">${successMessage}</div>
    </c:if>

    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Type</th>
            <th>Given By</th>
            <th>About</th>
            <th>Message</th>
            <th>Rating</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            String filePath = application.getRealPath("/data/feedback.txt");
            List<Feedback> feedbacks = FeedbackUtil.getAllFeedback(filePath);

            for (Feedback f : feedbacks) {
                String type = (f instanceof DoctorFeedback) ? "Doctor" : "System";
                String about = (f instanceof DoctorFeedback) ? ((DoctorFeedback) f).getDoctorName() : "System";
        %>
        <tr>
            <td><%= type %></td>
            <td><%= f.getUsername() %></td>
            <td><%= about %></td>
            <td><%= f.getMessage() %></td>
            <td><%= f.getRating() %></td>
            <td>
                <form method="post" action="AdminDeleteFeedbackServlet">
                    <input type="hidden" name="fullLine" value="<%= f.toFileString() %>">
                    <button class="btn btn-sm btn-danger" type="submit">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<%@ include file="includes/adminfooter.jsp" %>

</body>
</html>
