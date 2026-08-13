package com.gentlux.dao.impl;

import com.gentlux.dao.ProductVariantDAO;
import com.gentlux.model.ProductVariant;
import com.gentlux.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantDAOImpl implements ProductVariantDAO {

    // =========================================================
    // CREATE
    // =========================================================

    @Override
    public boolean addVariant(ProductVariant variant) {

        String sql = "INSERT INTO product_variants "
                   + "(product_id, size, stock) "
                   + "VALUES (?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, variant.getProductId());
            statement.setString(2, variant.getSize());
            statement.setInt(3, variant.getStockQuantity());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET VARIANT BY ID
    // =========================================================

    @Override
    public ProductVariant getVariantById(int variantId) {

        String sql = "SELECT * FROM product_variants "
                   + "WHERE variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, variantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapProductVariant(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET ALL VARIANTS
    // =========================================================

    @Override
    public List<ProductVariant> getAllVariants() {

        List<ProductVariant> variants = new ArrayList<>();

        String sql = "SELECT * FROM product_variants "
                   + "ORDER BY variant_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                variants.add(mapProductVariant(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return variants;
    }


    // =========================================================
    // GET VARIANTS BY PRODUCT ID
    // =========================================================

    @Override
    public List<ProductVariant> getVariantsByProductId(int productId) {

        List<ProductVariant> variants = new ArrayList<>();

        String sql = "SELECT * FROM product_variants "
                   + "WHERE product_id = ? "
                   + "ORDER BY variant_id ASC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, productId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    variants.add(mapProductVariant(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return variants;
    }


    // =========================================================
    // GET VARIANT BY PRODUCT AND SIZE
    // =========================================================

    @Override
    public ProductVariant getVariantByProductAndSize(
            int productId,
            String size) {

        String sql = "SELECT * FROM product_variants "
                   + "WHERE product_id = ? AND size = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, productId);
            statement.setString(2, size);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapProductVariant(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET VARIANTS BY SIZE
    // =========================================================

    @Override
    public List<ProductVariant> getVariantsBySize(String size) {

        List<ProductVariant> variants = new ArrayList<>();

        String sql = "SELECT * FROM product_variants "
                   + "WHERE size = ? "
                   + "ORDER BY variant_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, size);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    variants.add(mapProductVariant(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return variants;
    }


    // =========================================================
    // GET VARIANTS BY STOCK STATUS
    // =========================================================

    @Override
    public List<ProductVariant> getVariantsByStockStatus(
            boolean available) {

        List<ProductVariant> variants = new ArrayList<>();

        String sql;

        if (available) {
            sql = "SELECT * FROM product_variants "
                + "WHERE stock > 0 "
                + "ORDER BY variant_id DESC";
        } else {
            sql = "SELECT * FROM product_variants "
                + "WHERE stock = 0 "
                + "ORDER BY variant_id DESC";
        }

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                variants.add(mapProductVariant(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return variants;
    }


    // =========================================================
    // UPDATE COMPLETE VARIANT
    // =========================================================

    @Override
    public boolean updateVariant(ProductVariant variant) {

        String sql = "UPDATE product_variants SET "
                   + "product_id = ?, "
                   + "size = ?, "
                   + "stock = ? "
                   + "WHERE variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, variant.getProductId());
            statement.setString(2, variant.getSize());
            statement.setInt(3, variant.getStockQuantity());
            statement.setInt(4, variant.getVariantId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // UPDATE SIZE
    // =========================================================

    @Override
    public boolean updateSize(
            int variantId,
            String size) {

        String sql = "UPDATE product_variants "
                   + "SET size = ? "
                   + "WHERE variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, size);
            statement.setInt(2, variantId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // UPDATE STOCK
    // =========================================================

    @Override
    public boolean updateStock(
            int variantId,
            int stockQuantity) {

        String sql = "UPDATE product_variants "
                   + "SET stock = ? "
                   + "WHERE variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, stockQuantity);
            statement.setInt(2, variantId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // INCREASE STOCK
    // =========================================================

    @Override
    public boolean increaseStock(
            int variantId,
            int quantity) {

        String sql = "UPDATE product_variants "
                   + "SET stock = stock + ? "
                   + "WHERE variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, quantity);
            statement.setInt(2, variantId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // DECREASE STOCK
    // =========================================================

    @Override
    public boolean decreaseStock(
            int variantId,
            int quantity) {

        String sql = "UPDATE product_variants "
                   + "SET stock = stock - ? "
                   + "WHERE variant_id = ? "
                   + "AND stock >= ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, quantity);
            statement.setInt(2, variantId);
            statement.setInt(3, quantity);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // DELETE VARIANT
    // =========================================================

    @Override
    public boolean deleteVariant(int variantId) {

        String sql = "DELETE FROM product_variants "
                   + "WHERE variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, variantId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // DELETE ALL VARIANTS OF A PRODUCT
    // =========================================================

    @Override
    public boolean deleteVariantsByProductId(int productId) {

        String sql = "DELETE FROM product_variants "
                   + "WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, productId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CHECK VARIANT EXISTS
    // =========================================================

    @Override
    public boolean variantExists(int variantId) {

        String sql = "SELECT 1 FROM product_variants "
                   + "WHERE variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, variantId);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // CHECK PRODUCT + SIZE EXISTS
    // =========================================================

    @Override
    public boolean variantExistsForProductAndSize(
            int productId,
            String size) {

        String sql = "SELECT 1 FROM product_variants "
                   + "WHERE product_id = ? AND size = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, productId);
            statement.setString(2, size);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET STOCK
    // =========================================================

    @Override
    public int getStock(int variantId) {

        String sql = "SELECT stock FROM product_variants "
                   + "WHERE variant_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, variantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt("stock");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // CHECK WHETHER VARIANT IS IN STOCK
    // =========================================================

    @Override
    public boolean isInStock(int variantId) {

        String sql = "SELECT 1 FROM product_variants "
                   + "WHERE variant_id = ? AND stock > 0";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, variantId);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // GET TOTAL STOCK OF A PRODUCT
    // =========================================================

    @Override
    public int getTotalStockByProduct(int productId) {

        String sql = "SELECT COALESCE(SUM(stock), 0) "
                   + "FROM product_variants "
                   + "WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, productId);

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
    // GET VARIANT COUNT OF A PRODUCT
    // =========================================================

    @Override
    public int getVariantCountByProduct(int productId) {

        String sql = "SELECT COUNT(*) "
                   + "FROM product_variants "
                   + "WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, productId);

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
    // RESULTSET → PRODUCT VARIANT OBJECT
    // =========================================================

    private ProductVariant mapProductVariant(
            ResultSet resultSet) throws Exception {

        ProductVariant variant = new ProductVariant();

        variant.setVariantId(
                resultSet.getInt("variant_id")
        );

        variant.setProductId(
                resultSet.getInt("product_id")
        );

        variant.setSize(
                resultSet.getString("size")
        );

        variant.setStockQuantity(
                resultSet.getInt("stock")
        );

        return variant;
    }
}