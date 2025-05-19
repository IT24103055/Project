package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Patient;
import com.yourteam.appointment.utils.PatientUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    private String getPatientFilePath(HttpServletRequest request) {
        return getServletContext().getRealPath("/data/patients.txt");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
            return;
        }

        String filePath = getPatientFilePath(request);
        List<Patient> patients = PatientUtil.getAllPatients(filePath);
        boolean found = false;

        for (Patient p : patients) {
            if (p.getEmail().equalsIgnoreCase(email)) {
                p.setPassword(newPassword);
                found = true;
                break;
            }
        }

        if (found) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, false))) {
                for (Patient p : patients) {
                    writer.write(String.join("|",
                            p.getName(),
                            p.getEmail(),
                            p.getPassword(),
                            p.getNic(),
                            p.getGender()));
                    writer.newLine();
                }
            }

            request.setAttribute("successMessage", "Password updated successfully.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "No patient found with that email.");
            request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
        }
    }
}
