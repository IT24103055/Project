<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.io.*" %>
<html>
<head>
    <title>My Feedback</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .profile-pic {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
        }
        html, body {
            height: 100%;
        }
        body {
            display: flex;
            flex-direction: column;
        }
        main {
            flex: 1;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<%
    /*
    if (session == null || session.getAttribute("username") == null || !"patient".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

     */

    String currentUser = (String) session.getAttribute("username");
%>

<jsp:include page="includes/topbar2.jsp" />
<jsp:include page="includes/navbar2.jsp" />

<main>
    <div class="container my-4">
        <h2 class="text-center mb-4">All Patient Feedback</h2>

        <a href="submitfeedback.jsp" class="btn btn-primary mb-4">+ Add Feedback</a>

        <%
            String feedbackFile = application.getRealPath("data/feedback.txt");
            File file = new File(feedbackFile);
            boolean feedbackAvailable = false;

            if (file.exists()) {
                BufferedReader reader = new BufferedReader(new FileReader(file));
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|"); // username|doctorName|message|rating
                    if (parts.length >= 4) {
                        feedbackAvailable = true;
                        String username = parts[0];
                        String doctorName = parts[1];
                        String message = parts[2];
                        String rating = parts[3];
                        boolean canEdit = username.equals(currentUser);
        %>
        <div class="feedback-box mb-3 p-3 border rounded">
            <p><strong>User:</strong> <%= username %></p>
            <p><strong>Doctor:</strong> <%= doctorName %></p>
            <p><strong>Rating:</strong> <%= rating %> / 5</p>
            <p><strong>Message:</strong> <%= message %></p>

            <% if (canEdit) { %>
            <form action="DeleteFeedbackServlet" method="post" class="d-inline">
                <input type="hidden" name="username" value="<%= username %>">
                <input type="hidden" name="doctorName" value="<%= doctorName %>">
                <input type="hidden" name="message" value="<%= message %>">
                <input type="hidden" name="rating" value="<%= rating %>">
                <button type="submit" class="btn btn-sm btn-danger">Delete</button>
            </form>

            <form action="editfeedback.jsp" method="get" class="d-inline">
                <input type="hidden" name="username" value="<%= username %>">
                <input type="hidden" name="doctorName" value="<%= doctorName %>">
                <input type="hidden" name="message" value="<%= message %>">
                <input type="hidden" name="rating" value="<%= rating %>">
                <button type="submit" class="btn btn-sm btn-secondary">Edit</button>
            </form>
            <% } %>
        </div>
        <%
                    }
                }
                reader.close();
            }

            if (!feedbackAvailable) {
        %>
        <div class="alert alert-info text-center">No feedback has been submitted yet.</div>
        <%
            }
        %>
    </div>
</main>

<jsp:include page="includes/footer2.jsp" />
</body>
</html>
