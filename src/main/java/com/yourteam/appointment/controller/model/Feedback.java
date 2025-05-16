package com.yourteam.appointment.model;

public abstract class Feedback {
    protected String username;
    protected String message;
    protected String rating;

    public Feedback(String username, String message, String rating) {
        this.username = username;
        this.message = message;
        this.rating = rating;
    }

    public String getUsername() { return username; }
    public String getMessage() { return message; }
    public String getRating() { return rating; }

    public abstract String getFeedbackType();
    public abstract String toFileString(); // ✅ required for FeedbackUtil
}
