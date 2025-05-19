package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Appointment;
import com.yourteam.appointment.utils.AppointmentUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

@WebServlet("/MyAppointmentsServlet")
public class MyAppointmentsServlet extends HttpServlet {

    private String getAppointmentFilePath(HttpServletRequest request) {
        return getServletContext().getRealPath("/data/appointments.txt");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("nic") == null || !"patient".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String nic = (String) session.getAttribute("nic");
        String filePath = getAppointmentFilePath(request);
        List<Appointment> allAppointments = AppointmentUtil.getAllAppointments(filePath);

        // Filter only current patient's appointments
        List<Appointment> userAppointments = new ArrayList<>();
        for (Appointment appt : allAppointments) {
            if (appt.getNic().equals(nic)) {
                userAppointments.add(appt);
            }
        }

        // Store all appointments for the user
        session.setAttribute("appointments", userAppointments);

        // Get filter type (paid/unpaid) and pass it to the JSP
        String filter = request.getParameter("filter");
        request.setAttribute("filter", filter);

        request.getRequestDispatcher("myappointments.jsp").forward(request, response);
    }
}
