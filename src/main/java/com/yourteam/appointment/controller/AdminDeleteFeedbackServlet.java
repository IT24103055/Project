package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.*;
        import com.yourteam.appointment.utils.FeedbackUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

        import java.io.IOException;

@WebServlet("/AdminDeleteFeedbackServlet")
public class AdminDeleteFeedbackServlet extends HttpServlet {

    private String getFeedbackFilePath(HttpServletRequest request) {
        return getServletContext().getRealPath("/data/feedback.txt");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullLine = request.getParameter("fullLine");
        String filePath = getFeedbackFilePath(request);

        Feedback toDelete = null;

        String[] parts = fullLine.split("\\|");

        if (parts.length == 5 && "doctor".equalsIgnoreCase(parts[0])) {
            toDelete = new DoctorFeedback(parts[1], parts[2], parts[3], parts[4]);
        } else if (parts.length == 4 && "system".equalsIgnoreCase(parts[0])) {
            toDelete = new SystemFeedback(parts[1], parts[2], parts[3]);
        }

        boolean deleted = false;
        if (toDelete != null) {
            deleted = FeedbackUtil.deleteFeedback(filePath, toDelete);
        }

        if (deleted) {
            request.setAttribute("successMessage", "Feedback deleted successfully.");
        } else {
            request.setAttribute("errorMessage", "Feedback not found or could not be deleted.");
        }

        request.getRequestDispatcher("DeleteFeedback.jsp").forward(request, response);
    }
}
