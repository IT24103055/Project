package com.yourteam.appointment.model;

public class SurgeonDoctor extends Doctor {

    public SurgeonDoctor(String doctorName, String email, String nic, String doctorId, String gender, String specialization) {
        super(doctorName, email, nic, doctorId, gender, specialization);
    }

    // Custom method for demonstrating specialization
    public String getSurgeryDetails() {
        return "Surgeon specialization: " + getSpecialization() + " - ready for surgical procedures.";
    }

    @Override
    public String toString() {
        return super.toString(); // Ensures consistent file format
    }
}
