<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.yourteam.appointment.model.*, com.yourteam.appointment.utils.FeedbackUtil" %>
<html>
<head>
    <title>My Feedback</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .profile-pic { width: 60px; height: 60px; border-radius: 50%; object-fit: cover; }
        html, body { height: 100%; }
        body { display: flex; flex-direction: column; }
        main { flex: 1; }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<%
    // Authentication block (optional)
    // if (session == null || session.getAttribute("username") == null || !"patient".equals(session.getAttribute("role"))) {
    //     response.sendRedirect("login.jsp");
    //     return;
    // }

    String currentUser = (String) session.getAttribute("username");
    String filePath = application.getRealPath("data/feedback.txt");
    List<Feedback> feedbackList = FeedbackUtil.getAllFeedback(filePath);
%>

<jsp:include page="includes/topbar2.jsp" />
<jsp:include page="includes/navbar2.jsp" />

<main>
    <div class="container my-4">
        <h2 class="text-center mb-4">All Patient Feedback</h2>

        <a href="submitfeedback.jsp" class="btn btn-primary mb-4">+ Add Feedback</a>

        <% if (feedbackList.isEmpty()) { %>
        <div class="alert alert-info text-center">No feedback has been submitted yet.</div>
        <% } else {
            for (Feedback fb : feedbackList) {
                boolean canEdit = fb.getUsername().equals(currentUser);
        %>
        <div class="feedback-box mb-3 p-3 border rounded">
            <p><strong>User:</strong> <%= fb.getUsername() %></p>
            <p><strong>Type:</strong> <%= fb.getFeedbackType() %></p>
            <p><strong>Rating:</strong> <%= fb.getRating() %> / 5</p>
            <p><strong>Message:</strong> <%= fb.getMessage() %></p>

            <% if (canEdit) { %>
            <form action="DeleteFeedbackServlet" method="post" class="d-inline">
                <input type="hidden" name="username" value="<%= fb.getUsername() %>">
                <input type="hidden" name="type" value="<%= (fb instanceof DoctorFeedback) ? "doctor" : "system" %>">
                <input type="hidden" name="doctorName" value="<%= (fb instanceof DoctorFeedback) ? ((DoctorFeedback) fb).getDoctorName() : "" %>">
                <input type="hidden" name="message" value="<%= fb.getMessage() %>">
                <input type="hidden" name="rating" value="<%= fb.getRating() %>">
                <button type="submit" class="btn btn-sm btn-danger">Delete</button>
            </form>

            <form action="editfeedback.jsp" method="get" class="d-inline">
                <input type="hidden" name="username" value="<%= fb.getUsername() %>">
                <input type="hidden" name="type" value="<%= (fb instanceof DoctorFeedback) ? "doctor" : "system" %>">
                <input type="hidden" name="doctorName" value="<%= (fb instanceof DoctorFeedback) ? ((DoctorFeedback) fb).getDoctorName() : "" %>">
                <input type="hidden" name="message" value="<%= fb.getMessage() %>">
                <input type="hidden" name="rating" value="<%= fb.getRating() %>">
                <button type="submit" class="btn btn-sm btn-secondary">Edit</button>
            </form>
            <% } %>
        </div>
        <% } } %>
    </div>
</main>

<jsp:include page="includes/footer2.jsp" />
</body>
</html>
