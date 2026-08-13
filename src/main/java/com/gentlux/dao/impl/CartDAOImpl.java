package com.gentlux.dao.impl;

import com.gentlux.dao.CartDAO;
import com.gentlux.model.Cart;
import com.gentlux.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImpl implements CartDAO {

    // =========================================================
    // CREATE CART
    // =========================================================

    @Override
    public boolean createCart(Cart cart) {

        String sql = "INSERT INTO cart (user_id) VALUES (?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cart.getUserId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET CART BY ID
    // =========================================================

    @Override
    public Cart getCartById(int cartId) {

        String sql = "SELECT * FROM cart WHERE cart_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapCart(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET CART BY USER ID
    // =========================================================

    @Override
    public Cart getCartByUserId(int userId) {

        String sql = "SELECT * FROM cart WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapCart(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET ALL CARTS
    // =========================================================

    @Override
    public List<Cart> getAllCarts() {

        List<Cart> carts = new ArrayList<>();

        String sql = "SELECT * FROM cart ORDER BY cart_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                carts.add(mapCart(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return carts;
    }


    // =========================================================
    // UPDATE CART
    // =========================================================

    @Override
    public boolean updateCart(Cart cart) {

        String sql = "UPDATE cart SET user_id = ? "
                   + "WHERE cart_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cart.getUserId());
            statement.setInt(2, cart.getCartId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // DELETE CART BY CART ID
    // =========================================================

    @Override
    public boolean deleteCart(int cartId) {

        String sql = "DELETE FROM cart WHERE cart_id = ?";

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
    // DELETE CART BY USER ID
    // =========================================================

    @Override
    public boolean deleteCartByUserId(int userId) {

        String sql = "DELETE FROM cart WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CHECK CART EXISTS BY CART ID
    // =========================================================

    @Override
    public boolean cartExists(int cartId) {

        String sql = "SELECT 1 FROM cart WHERE cart_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CHECK CART EXISTS FOR USER
    // =========================================================

    @Override
    public boolean cartExistsForUser(int userId) {

        String sql = "SELECT 1 FROM cart WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET OR CREATE CART
    // =========================================================

    @Override
    public Cart getOrCreateCart(int userId) {

        // First check whether the user already has a cart
        Cart existingCart = getCartByUserId(userId);

        if (existingCart != null) {
            return existingCart;
        }

        // Create a new cart if one does not exist
        String sql = "INSERT INTO cart (user_id) VALUES (?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     sql,
                     java.sql.Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, userId);

            int affectedRows = statement.executeUpdate();

            if (affectedRows > 0) {

                try (ResultSet generatedKeys =
                             statement.getGeneratedKeys()) {

                    if (generatedKeys.next()) {

                        int cartId = generatedKeys.getInt(1);

                        return getCartById(cartId);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // RESULTSET → CART OBJECT
    // =========================================================

    private Cart mapCart(ResultSet resultSet) throws Exception {

        Cart cart = new Cart();

        cart.setCartId(
                resultSet.getInt("cart_id")
        );

        cart.setUserId(
                resultSet.getInt("user_id")
        );

        cart.setCreatedAt(
                resultSet.getTimestamp("created_at")
        );

        cart.setUpdatedAt(
                resultSet.getTimestamp("updated_at")
        );

        return cart;
    }
}