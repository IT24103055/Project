package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Patient;
import com.yourteam.appointment.utils.PatientUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    private String getPatientFilePath(HttpServletRequest request) {
        return getServletContext().getRealPath("/data/patients.txt");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String nic = request.getParameter("nic");
        String gender = request.getParameter("gender");

        String filePath = getPatientFilePath(request);
        List<Patient> allPatients = PatientUtil.getAllPatients(filePath);

        Patient updatedPatient = null;
        boolean found = false;

        // Update the patient's data
        for (Patient p : allPatients) {
            if (p.getNic().equalsIgnoreCase(nic)) {
                p.setName(fullname);
                p.setEmail(email);
                p.setGender(gender);
                updatedPatient = p;
                found = true;
                break;
            }
        }

        if (found) {
            // Write updated data back to the file
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, false))) {
                for (Patient p : allPatients) {
                    writer.write(String.join("|",
                            p.getName(),
                            p.getEmail(),
                            p.getPassword(),
                            p.getNic(),
                            p.getGender()));// preserve original password

                    writer.newLine();
                }
            }

            // Update the session with new patient object
            HttpSession session = request.getSession();
            session.setAttribute("user", updatedPatient);
            session.setAttribute("username", updatedPatient.getName());

            request.setAttribute("successMessage", "Profile updated successfully.");
            request.getRequestDispatcher("patientDashboard.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Patient not found.");
            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
        }
    }
}
