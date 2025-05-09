<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.io.*" %>
<html>
<head>
    <title>Submit Feedback</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .profile-pic {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<%
    /*
    // Ensure only patients can access this page
    if (session == null || session.getAttribute("username") == null || !"patient".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

     */

    String username = (String) session.getAttribute("username");
%>

<jsp:include page="includes/topbar2.jsp" />
<jsp:include page="includes/navbar2.jsp" />

<main>
    <div class="container my-4">
        <h2 class="text-center mb-4">Submit Your Feedback</h2>

        <form action="SubmitFeedbackServlet" method="post">
            <!-- Hidden username field -->
            <input type="hidden" name="username" value="<%= username %>">

            <div class="form-group">
                <label for="doctorName">Doctor Name</label>
                <input type="text" class="form-control" id="doctorName" name="doctorName" required>
            </div>

            <div class="form-group">
                <label for="message">Feedback</label>
                <textarea class="form-control" id="message" name="message" rows="4" required></textarea>
            </div>

            <div class="form-group">
                <label for="rating">Rating (1 to 5)</label>
                <select class="form-control" id="rating" name="rating" required>
                    <option value="">Select rating</option>
                    <option value="1">1 - Poor</option>
                    <option value="2">2 - Fair</option>
                    <option value="3">3 - Good</option>
                    <option value="4">4 - Very Good</option>
                    <option value="5">5 - Excellent</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Submit Feedback</button>
        </form>
    </div>
</main>

<jsp:include page="includes/footer2.jsp" />
</body>

</html>
