package com.yourteam.appointment.utils;

import com.yourteam.appointment.model.Doctor;
import com.yourteam.appointment.model.SurgeonDoctor;
import com.yourteam.appointment.model.GeneralDoctor;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorUtil {

    // Reads all doctors from the given file path
    public static List<Doctor> getAllDoctors(String filePath) {
        List<Doctor> doctorList = new ArrayList<>();

        File file = new File(filePath);
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs(); // create directories if missing
                file.createNewFile();          // create the file if it doesn't exist
            } catch (IOException e) {
                e.printStackTrace();
                return doctorList; // return empty list on error
            }
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 6) {
                    String specialization = parts[5].toLowerCase();

                    // Assign SurgeonDoctor if specialization contains "surgeon"
                    if (specialization.contains("surgeon")) {
                        doctorList.add(new SurgeonDoctor(
                                parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]
                        ));
                    } else {
                        doctorList.add(new GeneralDoctor(
                                parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]
                        ));
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return doctorList;
    }

    // Returns the count of doctor records from the file
    public static int getDoctorCount(String filePath) {
        int count = 0;
        File file = new File(filePath);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                while (reader.readLine() != null) {
                    count++;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return count;
    }
}