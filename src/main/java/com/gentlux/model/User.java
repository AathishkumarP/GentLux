package com.gentlux.model;

import java.sql.Timestamp;

public class User {

    private int userId;

    private String fullName;

    private String email;

    private String phone;

    private String password;

    private String address;

    private String city;

    private String state;

    private String pincode;

    private String role;

    private Timestamp createdAt;


    // =========================================================
    // DEFAULT CONSTRUCTOR
    // =========================================================

    public User() {

    }


    // =========================================================
    // PARAMETERIZED CONSTRUCTOR
    // =========================================================

    public User(
            int userId,
            String fullName,
            String email,
            String phone,
            String password,
            String address,
            String city,
            String state,
            String pincode,
            String role,
            Timestamp createdAt) {

        this.userId = userId;

        this.fullName = fullName;

        this.email = email;

        this.phone = phone;

        this.password = password;

        this.address = address;

        this.city = city;

        this.state = state;

        this.pincode = pincode;

        this.role = role;

        this.createdAt = createdAt;
    }


    // =========================================================
    // USER ID
    // =========================================================

    public int getUserId() {

        return userId;
    }

    public void setUserId(int userId) {

        this.userId = userId;
    }


    // =========================================================
    // FULL NAME
    // =========================================================

    public String getFullName() {

        return fullName;
    }

    public void setFullName(String fullName) {

        this.fullName = fullName;
    }


    // =========================================================
    // EMAIL
    // =========================================================

    public String getEmail() {

        return email;
    }

    public void setEmail(String email) {

        this.email = email;
    }


    // =========================================================
    // PHONE
    // =========================================================

    public String getPhone() {

        return phone;
    }

    public void setPhone(String phone) {

        this.phone = phone;
    }


    // =========================================================
    // PASSWORD
    // =========================================================

    public String getPassword() {

        return password;
    }

    public void setPassword(String password) {

        this.password = password;
    }


    // =========================================================
    // ADDRESS
    // =========================================================

    public String getAddress() {

        return address;
    }

    public void setAddress(String address) {

        this.address = address;
    }


    // =========================================================
    // CITY
    // =========================================================

    public String getCity() {

        return city;
    }

    public void setCity(String city) {

        this.city = city;
    }


    // =========================================================
    // STATE
    // =========================================================

    public String getState() {

        return state;
    }

    public void setState(String state) {

        this.state = state;
    }


    // =========================================================
    // PINCODE
    // =========================================================

    public String getPincode() {

        return pincode;
    }

    public void setPincode(String pincode) {

        this.pincode = pincode;
    }


    // =========================================================
    // ROLE
    // =========================================================

    public String getRole() {

        return role;
    }

    public void setRole(String role) {

        this.role = role;
    }


    // =========================================================
    // CREATED AT
    // =========================================================

    public Timestamp getCreatedAt() {

        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {

        this.createdAt = createdAt;
    }
}