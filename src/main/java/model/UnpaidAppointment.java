package com.yourteam.appointment.model;

public class UnpaidAppointment extends Appointment {
    public UnpaidAppointment(String username, String nic, String doctorName, String specialization,
                             String date, String urgency, String timeSlot,
                             int queueNumber, double fee) {
        super(username, nic, doctorName, specialization, date, urgency, timeSlot, queueNumber, fee, false);
    }
}
