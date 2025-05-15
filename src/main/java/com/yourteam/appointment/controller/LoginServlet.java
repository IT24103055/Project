package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Patient;
import com.yourteam.appointment.model.Admin;
import com.yourteam.appointment.utils.PatientUtil;
import com.yourteam.appointment.utils.AdminUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private String getPatientFilePath(HttpServletRequest request) {
        return getServletContext().getRealPath("/data/patients.txt");
    }

    private String getAdminFilePath(HttpServletRequest request) {
        return getServletContext().getRealPath("/data/admins.txt");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nic = request.getParameter("nic");
        String password = request.getParameter("password");

        String patientFile = getPatientFilePath(request);
        String adminFile = getAdminFilePath(request);

        Patient patient = PatientUtil.authenticate(nic, password, patientFile);
        if (patient != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", patient);
            session.setAttribute("username", patient.getName());
            session.setAttribute("role", "patient");
            response.sendRedirect("dashboard.jsp");
            return;
        }

        Admin admin = AdminUtil.authenticate(nic, password, adminFile);
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", admin);
            session.setAttribute("username", admin.getName());
            session.setAttribute("role", "admin");
            response.sendRedirect("AdminDashboard.jsp");
            return;
        }

        request.setAttribute("error", "Invalid NIC or password.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}