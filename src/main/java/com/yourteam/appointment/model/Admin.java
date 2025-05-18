package com.yourteam.appointment.model;

public class Admin extends User {

    private String role; // "main" or "standard"

    public Admin() {}

    public Admin(String name, String email, String password, String nic, String gender, String role) {
        super(name, email, password, nic, gender);
        this.role = role;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return name + "|" + email + "|" + password + "|" + nic + "|" + gender + "|" + role;
    }
}
