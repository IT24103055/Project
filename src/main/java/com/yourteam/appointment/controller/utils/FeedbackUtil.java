package com.yourteam.appointment.utils;

import com.yourteam.appointment.model.*;

import java.io.*;
import java.util.*;

public class FeedbackUtil {

    // Read all feedback from the file and return as list of Feedback objects
    public static List<Feedback> getAllFeedback(String filePath) {
        List<Feedback> feedbackList = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");

                // Format: type|username|doctorName|message|rating (doctor)
                // or     type|username|message|rating       (system)
                if (parts.length == 5 && "doctor".equalsIgnoreCase(parts[0])) {
                    feedbackList.add(new DoctorFeedback(parts[1], parts[2], parts[3], parts[4]));
                } else if (parts.length == 4 && "system".equalsIgnoreCase(parts[0])) {
                    feedbackList.add(new SystemFeedback(parts[1], parts[2], parts[3]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return feedbackList;
    }

    // Save a single feedback entry to the file
    public static void saveFeedback(Feedback feedback, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(feedback.toFileString());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Update feedback (match original and replace with updated)
    public static boolean updateFeedback(String filePath, Feedback original, Feedback updated) {
        File inputFile = new File(filePath);
        File tempFile = new File(filePath + ".tmp");
        boolean updatedFlag = false;

        try (
                BufferedReader reader = new BufferedReader(new FileReader(inputFile));
                BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))
        ) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.equals(original.toFileString())) {
                    writer.write(updated.toFileString());
                    updatedFlag = true;
                } else {
                    writer.write(line);
                }
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Replace file
        if (inputFile.delete() && tempFile.renameTo(inputFile)) {
            return updatedFlag;
        }
        return false;
    }

    // Delete feedback
    public static boolean deleteFeedback(String filePath, Feedback toDelete) {
        File inputFile = new File(filePath);
        File tempFile = new File(filePath + ".tmp");
        boolean deletedFlag = false;

        try (
                BufferedReader reader = new BufferedReader(new FileReader(inputFile));
                BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))
        ) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.equals(toDelete.toFileString())) {
                    deletedFlag = true;
                    continue; // skip this line
                }
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (inputFile.delete() && tempFile.renameTo(inputFile)) {
            return deletedFlag;
        }
        return false;
    }
}
