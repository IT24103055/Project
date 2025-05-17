package com.yourteam.appointment.controller;

import com.yourteam.appointment.model.Doctor;
import com.yourteam.appointment.model.SurgeonDoctor;
import com.yourteam.appointment.model.GeneralDoctor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/DoctorServlet")
public class DoctorServlet extends DoctorUtil {

    private String getDoctorFilePath(HttpServletRequest request) {
        return request.getServletContext().getRealPath("/data/doctors.txt");
    }

    @Override
    protected void doPost(HttpServletRequest request, com.yourteam.appointment.controller.GeneralDoctor response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String doctorName = request.getParameter("doctorName");
        String email = request.getParameter("email");
        String nic = request.getParameter("nic");
        String doctorId = request.getParameter("doctorId");
        String gender = request.getParameter("gender");
        String specialization = request.getParameter("specialization");

        String filePath = getDoctorFilePath(request);

        if ("add".equals(action)) {
            Doctor doctor;
            if (specialization.toLowerCase().contains("surgeon")) {
                doctor = new SurgeonDoctor(doctorName, email, nic, doctorId, gender, specialization);
            } else {
                doctor = new GeneralDoctor(doctorName, email, nic, doctorId, gender, specialization);
            }
            addDoctor(doctor, filePath);
        } else if ("update".equals(action)) {
            updateDoctor(request, doctorId, filePath);
        } else if ("delete".equals(action)) {
            deleteDoctor(doctorId, filePath);
        }

        List<Doctor> doctors = getDoctors(filePath);
        request.setAttribute("doctors", doctors);
        request.getRequestDispatcher("doctorRegistration.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, com.yourteam.appointment.controller.GeneralDoctor response)
            throws ServletException, IOException {
        String filePath = getDoctorFilePath(request);
        List<Doctor> doctors = getDoctors(filePath);

        request.setAttribute("doctors", doctors);
        request.setAttribute("doctorList", doctors);

        String action = request.getParameter("action");
        if ("list".equals(action)) {
            request.getRequestDispatcher("doctor_list.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("doctorRegistration.jsp").forward(request, response);
        }
    }

    private void addDoctor(Doctor doctor, String filePath) throws IOException {
        try (PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(filePath, true)))) {
            out.println(doctor.toString());
        }
    }

    private void updateDoctor(HttpServletRequest request, String doctorId, String filePath) throws IOException {
        File inputFile = new File(filePath);
        File tempFile = new File(filePath + ".tmp");

        boolean updated = false;

        String newName = request.getParameter("doctorName");
        String newEmail = request.getParameter("email");
        String newGender = request.getParameter("gender");
        String newSpecialization = request.getParameter("specialization");

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");

                if (parts.length == 6 && parts[3].trim().equalsIgnoreCase(doctorId.trim())) {
                    String existingNic = parts[2];
                    String id = parts[3];

                    Doctor updatedDoctor;
                    if (newSpecialization.toLowerCase().contains("surgeon")) {
                        updatedDoctor = new SurgeonDoctor(newName, newEmail, existingNic, id, newGender, newSpecialization);
                    } else {
                        updatedDoctor = new GeneralDoctor(newName, newEmail, existingNic, id, newGender, newSpecialization);
                    }

                    writer.write(updatedDoctor.toString() + "\n");
                    updated = true;
                } else {
                    writer.write(line + "\n");
                }
            }
        }

        inputFile.delete();
        tempFile.renameTo(inputFile);

        if (!updated) {
            System.out.println("Doctor ID not found for update: " + doctorId);
        }
    }

    private void deleteDoctor(String doctorId, String filePath) throws IOException {
        File inputFile = new File(filePath);
        File tempFile = new File(filePath + ".tmp");

        boolean deleted = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 6 && parts[3].trim().equalsIgnoreCase(doctorId.trim())) {
                    deleted = true;
                    continue;
                }
                writer.write(line + "\n");
            }
        }

        inputFile.delete();
        tempFile.renameTo(inputFile);

        if (!deleted) {
            System.out.println("Doctor ID not found for delete: " + doctorId);
        }
    }

    private List<Doctor> getDoctors(String filePath) throws IOException {
        List<Doctor> doctors = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) file.createNewFile();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 6) {
                    if (parts[5].toLowerCase().contains("surgeon")) {
                        doctors.add(new SurgeonDoctor(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]));
                    } else {
                        doctors.add(new GeneralDoctor(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]));
                    }
                }
            }
        }

        return doctors;
    }
}