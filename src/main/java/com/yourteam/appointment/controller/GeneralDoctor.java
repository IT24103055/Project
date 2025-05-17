package com.yourteam.appointment.model;

public class GeneralDoctor extends Doctor {

    public GeneralDoctor(String doctorName, String email, String nic, String doctorId, String gender, String specialization) {
        super(doctorName, email, nic, doctorId, gender, specialization);
    }

    // Custom method for demonstrating specialization
    public String getConsultationType() {
        return "General practitioner in " + getSpecialization();
    }

    @Override
    public String toString() {
        return super.toString(); // Ensures consistent file format
    }
}