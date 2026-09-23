package com.gentlux.dao;

import java.util.List;

import com.gentlux.model.Wishlist;
import com.gentlux.model.WishlistItemView;

public interface WishlistDAO {

    boolean addToWishlist(Wishlist wishlist);

    boolean removeFromWishlist(int userId, int productId);

    boolean removeByWishlistId(int wishlistId);

    boolean isProductInWishlist(int userId, int productId);

    Wishlist getWishlistItem(int userId, int productId);

    List<Wishlist> getWishlistByUserId(int userId);

    List<WishlistItemView> getWishlistItemViewsByUserId(int userId);

    int getWishlistCount(int userId);

    boolean clearWishlist(int userId);
}