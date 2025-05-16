package com.yourteam.appointment.utils;

import com.yourteam.appointment.model.Appointment;
import com.yourteam.appointment.model.Patient;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentUtil {

    // Search patients by NIC or Name
    public static List<Patient> searchPatientsForPayment(String query, String patientFilePath) {
        List<Patient> matched = new ArrayList<>();
        String lowerQuery = query.toLowerCase();

        try (BufferedReader reader = new BufferedReader(new FileReader(patientFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|"); // name|username|nic|password|gender
                if (parts.length == 5) {
                    String name = parts[0];
                    String email = parts[1];
                    String nic = parts[3];
                    String password = parts[2];
                    String gender = parts[4];

                    if (nic.toLowerCase().contains(lowerQuery) || name.toLowerCase().contains(lowerQuery)) {
                        matched.add(new Patient(name,email,password,nic , gender));
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return matched;
    }

    // Get unpaid appointments for a given NIC
    public static List<Appointment> getUnpaidAppointmentsFor(String nic, String appointmentFilePath) {
        List<Appointment> results = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(appointmentFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1);
                if (parts.length == 10) {
                    String username = parts[0];
                    String nicVal = parts[1];
                    String doctorName = parts[2];
                    String specialization = parts[3];
                    String date = parts[4];
                    String urgency = parts[5];
                    String timeSlot = parts[6];
                    int queue = Integer.parseInt(parts[7]);
                    double fee = Double.parseDouble(parts[8]);
                    boolean paid = Boolean.parseBoolean(parts[9]);

                    if (nicVal.equalsIgnoreCase(nic) && !paid) {
                        results.add(new Appointment(username, nicVal, doctorName, specialization,
                                date, urgency, timeSlot, queue, fee, false));
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return results;
    }

    // Get paid appointments for a given NIC
    public static List<Appointment> getPaidAppointmentsFor(String nic, String appointmentFilePath) {
        List<Appointment> results = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(appointmentFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1);
                if (parts.length == 10) {
                    String username = parts[0];
                    String nicVal = parts[1];
                    String doctorName = parts[2];
                    String specialization = parts[3];
                    String date = parts[4];
                    String urgency = parts[5];
                    String timeSlot = parts[6];
                    int queue = Integer.parseInt(parts[7]);
                    double fee = Double.parseDouble(parts[8]);
                    boolean paid = Boolean.parseBoolean(parts[9]);

                    if (nicVal.equalsIgnoreCase(nic) && paid) {
                        results.add(new Appointment(username, nicVal, doctorName, specialization,
                                date, urgency, timeSlot, queue, fee, true));
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return results;
    }

    // Mark an appointment as paid (match using NIC + Doctor + Date + Slot)
    public static boolean markAppointmentAsPaid(Appointment target, String appointmentFilePath) {
        List<String> updatedLines = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(appointmentFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1);
                if (parts.length == 10) {
                    String username = parts[0];
                    String nic = parts[1];
                    String doctorName = parts[2];
                    String specialization = parts[3];
                    String date = parts[4];
                    String urgency = parts[5];
                    String timeSlot = parts[6];
                    int queue = Integer.parseInt(parts[7]);
                    double fee = Double.parseDouble(parts[8]);
                    boolean paid = Boolean.parseBoolean(parts[9]);

                    if (!paid &&
                            nic.equalsIgnoreCase(target.getNic()) &&
                            doctorName.equals(target.getDoctorName()) &&
                            date.equals(target.getDate()) &&
                            timeSlot.equals(target.getTimeSlot())) {

                        updatedLines.add(String.join(",", username, nic, doctorName, specialization, date,
                                urgency, timeSlot, String.valueOf(queue), String.valueOf(fee), "true"));
                        updated = true;
                    } else {
                        updatedLines.add(line);
                    }
                } else {
                    updatedLines.add(line); // fallback: keep original line
                }
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(appointmentFilePath))) {
                for (String updatedLine : updatedLines) {
                    writer.write(updatedLine);
                    writer.newLine();
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return updated;
    }
}
