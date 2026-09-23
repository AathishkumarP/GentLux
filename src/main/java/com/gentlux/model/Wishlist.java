package com.gentlux.model;

import java.sql.Timestamp;

public class Wishlist {

    private int wishlistId;

    private int userId;

    private int productId;

    private Timestamp createdAt;


    public Wishlist() {

    }


    public Wishlist(
            int wishlistId,
            int userId,
            int productId,
            Timestamp createdAt) {

        this.wishlistId = wishlistId;
        this.userId = userId;
        this.productId = productId;
        this.createdAt = createdAt;
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


    public Timestamp getCreatedAt() {

        return createdAt;
    }


    public void setCreatedAt(Timestamp createdAt) {

        this.createdAt = createdAt;
    }
}