package com.yourteam.appointment.controller.controller;

import com.yourteam.appointment.model.*;
import com.yourteam.appointment.utils.FeedbackUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/EditFeedbackServlet")
public class EditFeedbackServlet extends HttpServlet {

    private static final String FEEDBACK_FILE = "/data/feedback.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String loggedInUser = (String) request.getSession().getAttribute("username");
        String role = (String) request.getSession().getAttribute("role");

        String type = request.getParameter("type");
        String username = request.getParameter("username");
        String originalMessage = request.getParameter("originalMessage");
        String originalRating = request.getParameter("originalRating");
        String doctorName = request.getParameter("doctorName");

        String newMessage = request.getParameter("newMessage");
        String newRating = request.getParameter("newRating");

        if (loggedInUser == null || role == null || !"patient".equals(role) || !loggedInUser.equals(username)) {
            response.sendRedirect("myfeedback.jsp?error=unauthorized");
            return;
        }

        Feedback original;
        Feedback updated;

        if ("doctor".equalsIgnoreCase(type)) {
            original = new DoctorFeedback(username, doctorName, originalMessage, originalRating);
            updated = new DoctorFeedback(username, doctorName, newMessage, newRating);
        } else {
            original = new SystemFeedback(username, originalMessage, originalRating);
            updated = new SystemFeedback(username, newMessage, newRating);
        }

        String filePath = getServletContext().getRealPath(FEEDBACK_FILE);
        boolean success = FeedbackUtil.updateFeedback(filePath, original, updated);

        if (success) {
            response.sendRedirect("myfeedback.jsp?updated=true");
        } else {
            response.sendRedirect("myfeedback.jsp?error=editfail");
        }
    }
}
