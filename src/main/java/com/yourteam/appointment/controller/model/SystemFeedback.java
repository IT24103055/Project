package com.yourteam.appointment.model;

public class SystemFeedback extends Feedback {

    public SystemFeedback(String username, String message, String rating) {
        super(username, message, rating);
    }

    @Override
    public String getFeedbackType() {
        return "System Feedback";
    }

    @Override
    public String toFileString() {
        return "system|" + username + "|" + message.replace("|", " ") + "|" + rating;
    }
}
