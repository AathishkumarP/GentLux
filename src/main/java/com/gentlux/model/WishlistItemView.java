package com.gentlux.model;

import java.sql.Timestamp;

public class WishlistItemView {

    private int wishlistId;

    private int userId;

    private int productId;

    private String productName;

    private String brand;

    private double price;

    private double mrp;

    private double discount;

    private String imageUrl;

    private Timestamp createdAt;


    public WishlistItemView() {

    }


    public int getWishlistId() {

        return wishlistId;
    }


    public void setWishlistId(int wishlistId) {

        this.wishlistId = wishlistId;
    }


    public int getUserId() {

        return userId;
    }


    public void setUserId(int userId) {

        this.userId = userId;
    }


    public int getProductId() {

        return productId;
    }


    public void setProductId(int productId) {

        this.productId = productId;
    }


    public String getProductName() {

        return productName;
    }


    public void setProductName(String productName) {

        this.productName = productName;
    }


    public String getBrand() {

        return brand;
    }


    public void setBrand(String brand) {

        this.brand = brand;
    }


    public double getPrice() {

        return price;
    }


    public void setPrice(double price) {

        this.price = price;
    }


    public double getMrp() {

        return mrp;
    }


    public void setMrp(double mrp) {

        this.mrp = mrp;
    }


    public double getDiscount() {

        return discount;
    }


    public void setDiscount(double discount) {

        this.discount = discount;
    }


    public String getImageUrl() {

        return imageUrl;
    }


    public void setImageUrl(String imageUrl) {

        this.imageUrl = imageUrl;
    }


    public Timestamp getCreatedAt() {

        return createdAt;
    }


    public void setCreatedAt(Timestamp createdAt) {

        this.createdAt = createdAt;
    }
}