package com.yourteam.appointment.model;

public class Doctor {
    private String doctorName;
    private String email;
    private String nic;
    private String doctorId;
    private String gender;
    private String specialization;

    public Doctor() {}

    public Doctor(String doctorName, String email, String nic, String doctorId, String gender, String specialization) {
        this.doctorName = doctorName;
        this.email = email;
        this.nic = nic;
        this.doctorId = doctorId;
        this.gender = gender;
        this.specialization = specialization;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    @Override
    public String toString() {
        return doctorName + "|" + email + "|" + nic + "|" + doctorId + "|" + gender + "|" + specialization;
    }
}