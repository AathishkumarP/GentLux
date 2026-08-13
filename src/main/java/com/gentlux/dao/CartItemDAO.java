package com.gentlux.dao;

import com.gentlux.model.CartItem;
import java.util.List;

public interface CartItemDAO {

    boolean addCartItem(CartItem cartItem);

    CartItem getCartItemById(int cartItemId);

    CartItem getCartItemByCartAndVariant(int cartId, int variantId);

    List<CartItem> getCartItemsByCartId(int cartId);

    boolean updateQuantity(int cartItemId, int quantity);

    boolean removeCartItem(int cartItemId);

    boolean removeCartItemByCartAndVariant(int cartId, int variantId);

    boolean clearCart(int cartId);

    boolean isVariantInCart(int cartId, int variantId);

    int getCartItemCount(int cartId);

    int getCartItemQuantity(int cartId, int variantId);
}