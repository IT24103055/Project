package com.yourteam.appointment.model;

public class DoctorFeedback extends Feedback {
    private String doctorName;

    public DoctorFeedback(String username, String doctorName, String message, String rating) {
        super(username, message, rating);
        this.doctorName = doctorName;
    }

    @Override
    public String getFeedbackType() {
        return "Doctor: " + doctorName;
    }

    @Override
    public String toFileString() {
        return "doctor|" + username + "|" + doctorName + "|" + message.replace("|", " ") + "|" + rating;
    }

    public String getDoctorName() {
        return doctorName;
    }
}
