package com.gentlux.dao.impl;

import com.gentlux.dao.CategoryDAO;
import com.gentlux.model.Category;
import com.gentlux.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {

    // =========================================================
    // CREATE CATEGORY
    // =========================================================

    @Override
    public boolean addCategory(Category category) {

        String sql = "INSERT INTO categories (category_name) VALUES (?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, category.getCategoryName());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET CATEGORY BY ID
    // =========================================================

    @Override
    public Category getCategoryById(int categoryId) {

        String sql = "SELECT * FROM categories WHERE category_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, categoryId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapCategory(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET CATEGORY BY NAME
    // =========================================================

    @Override
    public Category getCategoryByName(String categoryName) {

        String sql = "SELECT * FROM categories "
                   + "WHERE category_name = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, categoryName);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapCategory(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET ALL CATEGORIES
    // =========================================================

    @Override
    public List<Category> getAllCategories() {

        List<Category> categories = new ArrayList<>();

        String sql = "SELECT * FROM categories "
                   + "ORDER BY category_id ASC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                categories.add(mapCategory(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }


    // =========================================================
    // SEARCH CATEGORIES
    // =========================================================

    @Override
    public List<Category> searchCategories(String keyword) {

        List<Category> categories = new ArrayList<>();

        String sql = "SELECT * FROM categories "
                   + "WHERE category_name LIKE ? "
                   + "ORDER BY category_name ASC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, "%" + keyword + "%");

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    categories.add(mapCategory(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }


    // =========================================================
    // UPDATE CATEGORY
    // =========================================================

    @Override
    public boolean updateCategory(Category category) {

        String sql = "UPDATE categories SET category_name = ? "
                   + "WHERE category_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, category.getCategoryName());
            statement.setInt(2, category.getCategoryId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // UPDATE CATEGORY NAME
    // =========================================================

    @Override
    public boolean updateCategoryName(
            int categoryId,
            String categoryName) {

        String sql = "UPDATE categories SET category_name = ? "
                   + "WHERE category_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, categoryName);
            statement.setInt(2, categoryId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // DELETE CATEGORY
    // =========================================================

    @Override
    public boolean deleteCategory(int categoryId) {

        String sql = "DELETE FROM categories WHERE category_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, categoryId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CHECK CATEGORY EXISTS
    // =========================================================

    @Override
    public boolean categoryExists(int categoryId) {

        String sql = "SELECT 1 FROM categories WHERE category_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, categoryId);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CHECK CATEGORY NAME EXISTS
    // =========================================================

    @Override
    public boolean categoryNameExists(String categoryName) {

        String sql = "SELECT 1 FROM categories "
                   + "WHERE category_name = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, categoryName);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET CATEGORY COUNT
    // =========================================================

    @Override
    public int getCategoryCount() {

        String sql = "SELECT COUNT(*) FROM categories";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // GET PRODUCT COUNT BY CATEGORY
    // =========================================================

    @Override
    public int getProductCountByCategory(int categoryId) {

        String sql = "SELECT COUNT(*) FROM products "
                   + "WHERE category_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, categoryId);

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
    // RESULTSET → CATEGORY OBJECT
    // =========================================================

    private Category mapCategory(ResultSet resultSet)
            throws Exception {

        Category category = new Category();

        category.setCategoryId(
                resultSet.getInt("category_id")
        );

        category.setCategoryName(
                resultSet.getString("category_name")
        );

        return category;
    }
}