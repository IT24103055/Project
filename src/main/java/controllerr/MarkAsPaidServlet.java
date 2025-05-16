package com.yourteam.appointment.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;

@WebServlet("/MarkAsPaidServlet")
public class MarkAsPaidServlet extends HttpServlet {

    private static final String APPOINTMENTS_FILE = "data/appointments.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nic = request.getParameter("nic");
        String date = request.getParameter("date");
        String doctor = request.getParameter("doctor");
        String timeSlot = request.getParameter("timeSlot");

        if (nic == null || date == null || doctor == null || timeSlot == null) {
            response.sendRedirect("payment.jsp?error=missingparams");
            return;
        }

        String filePath = getServletContext().getRealPath(APPOINTMENTS_FILE);
        File inputFile = new File(filePath);
        File tempFile = new File(filePath + ".tmp");

        boolean updated = false;

        try (
                BufferedReader reader = new BufferedReader(new FileReader(inputFile));
                BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))
        ) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1); // Split with all fields preserved

                if (parts.length == 10 &&
                        parts[1].equalsIgnoreCase(nic) &&
                        parts[2].equalsIgnoreCase(doctor) &&
                        parts[4].equals(date) &&
                        parts[6].equals(timeSlot) &&
                        parts[9].equalsIgnoreCase("false")) {

                    parts[9] = "true"; // mark as paid
                    line = String.join(",", parts);
                    updated = true;
                }

                writer.write(line);
                writer.newLine();
            }
        }

        // Replace old file
        if (inputFile.delete() && tempFile.renameTo(inputFile)) {
            if (updated) {
                response.sendRedirect("payment.jsp?success=marked");
            } else {
                response.sendRedirect("payment.jsp?error=notfound");
            }
        } else {
            response.sendRedirect("payment.jsp?error=fileerror");
        }
    }
}

