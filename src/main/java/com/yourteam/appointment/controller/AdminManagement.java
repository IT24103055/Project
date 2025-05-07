package com.yourteam.appointment.controller;

public class AdminManagement
{
    import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

    // Abstraction: Interface for user actions
    interface UserActions {
        void displayProfile();
        void deleteAccount(Map<String, Admin> adminDatabase);
    }

    // Abstraction: Abstract class for user
    abstract class User {
        protected String userId;
        protected String username;
        protected String password;
        protected String email;

        public User(String userId, String username, String password, String email) {
            this.userId = userId;
            this.username = username;
            this.password = password;
            this.email = email;
        }

        // Encapsulation: Getters for accessing user information (read-only)
        public String getUserId() {
            return userId;
        }

        public String getUsername() {
            return username;
        }

        public String getEmail() {
            return email;
        }

        // Abstract method to be implemented by subclasses
        public abstract void displayProfile();

        // Common method for deleting account
        public void deleteAccount(Map<String, Admin> adminDatabase) {
            Scanner scanner = new Scanner(System.in);
            System.out.print("Enter your username to confirm deletion: ");
            String confirmationUsername = scanner.nextLine();

            if (this.username.equals(confirmationUsername)) {
                adminDatabase.remove(this.userId);
                System.out.println("Account with username '" + this.username + "' has been deleted.");
            } else {
                System.out.println("Username confirmation failed. Account not deleted.");
            }
        }
    }

    // Inheritance: Admin class inheriting from User
    class Admin extends User implements UserActions {
        private String role;

        public Admin(String userId, String username, String password, String email, String role) {
            super(userId, username, password, email);
            this.role = role;
        }

        // Encapsulation: Getter for admin role
        public String getRole() {
            return role;
        }

        // Implementation of abstract method displayProfile for Admin
        @Override
        public void displayProfile() {
            System.out.println("\n--- Admin Profile ---");
            System.out.println("User ID: " + userId);
            System.out.println("Username: " + username);
            System.out.println("Email: " + email);
            System.out.println("Role: " + role);
            System.out.println("---------------------");
        }

        // Implementation of deleteAccount (inherited from User) - no specific admin logic needed here
    }

    // Admin Management Class
    class AdminManagement {
        private Map<String, Admin> adminDatabase;
        private static int nextAdminId = 1; // Simple auto-increment for admin IDs

        public AdminManagement() {
            this.adminDatabase = new HashMap<>();
        }

        // Admin Registration
        public void registerAdmin() {
            Scanner scanner = new Scanner(System.in);

            System.out.println("\n--- Admin Registration ---");
            System.out.print("Enter username: ");
            String username = scanner.nextLine();
            System.out.print("Enter password: ");
            String password = scanner.nextLine();
            System.out.print("Enter email: ");
            String email = scanner.nextLine();
            System.out.print("Enter role: ");
            String role = scanner.nextLine();

            // Basic validation (can be expanded)
            if (adminDatabase.values().stream().anyMatch(admin -> admin.getUsername().equals(username))) {
                System.out.println("Username already exists. Registration failed.");
                return;
            }

            String newAdminId = "ADMIN_" + nextAdminId++;
            Admin newAdmin = new Admin(newAdminId, username, password, email, role);
            adminDatabase.put(newAdminId, newAdmin);
            System.out.println("Admin registered successfully with ID: " + newAdminId);
        }

        // Get Admin by ID (for internal management)
        public Admin getAdminById(String adminId) {
            return adminDatabase.get(adminId);
        }

        // Display Admin Profile
        public void displayAdminProfile(String adminId) {
            Admin admin = getAdminById(adminId);
            if (admin != null) {
                admin.displayProfile();
            } else {
                System.out.println("Admin with ID '" + adminId + "' not found.");
            }
        }

        // Delete Admin Account
        public void deleteAdminAccount(String adminId) {
            Admin adminToDelete = getAdminById(adminId);
            if (adminToDelete != null) {
                adminToDelete.deleteAccount(adminDatabase);
            } else {
                System.out.println("Admin with ID '" + adminId + "' not found.");
            }
        }

        // List all Admins (for management purposes)
        public void listAllAdmins() {
            System.out.println("\n--- List of Admins ---");
            if (adminDatabase.isEmpty()) {
                System.out.println("No admins registered yet.");
            } else {
                for (Admin admin : adminDatabase.values()) {
                    System.out.println("ID: " + admin.getUserId() + ", Username: " + admin.getUsername() + ", Role: " + admin.getRole());
                }
            }
            System.out.println("----------------------");
        }
    }

    public class MedicalWebsiteAdmin {
        public static void main(String[] args) {
            AdminManagement adminManager = new AdminManagement();
            Scanner scanner = new Scanner(System.in);
            String choice;

            do {
                System.out.println("\n--- Admin Management System ---");
                System.out.println("1. Register Admin");
                System.out.println("2. View Admin Profile (Enter Admin ID)");
                System.out.println("3. Delete Admin Account (Enter Admin ID)");
                System.out.println("4. List All Admins");
                System.out.println("5. Exit");
                System.out.print("Enter your choice: ");
                choice = scanner.nextLine();

                switch (choice) {
                    case "1":
                        adminManager.registerAdmin();
                        break;
                    case "2":
                        System.out.print("Enter Admin ID to view profile: ");
                        String viewId = scanner.nextLine();
                        adminManager.displayAdminProfile(viewId);
                        break;
                    case "3":
                        System.out.print("Enter Admin ID to delete account: ");
                        String deleteId = scanner.nextLine();
                        adminManager.deleteAdminAccount(deleteId);
                        break;
                    case "4":
                        adminManager.listAllAdmins();
                        break;
                    case "5":
                        System.out.println("Exiting Admin Management System. Goodbye!");
                        break;
                    default:
                        System.out.println("Invalid choice. Please try again.");
                }
            } while (!choice.equals("5"));

        }
    }
}
