package com.yourteam.appointment.model;

import java.io.Serializable;

public class Appointment implements Serializable {
    private String username;
    private String nic;
    private String doctorName;
    private String specialization;
    private String date;
    private String urgency;
    private String timeSlot;
    private int queueNumber;
    private double fee;
    private boolean paid;

    // Constructor
    public Appointment(String username, String nic, String doctorName, String specialization,
                       String date, String urgency, String timeSlot, int queueNumber,
                       double fee, boolean paid) {
        this.username = username;
        this.nic = nic;
        this.doctorName = doctorName;
        this.specialization = specialization;
        this.date = date;
        this.urgency = urgency;
        this.timeSlot = timeSlot;
        this.queueNumber = queueNumber;
        this.fee = fee;
        this.paid = paid;
    }

    // Getters and setters
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getUrgency() { return urgency; }
    public void setUrgency(String urgency) { this.urgency = urgency; }

    public String getTimeSlot() { return timeSlot; }
    public void setTimeSlot(String timeSlot) { this.timeSlot = timeSlot; }

    public int getQueueNumber() { return queueNumber; }
    public void setQueueNumber(int queueNumber) { this.queueNumber = queueNumber; }

    public double getFee() { return fee; }
    public void setFee(double fee) { this.fee = fee; }

    public boolean isPaid() { return paid; }
    public void setPaid(boolean paid) { this.paid = paid; }

    // Summary
    public String getSummary() {
        return String.format("Doctor: %s (%s) | Date: %s | Time: %s | Urgency: %s | Fee: %.2f | Paid: %s",
                doctorName, specialization, date, timeSlot, urgency, fee, paid ? "Yes" : "No");
    }

    // Convert to file string
    public String toFileString() {
        return username + "," + nic + "," + doctorName + "," + specialization + "," + date + "," + urgency + "," +
                timeSlot + "," + queueNumber + "," + fee + "," + paid;
    }

    // Read from file
    public static Appointment fromFileString(String line) {
        String[] parts = line.split(",");
        if (parts.length != 10) return null;

        boolean isPaid = Boolean.parseBoolean(parts[9]);
        if (isPaid) {
            return new PaidAppointment(parts[0], parts[1], parts[2], parts[3], parts[4],
                    parts[5], parts[6], Integer.parseInt(parts[7]), Double.parseDouble(parts[8]));
        } else {
            return new UnpaidAppointment(parts[0], parts[1], parts[2], parts[3], parts[4],
                    parts[5], parts[6], Integer.parseInt(parts[7]), Double.parseDouble(parts[8]));
        }
    }
}
