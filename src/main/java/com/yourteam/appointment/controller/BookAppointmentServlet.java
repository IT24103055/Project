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

        Appointment[] allAppointments = AppointmentUtil.getAllAppointmentsArray(appointmentPath);

        // Step 1: collect booking order
        Appointment[] bookingOrder = new Appointment[100];
        int bookingCount = 0;
        for (Appointment a : allAppointments) {
            if (a != null && a.getDoctorName().equals(doctorName) && a.getDate().equals(date)) {
                bookingOrder[bookingCount++] = a;
            }
        }

        Appointment newAppt = new UnpaidAppointment(username, nic, doctorName, specialization, date, urgency, "", 0, fee);
        bookingOrder[bookingCount++] = newAppt;

        // Step 2: assign time slots based on urgency
        PriorityQueueX queue = new PriorityQueueX(bookingCount);
        for (int i = 0; i < bookingCount; i++) {
            queue.insert(bookingOrder[i]);
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

        String[] timeSlots = new String[100];
        int slotCount = 0;
        LocalTime temp = startTime;
        while (!temp.isAfter(endTime.minusMinutes(15))) {
            timeSlots[slotCount++] = temp.toString();
            temp = temp.plusMinutes(15);
        }

        Appointment[] scheduled = new Appointment[bookingCount];
        int t = 0;
        while (!queue.isEmpty() && t < slotCount) {
            Appointment a = queue.remove();
            a.setTimeSlot(timeSlots[t]);
            a.setQueueNumber(t + 1);
            scheduled[t] = a;
            t++;
        }

        Appointment[] finalList = new Appointment[200];
        int f = 0;
        for (Appointment a : allAppointments) {
            if (a != null && !(a.getDoctorName().equals(doctorName) && a.getDate().equals(date))) {
                finalList[f++] = a;
            }
        }

        Appointment[] added = new Appointment[bookingCount];
        int addedCount = 0;

        for (int i = 0; i < bookingCount; i++) {
            Appointment booked = bookingOrder[i];
            for (int j = 0; j < scheduled.length; j++) {
                Appointment assigned = scheduled[j];
                if (assigned != null &&
                        assigned.getUsername().equals(booked.getUsername()) &&
                        assigned.getNic().equals(booked.getNic()) &&
                        assigned.getDoctorName().equals(booked.getDoctorName()) &&
                        assigned.getDate().equals(booked.getDate()) &&
                        assigned.getUrgency().equals(booked.getUrgency()) &&
                        !alreadyAdded(added, assigned, addedCount)) {

                    finalList[f++] = assigned;
                    added[addedCount++] = assigned;
                    break;
                }
            }
        }

        SortUtil.bubbleSort(finalList, f);
        AppointmentUtil.saveAppointmentsArray(appointmentPath, finalList, f);
        response.sendRedirect("MyAppointmentsServlet");
    }

    private boolean alreadyAdded(Appointment[] added, Appointment appt, int count) {
        for (int i = 0; i < count; i++) {
            if (added[i] != null &&
                    added[i].getUsername().equals(appt.getUsername()) &&
                    added[i].getNic().equals(appt.getNic()) &&
                    added[i].getDoctorName().equals(appt.getDoctorName()) &&
                    added[i].getDate().equals(appt.getDate()) &&
                    added[i].getUrgency().equals(appt.getUrgency()) &&
                    added[i].getSpecialization().equals(appt.getSpecialization()) &&
                    added[i].getTimeSlot().equals(appt.getTimeSlot())) {
                return true;
            }
        }
        return false;
    }

}




