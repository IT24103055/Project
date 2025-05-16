package com.yourteam.appointment.model;

public class User {
    private String Name;
    private String Password;
    private String Email;
    private String PhoneNumber;
    private String Nic;
    private String gender;
    private int age;

    public User() {
    }

    public User(String name, String email, String password, String nic, String gender) {

    }

    public User(String Name, int age, String gender, String Nic, String phoneNumber, String email, String password) {
        Name = Name;
        this.age = age;
        this.gender = gender;
        this.Nic = Nic;
        PhoneNumber = phoneNumber;
        Email = email;
        Password = password;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        PhoneNumber = phoneNumber;
    }

    public String getNic() {
        return Nic;
    }

    public void setNic(String Nic) {
        this.Nic = this.Nic;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

}
