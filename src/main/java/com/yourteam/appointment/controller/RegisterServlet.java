package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Patient;
import com.yourteam.appointment.utils.PatientUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private String getFilePath(HttpServletRequest request) {
        return getServletContext().getRealPath("/data/patients.txt");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String nic = request.getParameter("nic");
        String gender = request.getParameter("gender");

        String filePath = getFilePath(request);

        // Check if NIC already exists
        if (PatientUtil.isDuplicate(nic, filePath)) {
            request.setAttribute("errorMessage", "A patient with this NIC already exists.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Create new patient
        Patient patient = new Patient(name, email,password,nic,gender);

        // Write to file
        try (PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(filePath, true)))) {
            out.println(patient.toString());
        }

        // Show success message
        request.setAttribute("successMessage", "Registration successful. Please log in.");
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}
