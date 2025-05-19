<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.io.*" %>
<html>
<head>
    <title>Patient Feedback</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Extra fallback if Bootstrap fails */
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

<jsp:include page="includes/topbar.jsp" />
<jsp:include page="includes/navbar.jsp" />

<main>
    <div class="container my-4">
        <h2 class="text-center mb-4">What Our Patients Say</h2>

        <%
            String feedbackFile = application.getRealPath("data/feedback.txt");
            File file = new File(feedbackFile);
            boolean feedbackAvailable = false;

            if (file.exists()) {
                BufferedReader reader = new BufferedReader(new FileReader(file));
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\|"); // appointmentId|patientNIC|doctorId|message|rating
                    if (parts.length >= 5) {
                        feedbackAvailable = true;
        %>
        <div class="feedback-box">
            <p><strong>Rating:</strong> <%= parts[4] %> / 5</p>
            <p><%= parts[3] %></p>
        </div>
        <%
                    }
                }
                reader.close();
            }

            if (!feedbackAvailable) {
        %>
        <div class="alert alert-info text-center" role="alert">
            No feedback has been submitted yet.
        </div>
        <%
            }
        %>

        <hr>
        <p class="text-muted text-center">To add a feedback, you must <a href="login.jsp">login</a>.</p>
    </div>
</main>

<jsp:include page="includes/footer.jsp" />
</body>
</html>
