package com.yourteam.appointment.utils;

import com.yourteam.appointment.model.Admin;

import jakarta.servlet.http.HttpServletRequest;

import java.io.*;
        import java.util.ArrayList;
import java.util.List;

public class AdminUtil {

    // Get all admins from the file
    public static List<Admin> getAllAdmins(String filePath) {
        List<Admin> admins = new ArrayList<>();

        File file = new File(filePath);
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
                return admins;
            }
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 6) {
                    admins.add(new Admin(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return admins;
    }

    // Authenticate admin using NIC and password
    public static Admin authenticate(String nic, String password, String filePath) {
        for (Admin a : getAllAdmins(filePath)) {
            if (a.getNic().equals(nic) && a.getPassword().equals(password)) {
                return a;
            }
        }
        return null;
    }

    // Delete admin from file based on NIC and role
    public static boolean deleteAdmin(String nicToDelete, String currentNic, String currentRole, String filePath, HttpServletRequest request) {
        File file = new File(filePath);
        List<String> updatedLines = new ArrayList<>();
        boolean found = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 6 && parts[3].equals(nicToDelete)) {
                    if ("main".equals(currentRole) || nicToDelete.equals(currentNic)) {
                        found = true;
                        continue; // skip the line to delete
                    } else {
                        request.setAttribute("errorMessage", "Standard admins can only delete their own account.");
                        return false;
                    }
                }
                updatedLines.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (found) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                for (String line : updatedLines) {
                    writer.write(line);
                    writer.newLine();
                }
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }

        return found;
    }
}
