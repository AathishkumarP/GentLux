package com.gentlux.model;

public class CartItem {

    private int cartItemId;
    private int cartId;
    private int variantId;
    private int quantity;

    public CartItem() {
    }

    public CartItem(int cartItemId, int cartId, int variantId, int quantity) {
        this.cartItemId = cartItemId;
        this.cartId = cartId;
        this.variantId = variantId;
        this.quantity = quantity;
    }

    public int getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getVariantId() {
        return variantId;
    }

    public void setVariantId(int variantId) {
        this.variantId = variantId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}