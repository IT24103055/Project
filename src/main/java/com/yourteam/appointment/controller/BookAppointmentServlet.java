package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Appointment;
import com.yourteam.appointment.model.UnpaidAppointment;
import com.yourteam.appointment.utils.AppointmentUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.time.LocalTime;
import java.util.*;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {

    private static final String SESSION_FILE = "/data/doctor_sessions.txt";
    private static final String APPOINTMENT_FILE = "/data/appointments.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Patient info from session
        String username = (String) request.getSession().getAttribute("username");
        String nic = (String) request.getSession().getAttribute("nic");

        // Appointment parameters
        String doctorID = request.getParameter("doctorID");
        String doctorName = request.getParameter("doctorName");
        String specialization = request.getParameter("specialization");
        String gender = request.getParameter("gender");
        String date = request.getParameter("date");
        String urgency = request.getParameter("urgency");
        double fee = Double.parseDouble(request.getParameter("fee"));

        String sessionPath = getServletContext().getRealPath(SESSION_FILE);
        String appointmentPath = getServletContext().getRealPath(APPOINTMENT_FILE);

        List<Appointment> allAppointments = AppointmentUtil.getAllAppointments(appointmentPath);
        List<Appointment> sameSessionAppointments = new ArrayList<>();
        for (Appointment appt : allAppointments) {
            if (appt.getDoctorName().equals(doctorName) && appt.getDate().equals(date)) {
                sameSessionAppointments.add(appt);
            }
        }

        BufferedReader sessionReader = new BufferedReader(new FileReader(sessionPath));
        String line;
        LocalTime startTime = null, endTime = null;
        while ((line = sessionReader.readLine()) != null) {
            String[] parts = line.split("\\|");
            if (parts.length >= 7 && parts[1].equalsIgnoreCase(doctorName) && parts[4].equals(date)) {
                String[] timeRange = parts[5].split("-");
                startTime = LocalTime.parse(timeRange[0].trim());
                endTime = LocalTime.parse(timeRange[1].trim());
                break;
            }
        }
        sessionReader.close();

        if (startTime == null || endTime == null) {
            response.sendRedirect("bookappointment.jsp?error=NoSessionFound");
            return;
        }

        // Generate available time slots
        List<String> availableSlots = new ArrayList<>();
        LocalTime temp = startTime;
        while (!temp.isAfter(endTime.minusMinutes(15))) {
            availableSlots.add(temp.toString());
            temp = temp.plusMinutes(15);
        }

        // Create new unpaid appointment (no timeSlot/queueNumber yet)
        Appointment newAppt = new UnpaidAppointment(username, nic, doctorName, specialization,
                date, urgency, "", 0, fee);

        // PriorityQueue sorted by urgency
        PriorityQueue<Appointment> queue = new PriorityQueue<>(Comparator.comparingInt(a -> {
            switch (a.getUrgency().toLowerCase()) {
                case "high": return 1;
                case "medium": return 2;
                case "low": return 3;
                default: return 4;
            }
        }));

        queue.addAll(sameSessionAppointments);
        queue.add(newAppt);

        // Assign time slots based on priority
        List<Appointment> updatedSession = new ArrayList<>();
        int i = 0;
        while (!queue.isEmpty() && i < availableSlots.size()) {
            Appointment a = queue.poll();
            a.setTimeSlot(availableSlots.get(i));
            a.setQueueNumber(i + 1);
            updatedSession.add(a);
            i++;
        }

        // Replace old session's appointments with updated ones
        allAppointments.removeIf(a -> a.getDoctorName().equals(doctorName) && a.getDate().equals(date));
        allAppointments.addAll(updatedSession);

        // Optional: Sort all appointments by time (bubble sort)
        for (int x = 0; x < allAppointments.size() - 1; x++) {
            for (int y = 0; y < allAppointments.size() - x - 1; y++) {
                if (allAppointments.get(y).getTimeSlot().compareTo(allAppointments.get(y + 1).getTimeSlot()) > 0) {
                    Collections.swap(allAppointments, y, y + 1);
                }
            }
        }

        AppointmentUtil.saveAppointments(appointmentPath, allAppointments);
        response.sendRedirect("MyAppointmentsServlet");
    }
}
