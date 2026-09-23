package com.gentlux.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.gentlux.dao.WishlistDAO;
import com.gentlux.model.Wishlist;
import com.gentlux.model.WishlistItemView;
import com.gentlux.util.DBConnection;

public class WishlistDAOImpl implements WishlistDAO {

    @Override
    public boolean addToWishlist(Wishlist wishlist) {

        String sql =
                "INSERT INTO wishlist (user_id, product_id) "
              + "VALUES (?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, wishlist.getUserId());
            statement.setInt(2, wishlist.getProductId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean removeFromWishlist(int userId, int productId) {

        String sql =
                "DELETE FROM wishlist "
              + "WHERE user_id = ? "
              + "AND product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, productId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean removeByWishlistId(int wishlistId) {

        String sql =
                "DELETE FROM wishlist "
              + "WHERE wishlist_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, wishlistId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean isProductInWishlist(int userId, int productId) {

        String sql =
                "SELECT wishlist_id "
              + "FROM wishlist "
              + "WHERE user_id = ? "
              + "AND product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, productId);

            try (ResultSet resultSet = statement.executeQuery()) {

                return resultSet.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public Wishlist getWishlistItem(int userId, int productId) {

        String sql =
                "SELECT wishlist_id, user_id, product_id, created_at "
              + "FROM wishlist "
              + "WHERE user_id = ? "
              + "AND product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, productId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapWishlist(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    @Override
    public List<Wishlist> getWishlistByUserId(int userId) {

        List<Wishlist> wishlist = new ArrayList<>();

        String sql =
                "SELECT wishlist_id, user_id, product_id, created_at "
              + "FROM wishlist "
              + "WHERE user_id = ? "
              + "ORDER BY created_at DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    wishlist.add(
                            mapWishlist(resultSet)
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return wishlist;
    }


    @Override
    public List<WishlistItemView> getWishlistItemViewsByUserId(int userId) {

        List<WishlistItemView> items = new ArrayList<>();

        String sql =
                "SELECT w.wishlist_id, "
              + "w.user_id, "
              + "w.product_id, "
              + "w.created_at, "
              + "p.product_name, "
              + "p.brand, "
              + "p.price, "
              + "p.mrp, "
              + "p.discount, "
              + "p.image_url "
              + "FROM wishlist w "
              + "JOIN products p "
              + "ON w.product_id = p.product_id "
              + "WHERE w.user_id = ? "
              + "ORDER BY w.created_at DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    WishlistItemView item = new WishlistItemView();

                    item.setWishlistId(
                            resultSet.getInt("wishlist_id")
                    );

                    item.setUserId(
                            resultSet.getInt("user_id")
                    );

                    item.setProductId(
                            resultSet.getInt("product_id")
                    );

                    item.setProductName(
                            resultSet.getString("product_name")
                    );

                    item.setBrand(
                            resultSet.getString("brand")
                    );

                    item.setPrice(
                            resultSet.getDouble("price")
                    );

                    item.setMrp(
                            resultSet.getDouble("mrp")
                    );

                    item.setDiscount(
                            resultSet.getDouble("discount")
                    );

                    item.setImageUrl(
                            resultSet.getString("image_url")
                    );

                    item.setCreatedAt(
                            resultSet.getTimestamp("created_at")
                    );

                    items.add(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return items;
    }


    @Override
    public int getWishlistCount(int userId) {

        String sql =
                "SELECT COUNT(*) "
              + "FROM wishlist "
              + "WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

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


    @Override
    public boolean clearWishlist(int userId) {

        String sql =
                "DELETE FROM wishlist "
              + "WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    private Wishlist mapWishlist(ResultSet resultSet) throws Exception {

        Wishlist wishlist = new Wishlist();

        wishlist.setWishlistId(
                resultSet.getInt("wishlist_id")
        );

        wishlist.setUserId(
                resultSet.getInt("user_id")
        );

        wishlist.setProductId(
                resultSet.getInt("product_id")
        );

        wishlist.setCreatedAt(
                resultSet.getTimestamp("created_at")
        );

        return wishlist;
    }
}