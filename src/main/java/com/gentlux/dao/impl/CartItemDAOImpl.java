package com.gentlux.dao.impl;

import com.gentlux.dao.CartItemDAO;
import com.gentlux.model.CartItem;
import com.gentlux.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartItemDAOImpl implements CartItemDAO {

    // =========================================================
    // ADD CART ITEM
    // =========================================================

    @Override
    public boolean addCartItem(CartItem cartItem) {

        String sql = "INSERT INTO cart_item "
                   + "(cart_id, variant_id, quantity) "
                   + "VALUES (?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartItem.getCartId());
            statement.setInt(2, cartItem.getVariantId());
            statement.setInt(3, cartItem.getQuantity());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET CART ITEM BY ID
    // =========================================================

    @Override
    public CartItem getCartItemById(int cartItemId) {

        String sql = "SELECT * FROM cart_item "
                   + "WHERE cart_item_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartItemId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapCartItem(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET CART ITEM BY CART ID AND VARIANT ID
    // =========================================================

    @Override
    public CartItem getCartItemByCartAndVariant(int cartId, int variantId) {

        String sql = "SELECT * FROM cart_item "
                   + "WHERE cart_id = ? AND variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);
            statement.setInt(2, variantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapCartItem(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET ALL CART ITEMS BY CART ID
    // =========================================================

    @Override
    public List<CartItem> getCartItemsByCartId(int cartId) {

        List<CartItem> cartItems = new ArrayList<>();

        String sql = "SELECT * FROM cart_item "
                   + "WHERE cart_id = ? "
                   + "ORDER BY cart_item_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    cartItems.add(mapCartItem(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartItems;
    }


    // =========================================================
    // UPDATE QUANTITY
    // =========================================================

    @Override
    public boolean updateQuantity(int cartItemId, int quantity) {

        String sql = "UPDATE cart_item "
                   + "SET quantity = ? "
                   + "WHERE cart_item_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, quantity);
            statement.setInt(2, cartItemId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // REMOVE CART ITEM BY ID
    // =========================================================

    @Override
    public boolean removeCartItem(int cartItemId) {

        String sql = "DELETE FROM cart_item "
                   + "WHERE cart_item_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartItemId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // REMOVE CART ITEM BY CART ID AND VARIANT ID
    // =========================================================

    @Override
    public boolean removeCartItemByCartAndVariant(int cartId, int variantId) {

        String sql = "DELETE FROM cart_item "
                   + "WHERE cart_id = ? AND variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);
            statement.setInt(2, variantId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CLEAR CART
    // =========================================================

    @Override
    public boolean clearCart(int cartId) {

        String sql = "DELETE FROM cart_item "
                   + "WHERE cart_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CHECK VARIANT IN CART
    // =========================================================

    @Override
    public boolean isVariantInCart(int cartId, int variantId) {

        String sql = "SELECT 1 FROM cart_item "
                   + "WHERE cart_id = ? AND variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);
            statement.setInt(2, variantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                return resultSet.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET CART ITEM COUNT
    // =========================================================

    @Override
    public int getCartItemCount(int cartId) {

        String sql = "SELECT COUNT(*) "
                   + "FROM cart_item "
                   + "WHERE cart_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // GET QUANTITY OF PARTICULAR VARIANT
    // =========================================================

    @Override
    public int getCartItemQuantity(int cartId, int variantId) {

        String sql = "SELECT quantity "
                   + "FROM cart_item "
                   + "WHERE cart_id = ? AND variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);
            statement.setInt(2, variantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt("quantity");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // MAP RESULTSET TO CARTITEM OBJECT
    // =========================================================

    private CartItem mapCartItem(ResultSet resultSet) throws Exception {

        CartItem cartItem = new CartItem();

        cartItem.setCartItemId(
                resultSet.getInt("cart_item_id")
        );

        cartItem.setCartId(
                resultSet.getInt("cart_id")
        );

        cartItem.setVariantId(
                resultSet.getInt("variant_id")
        );

        cartItem.setQuantity(
                resultSet.getInt("quantity")
        );

        return cartItem;
    }
}