package com.yourteam.appointment.model;

public class Patient extends User {

    public Patient() {
    }

    public Patient(String name, String email, String password, String nic, String gender) {
        super(name, email, password, nic, gender);
    }

    @Override
    public String toString() {
        return name + "|" + email + "|" + password + "|" + nic + "|" + gender;
    }
}
