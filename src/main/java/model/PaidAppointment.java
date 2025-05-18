package com.yourteam.appointment.model;

public class PaidAppointment extends Appointment {

    public PaidAppointment(String username, String nic, String doctorName, String specialization,
                           String date, String urgency, String timeSlot,
                           int queueNumber, double fee) {
        super(username, nic, doctorName, specialization, date, urgency, timeSlot, queueNumber, fee, true);
    }

    // Returns the paid amount
    public double getAmountPaid() {
        return getFee();
    }

    // Prints a receipt (could be redirected to file or HTML output in future)
    public void printReceipt() {
        System.out.println("Receipt:");
        System.out.println("Patient: " + getUsername());
        System.out.println("Doctor: " + getDoctorName());
        System.out.println("Date: " + getDate());
        System.out.println("Time: " + getTimeSlot());
        System.out.println("Amount Paid: Rs. " + getFee());
    }
}

