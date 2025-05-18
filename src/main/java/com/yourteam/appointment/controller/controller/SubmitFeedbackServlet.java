package com.yourteam.appointment.controller.controller;

import com.yourteam.appointment.model.*;
import com.yourteam.appointment.utils.FeedbackUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;

@WebServlet("/SubmitFeedbackServlet")
public class SubmitFeedbackServlet extends HttpServlet {

    private static final String FEEDBACK_FILE = "data/feedback.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data
        String type = request.getParameter("type");
        String username = request.getParameter("username");
        String doctorName = request.getParameter("doctorName");
        String message = request.getParameter("message");
        String rating = request.getParameter("rating");

        // Validate
        if (type == null || username == null || message == null || rating == null ||
                username.isEmpty() || message.isEmpty() || rating.isEmpty()) {
            response.sendRedirect("submitfeedback.jsp?error=missing");
            return;
        }

        Feedback feedback;

        if ("doctor".equalsIgnoreCase(type) && doctorName != null && !doctorName.isEmpty()) {
            feedback = new DoctorFeedback(username, doctorName, message, rating);
        } else if ("system".equalsIgnoreCase(type)) {
            feedback = new SystemFeedback(username, message, rating);
        } else {
            response.sendRedirect("submitfeedback.jsp?error=invalidtype");
            return;
        }

        // Save to file
        String filePath = getServletContext().getRealPath(FEEDBACK_FILE);
        FeedbackUtil.saveFeedback(feedback, filePath);

        // Redirect on success
        response.sendRedirect("myfeedback.jsp?success=true");
    }
}
