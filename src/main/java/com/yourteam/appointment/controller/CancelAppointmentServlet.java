package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Appointment;
import com.yourteam.appointment.utils.AppointmentUtil;
import com.yourteam.appointment.structures.PriorityQueueX;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.time.LocalTime;

@WebServlet("/CancelAppointmentServlet")
public class CancelAppointmentServlet extends HttpServlet {

    private String getAppointmentFilePath(HttpServletRequest request) {
        return getServletContext().getRealPath("/data/appointments.txt");
    }

    private String getSessionFilePath(HttpServletRequest request) {
        return getServletContext().getRealPath("/data/doctor_sessions.txt");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");

        String doctorName = request.getParameter("doctorName");
        String date = request.getParameter("date");
        String timeSlot = request.getParameter("timeSlot");
        String nic = request.getParameter("nic");

        if ((nic == null || nic.isEmpty()) && "patient".equals(role)) {
            nic = (String) session.getAttribute("nic");
        }

        if (nic == null || doctorName == null || date == null || timeSlot == null) {
            if ("main".equals(role) || "standard".equals(role)) {
                response.sendRedirect("payment.jsp");
            } else {
                response.sendRedirect("MyAppointmentsServlet");
            }
            return;
        }

        String filePath = getAppointmentFilePath(request);
        Appointment[] allAppointments = AppointmentUtil.getAllAppointmentsArray(filePath);
        Appointment[] updatedAppointments = new Appointment[200];
        int total = 0;

        Appointment canceled = null;

        for (int i = 0; i < allAppointments.length; i++) {
            Appointment appt = allAppointments[i];
            if (appt != null) {
                if (appt.getDoctorName().equals(doctorName)
                        && appt.getDate().equals(date)
                        && appt.getTimeSlot().equals(timeSlot)
                        && appt.getNic().equals(nic)
                        && !appt.isPaid()) {
                    canceled = appt;
                } else {
                    updatedAppointments[total++] = appt;
                }
            }
        }

        if (canceled == null) {
            if ("main".equals(role) || "standard".equals(role)) {
                response.sendRedirect("payment.jsp");
            } else {
                response.sendRedirect("MyAppointmentsServlet");
            }
            return;
        }

        // Find same-session appointments
        Appointment[] sameSessionAppointments = new Appointment[100];
        int ssCount = 0;
        for (int i = 0; i < total; i++) {
            Appointment a = updatedAppointments[i];
            if (a.getDoctorName().equals(doctorName) && a.getDate().equals(date)) {
                sameSessionAppointments[ssCount++] = a;
            }
        }

        // Get time slots
        LocalTime startTime = null, endTime = null;
        try (BufferedReader sessionReader = new BufferedReader(new FileReader(getSessionFilePath(request)))) {
            String line;
            while ((line = sessionReader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 6 && parts[1].equalsIgnoreCase(doctorName) && parts[4].equals(date)) {
                    String[] timeRange = parts[5].split("-");
                    startTime = LocalTime.parse(timeRange[0].trim());
                    endTime = LocalTime.parse(timeRange[1].trim());
                    break;
                }
            }
        }

        if (startTime != null && endTime != null) {
            String[] availableSlots = new String[100];
            int slotCount = 0;
            LocalTime temp = startTime;
            while (!temp.isAfter(endTime.minusMinutes(15))) {
                availableSlots[slotCount++] = temp.toString();
                temp = temp.plusMinutes(15);
            }

            // Priority queue logic
            PriorityQueueX queue = new PriorityQueueX(ssCount);
            for (int i = 0; i < ssCount; i++) {
                queue.insert(sameSessionAppointments[i]);
            }

            Appointment[] reassigned = new Appointment[ssCount];
            int index = 0;
            while (!queue.isEmpty() && index < slotCount) {
                Appointment a = queue.remove();
                a.setTimeSlot(availableSlots[index]);
                a.setQueueNumber(index + 1);
                reassigned[index] = a;
                index++;
            }

            // Remove all old same-session from updatedAppointments
            Appointment[] finalAppointments = new Appointment[200];
            int finalCount = 0;
            for (int i = 0; i < total; i++) {
                Appointment a = updatedAppointments[i];
                if (!(a.getDoctorName().equals(doctorName) && a.getDate().equals(date))) {
                    finalAppointments[finalCount++] = a;
                }
            }

            for (int i = 0; i < index; i++) {
                finalAppointments[finalCount++] = reassigned[i];
            }

            AppointmentUtil.saveAppointmentsArray(filePath, finalAppointments, finalCount);
        }

        if ("main".equals(role) || "standard".equals(role)) {
            response.sendRedirect("payment.jsp");
        } else {
            response.sendRedirect("MyAppointmentsServlet");
        }
    }
}
