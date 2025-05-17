package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Appointment;
import com.yourteam.appointment.utils.AppointmentUtil;
import com.yourteam.appointment.structures.PriorityQueueX;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.time.LocalTime;
import java.util.*;

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
        List<Appointment> allAppointments = AppointmentUtil.getAllAppointments(filePath);

        Appointment canceled = null;
        Iterator<Appointment> iterator = allAppointments.iterator();
        while (iterator.hasNext()) {
            Appointment appt = iterator.next();
            if (appt.getDoctorName().equals(doctorName)
                    && appt.getDate().equals(date)
                    && appt.getTimeSlot().equals(timeSlot)
                    && appt.getNic().equals(nic)
                    && !appt.isPaid()) {
                canceled = appt;
                iterator.remove();
                break;
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

        List<Appointment> sameSessionAppointments = new ArrayList<>();
        for (Appointment a : allAppointments) {
            if (a.getDoctorName().equals(doctorName) && a.getDate().equals(date)) {
                sameSessionAppointments.add(a);
            }
        }

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
            List<String> availableSlots = new ArrayList<>();
            LocalTime temp = startTime;
            while (!temp.isAfter(endTime.minusMinutes(15))) {
                availableSlots.add(temp.toString());
                temp = temp.plusMinutes(15);
            }

            // Use custom PriorityQueueX
            PriorityQueueX queue = new PriorityQueueX(100);
            for (Appointment a : sameSessionAppointments) {
                queue.insert(a);
            }

            List<Appointment> updated = new ArrayList<>();
            int i = 0;
            while (!queue.isEmpty() && i < availableSlots.size()) {
                Appointment a = queue.remove();
                a.setTimeSlot(availableSlots.get(i));
                a.setQueueNumber(i + 1);
                updated.add(a);
                i++;
            }

            // Replace old same-session appointments with updated ones
            allAppointments.removeIf(a -> a.getDoctorName().equals(doctorName) && a.getDate().equals(date));
            allAppointments.addAll(updated);
        }

        AppointmentUtil.saveAppointments(filePath, allAppointments);

        if ("main".equals(role) || "standard".equals(role)) {
            response.sendRedirect("payment.jsp");
        } else {
            response.sendRedirect("MyAppointmentsServlet");
        }
    }
}
