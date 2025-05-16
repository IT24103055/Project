package com.yourteam.appointment.utils;

import com.yourteam.appointment.model.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileHandler {
    // 🔁 CHANGE this path to match your computer's location of users.txt
    private static final String FILE_PATH = "C:\\Users\\learn\\Documents\\newproject\\src\\data\\users.txt";

    // Save a user to the file
    public static boolean saveUser(User user) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            String userData = String.join("|",
                    user.getName(),
                    String.valueOf(user.getAge()),
                    user.getGender(),
                    user.getNic(),
                    user.getPhoneNumber(),
                    user.getEmail(),
                    user.getPassword()
            );
            writer.write(userData);
            writer.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all users from the file
    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();

        try {
            File file = new File(FILE_PATH);
            if (!file.exists()) {
                file.getParentFile().mkdirs(); // Ensure directory exists
                file.createNewFile(); // Create the file if it does not exist
            }

            BufferedReader reader = new BufferedReader(new FileReader(file));
            String line;

            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 7) {
                    User user = new User(parts[0],
                            Integer.parseInt(parts[1]),
                            parts[2],
                            parts[3],
                            parts[4],
                            parts[5],
                            parts[6]);
                    users.add(user);
                }
            }
            reader.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return users;
    }

    // Find a user by Email or NIC
    public static User findUser(String key) {
        for (User user : getAllUsers()) {
            if (user.getEmail().equalsIgnoreCase(key) || user.getNIC().equalsIgnoreCase(key)) {
                return user;
            }
        }
        return null;
    }
}
