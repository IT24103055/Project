package com.yourteam.appointment.utils;

import com.yourteam.appointment.model.Appointment;

import java.io.*;
import java.util.logging.*;

public class AppointmentUtil {
    private static final Logger logger = Logger.getLogger(AppointmentUtil.class.getName());


    public static java.util.List<Appointment> getAllAppointments(String filePath) {
        java.util.List<Appointment> appointments = new java.util.ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Appointment appointment = Appointment.fromFileString(line);
                if (appointment != null) {
                    appointments.add(appointment);
                }
            }
        } catch (IOException e) {
            logger.severe("Error reading appointments: " + e.getMessage());
        }
        return appointments;
    }

    public static void saveAppointments(String filePath, java.util.List<Appointment> appointments) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Appointment appointment : appointments) {
                writer.write(appointment.toFileString());
                writer.newLine();
            }
        } catch (IOException e) {
            logger.severe("Error saving appointments: " + e.getMessage());
        }
    }



    public static Appointment[] getAllAppointmentsArray(String filePath) {
        Appointment[] appointments = new Appointment[200]; // fixed size
        int index = 0;
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null && index < appointments.length) {
                Appointment appointment = Appointment.fromFileString(line);
                if (appointment != null) {
                    appointments[index++] = appointment;
                }
            }
        } catch (IOException e) {
            logger.severe("Error reading appointments as array: " + e.getMessage());
        }
        return appointments;
    }

    public static void saveAppointmentsArray(String filePath, Appointment[] appointments, int length) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (int i = 0; i < length; i++) {
                if (appointments[i] != null) {
                    writer.write(appointments[i].toFileString());
                    writer.newLine();
                }
            }
        } catch (IOException e) {
            logger.severe("Error saving appointments array: " + e.getMessage());
        }
    }
}
