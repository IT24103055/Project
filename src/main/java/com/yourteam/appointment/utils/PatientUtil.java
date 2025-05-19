package com.yourteam.appointment.utils;

import com.yourteam.appointment.model.Patient;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class PatientUtil {

    // Get all patients from the text file
    public static List<Patient> getAllPatients(String filePath) {
        List<Patient> patients = new ArrayList<>();

        File file = new File(filePath);
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
                return patients;
            }
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 5) {
                    patients.add(new Patient(parts[0], parts[1], parts[2], parts[3], parts[4]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return patients;
    }

    // Check if a patient with the given NIC already exists
    public static boolean isDuplicate(String nic, String filePath) {
        for (Patient p : getAllPatients(filePath)) {
            if (p.getNic().equalsIgnoreCase(nic)) {
                return true;
            }
        }
        return false;
    }

    // Authenticate patient based on NIC and password
    public static Patient authenticate(String nic, String password, String filePath) {
        for (Patient p : getAllPatients(filePath)) {
            if (p.getNic().equals(nic) && p.getPassword().equals(password)) {
                return p;
            }
        }
        return null;
    }
}


