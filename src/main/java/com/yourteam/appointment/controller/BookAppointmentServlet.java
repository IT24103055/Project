package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Appointment;
import com.yourteam.appointment.model.UnpaidAppointment;
import com.yourteam.appointment.utils.AppointmentUtil;
import com.yourteam.appointment.structures.PriorityQueueX;
import com.yourteam.appointment.structures.SortUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.time.LocalTime;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {

    private static final String SESSION_FILE = "/data/doctor_sessions.txt";
    private static final String APPOINTMENT_FILE = "/data/appointments.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

      
        String username = (String) request.getSession().getAttribute("username");
        String nic = (String) request.getSession().getAttribute("nic");

        String doctorID = request.getParameter("doctorID");
        String doctorName = request.getParameter("doctorName");
        String specialization = request.getParameter("specialization");
        String gender = request.getParameter("gender");
        String date = request.getParameter("date");
        String urgency = request.getParameter("urgency");
        double fee = Double.parseDouble(request.getParameter("fee"));

        String sessionPath = getServletContext().getRealPath(SESSION_FILE);
        String appointmentPath = getServletContext().getRealPath(APPOINTMENT_FILE);

        // Load all appointments from file
        Appointment[] allAppointments = AppointmentUtil.getAllAppointmentsArray(appointmentPath);

        // Filter appointments for same doctor & date
        Appointment[] sameSession = new Appointment[100];
        int sessionCount = 0;
        for (Appointment a : allAppointments) {
            if (a != null && a.getDoctorName().equals(doctorName) && a.getDate().equals(date)) {
                sameSession[sessionCount++] = a;
            }
        }

        // Find session time for doctor
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

        // Generate 15-min time slots
        String[] timeSlots = new String[100];
        int slotCount = 0;
        LocalTime temp = startTime;
        while (!temp.isAfter(endTime.minusMinutes(15))) {
            timeSlots[slotCount++] = temp.toString();
            temp = temp.plusMinutes(15);
        }

        // Create new unpaid appointment
        Appointment newAppt = new UnpaidAppointment(username, nic, doctorName, specialization, date, urgency, "", 0, fee);

        // Use custom priority queue to sort by urgency
        PriorityQueueX queue = new PriorityQueueX(100);
        for (int i = 0; i < sessionCount; i++) {
            queue.insert(sameSession[i]);
        }
        queue.insert(newAppt);

        // Assign time slots based on priority
        Appointment[] updatedSession = new Appointment[slotCount];
        int i = 0;
        while (!queue.isEmpty() && i < slotCount) {
            Appointment a = queue.remove();
            a.setTimeSlot(timeSlots[i]);
            a.setQueueNumber(i + 1);
            updatedSession[i] = a;
            i++;
        }

        // Merge appointments (excluding old session ones)
        Appointment[] finalList = new Appointment[200];
        int f = 0;
        for (Appointment a : allAppointments) {
            if (a != null && !(a.getDoctorName().equals(doctorName) && a.getDate().equals(date))) {
                finalList[f++] = a;
            }
        }
        for (int j = 0; j < i; j++) {
            finalList[f++] = updatedSession[j];
        }

        // Sort by timeSlot using bubble sort
        SortUtil.bubbleSort(finalList, f);

        // Save back to file
        AppointmentUtil.saveAppointmentsArray(appointmentPath, finalList, f);

        // Redirect to patient appointment page
        response.sendRedirect("MyAppointmentsServlet");
    }
}
