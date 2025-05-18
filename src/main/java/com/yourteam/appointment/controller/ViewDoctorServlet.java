package com.yourteam.appointment.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.*;

@WebServlet("/ViewDoctorServlet")
public class ViewDoctorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nameQuery = request.getParameter("doctorName");
        String specializationQuery = request.getParameter("specialization");

        List<String[]> matchedDoctors = new ArrayList<>();
        Map<String, List<String[]>> doctorAppointmentsMap = new HashMap<>();

        if (nameQuery != null && !nameQuery.trim().isEmpty()) {
            String doctorFilePath = getServletContext().getRealPath("/data/doctor_sessions.txt");
            String appointmentFilePath = getServletContext().getRealPath("/data/appointments.txt");

            // Step 1: Load doctor sessions
            try (BufferedReader docReader = new BufferedReader(new FileReader(doctorFilePath))) {
                String line;
                while ((line = docReader.readLine()) != null) {
                    String[] parts = line.split("\\|"); // ID|Name|Specialization|Gender|Date|Time|Fee
                    if (parts.length >= 7 && parts[1].toLowerCase().contains(nameQuery.toLowerCase())) {
                        if (specializationQuery == null || specializationQuery.isEmpty()
                                || parts[2].equalsIgnoreCase(specializationQuery)) {
                            matchedDoctors.add(parts);
                            String key = parts[1].trim() + "|" + parts[4].trim(); // Name + Date
                            doctorAppointmentsMap.put(key, new ArrayList<>());
                        }
                    }
                }
            }

            // Step 2: Match appointments based on name + date
            try (BufferedReader apptReader = new BufferedReader(new FileReader(appointmentFilePath))) {
                String line;
                while ((line = apptReader.readLine()) != null) {
                    String[] parts = line.split(",", -1); // username,nic,doctorName,specialization,date,urgency,timeSlot,queue,fee,paid
                    if (parts.length == 10) {
                        String key = parts[2].trim() + "|" + parts[4].trim(); // doctorName + date
                        if (doctorAppointmentsMap.containsKey(key)) {
                            doctorAppointmentsMap.get(key).add(parts);
                        }
                    }
                }
            }
        }

        request.setAttribute("matchedDoctors", matchedDoctors);
        request.setAttribute("doctorAppointmentsMap", doctorAppointmentsMap);
        request.setAttribute("nameQuery", nameQuery);
        request.setAttribute("specializationQuery", specializationQuery);

        request.getRequestDispatcher("viewdoc.jsp").forward(request, response);
    }
}