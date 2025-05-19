package com.yourteam.appointment.model;

public class User {
    protected String name;
    protected String email;
    protected String password;
    protected String nic;
    protected String gender;

    public User() {}

    public User(String name, String email, String password, String nic, String gender) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.nic = nic;
        this.gender = gender;
    }

    // Getters and setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
}
