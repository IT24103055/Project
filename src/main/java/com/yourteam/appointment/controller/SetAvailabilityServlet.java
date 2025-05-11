package com.yourteam.appointment.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/SetAvailabilityServlet")
public class SetAvailabilityServlet extends HttpServlet {

    private String getSessionFilePath(HttpServletRequest request) {
        return getServletContext().getRealPath("/data/doctor_sessions.txt");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form values
        String doctorID = request.getParameter("doctorID");
        String doctorName = request.getParameter("doctorName");
        String specialization = request.getParameter("specialization");
        String gender = request.getParameter("gender");

        String[] dates = request.getParameter("dates").split(",");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String fee = request.getParameter("fee");

        // Build session strings
        List<String> entries = new ArrayList<>();
        for (String date : dates) {
            String entry = doctorID + "|" + doctorName + "|" + specialization + "|" + gender + "|" +
                    date.trim() + "|" + startTime + "-" + endTime + "|" + fee;
            entries.add(entry);
        }

        // Write all to doctor_sessions.txt
        String filePath = getSessionFilePath(request);
        File file = new File(filePath);
        file.getParentFile().mkdirs();

        try (PrintWriter writer = new PrintWriter(new FileWriter(file, true))) {
            for (String entry : entries) {
                writer.println(entry);
            }
        }

        // Redirect back with success
        response.sendRedirect("setappointments.jsp?success=true");
    }
}
