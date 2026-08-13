package com.gentlux.dao;

import com.gentlux.model.Cart;

import java.util.List;

public interface CartDAO {

    // =========================================================
    // CREATE
    // =========================================================

    boolean createCart(Cart cart);


    // =========================================================
    // READ / FETCH
    // =========================================================

    Cart getCartById(int cartId);

    Cart getCartByUserId(int userId);

    List<Cart> getAllCarts();


    // =========================================================
    // UPDATE
    // =========================================================

    boolean updateCart(Cart cart);


    // =========================================================
    // DELETE
    // =========================================================

    boolean deleteCart(int cartId);

    boolean deleteCartByUserId(int userId);


    // =========================================================
    // CHECK
    // =========================================================

    boolean cartExists(int cartId);

    boolean cartExistsForUser(int userId);


    // =========================================================
    // CREATE CART IF NOT EXISTS
    // =========================================================

    Cart getOrCreateCart(int userId);
}