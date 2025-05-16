package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Patient;
import com.yourteam.appointment.utils.PatientUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/DeleteAccountServlet")
public class DeleteAccountServlet extends HttpServlet {

    private String getPatientFilePath(HttpServletRequest request) {
        return getServletContext().getRealPath("/data/patients.txt");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nic = request.getParameter("nic");
        String filePath = getPatientFilePath(request);

        List<Patient> allPatients = PatientUtil.getAllPatients(filePath);
        boolean removed = allPatients.removeIf(p -> p.getNic().equalsIgnoreCase(nic));

        if (removed) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, false))) {
                for (Patient p : allPatients) {
                    writer.write(String.join("|",
                            p.getName(),
                            p.getEmail(),
                            p.getNic(),
                            p.getGender(),
                            p.getPassword()));
                    writer.newLine();
                }
            }

            // Invalidate session
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }

            // Redirect with message
            response.sendRedirect("login.jsp?message=Account+deleted+successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to delete account. Patient not found.");
            request.getRequestDispatcher("patientDashboard.jsp").forward(request, response);
        }
    }
}
