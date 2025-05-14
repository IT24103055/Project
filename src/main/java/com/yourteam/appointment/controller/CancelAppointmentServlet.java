package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Appointment;
import com.yourteam.appointment.utils.AppointmentUtil;

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

        String doctorName = request.getParameter("doctorName");
        String date = request.getParameter("date");
        String timeSlot = request.getParameter("timeSlot");
        String nic = (String) request.getSession().getAttribute("nic");

        String filePath = getAppointmentFilePath(request);
        List<Appointment> allAppointments = AppointmentUtil.getAllAppointments(filePath);

        // Remove the canceled appointment
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

        // If no cancelable appointment was found
        if (canceled == null) {
            response.sendRedirect("MyAppointmentsServlet");
            return;
        }

        // Get remaining appointments for same doctor and date
        List<Appointment> sameSessionAppointments = new ArrayList<>();
        for (Appointment a : allAppointments) {
            if (a.getDoctorName().equals(doctorName) && a.getDate().equals(date)) {
                sameSessionAppointments.add(a);
            }
        }

        // Read session times
        String sessionFile = getSessionFilePath(request);
        BufferedReader sessionReader = new BufferedReader(new FileReader(sessionFile));
        String line;
        LocalTime startTime = null, endTime = null;
        while ((line = sessionReader.readLine()) != null) {
            String[] parts = line.split("\\|");
            if (parts.length >= 6 && parts[1].equalsIgnoreCase(doctorName) && parts[4].equals(date)) {
                String[] timeRange = parts[5].split("-");
                startTime = LocalTime.parse(timeRange[0].trim());
                endTime = LocalTime.parse(timeRange[1].trim());
                break;
            }
        }
        sessionReader.close();

        // Generate available time slots
        List<String> availableSlots = new ArrayList<>();
        LocalTime temp = startTime;
        while (!temp.isAfter(endTime.minusMinutes(15))) {
            availableSlots.add(temp.toString());
            temp = temp.plusMinutes(15);
        }

        // Reschedule using urgency-based priority
        PriorityQueue<Appointment> queue = new PriorityQueue<>(Comparator.comparingInt(a -> {
            switch (a.getUrgency().toLowerCase()) {
                case "high": return 1;
                case "medium": return 2;
                case "low": return 3;
                default: return 4;
            }
        }));
        queue.addAll(sameSessionAppointments);

        List<Appointment> updated = new ArrayList<>();
        int i = 0;
        while (!queue.isEmpty() && i < availableSlots.size()) {
            Appointment a = queue.poll();
            a.setTimeSlot(availableSlots.get(i));
            a.setQueueNumber(i + 1);
            updated.add(a);
            i++;
        }

        // Replace old session data
        allAppointments.removeIf(a -> a.getDoctorName().equals(doctorName) && a.getDate().equals(date));
        allAppointments.addAll(updated);

        // Save updated list
        AppointmentUtil.saveAppointments(filePath, allAppointments);

        response.sendRedirect("MyAppointmentsServlet");
    }
}
