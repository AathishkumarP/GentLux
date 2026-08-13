package com.gentlux.dao.impl;

import com.gentlux.dao.ProductDAO;
import com.gentlux.model.Product;
import com.gentlux.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public Product getProductById(int productId) {

        String sql = "SELECT * FROM products WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, productId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapProduct(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    @Override
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products ORDER BY product_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                products.add(mapProduct(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    @Override
    public List<Product> searchProducts(String keyword) {

        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products " +
                     "WHERE product_name LIKE ? " +
                     "OR brand LIKE ? " +
                     "ORDER BY product_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            String searchKeyword = "%" + keyword + "%";

            statement.setString(1, searchKeyword);
            statement.setString(2, searchKeyword);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    products.add(mapProduct(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    @Override
    public List<Product> getProductsByCategory(int categoryId) {

        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products " +
                     "WHERE category_id = ? " +
                     "ORDER BY product_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, categoryId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    products.add(mapProduct(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    @Override
    public List<Product> getProductsByBrand(String brand) {

        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products " +
                     "WHERE brand = ? " +
                     "ORDER BY product_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, brand);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    products.add(mapProduct(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    @Override
    public List<Product> getProductsByPriceRange(double minPrice, double maxPrice) {

        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products " +
                     "WHERE price BETWEEN ? AND ? " +
                     "ORDER BY product_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setDouble(1, minPrice);
            statement.setDouble(2, maxPrice);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    products.add(mapProduct(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    @Override
    public List<Product> getProductsBySize(String size) {

        List<Product> products = new ArrayList<>();

        String sql = "SELECT DISTINCT p.* " +
                     "FROM products p " +
                     "INNER JOIN product_variants pv " +
                     "ON p.product_id = pv.product_id " +
                     "WHERE pv.size = ? " +
                     "ORDER BY p.product_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, size);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    products.add(mapProduct(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    @Override
    public List<Product> filterProducts(
            Integer categoryId,
            String brand,
            Double minPrice,
            Double maxPrice,
            String size) {

        List<Product> products = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT p.* FROM products p"
        );

        if (size != null && !size.trim().isEmpty()) {
            sql.append(" INNER JOIN product_variants pv ")
               .append("ON p.product_id = pv.product_id ");
        }

        sql.append(" WHERE 1=1 ");

        List<Object> parameters = new ArrayList<>();

        if (categoryId != null) {
            sql.append("AND p.category_id = ? ");
            parameters.add(categoryId);
        }

        if (brand != null && !brand.trim().isEmpty()) {
            sql.append("AND p.brand = ? ");
            parameters.add(brand);
        }

        if (minPrice != null) {
            sql.append("AND p.price >= ? ");
            parameters.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append("AND p.price <= ? ");
            parameters.add(maxPrice);
        }

        if (size != null && !size.trim().isEmpty()) {
            sql.append("AND pv.size = ? ");
            parameters.add(size);
        }

        sql.append("ORDER BY p.product_id DESC");

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    products.add(mapProduct(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    @Override
    public List<Product> getProductsSorted(String sortBy) {

        List<Product> products = new ArrayList<>();

        String orderBy;

        switch (sortBy) {

            case "price_low":
                orderBy = "price ASC";
                break;

            case "price_high":
                orderBy = "price DESC";
                break;

            case "discount":
                orderBy = "discount DESC";
                break;

            case "newest":
                orderBy = "created_at DESC";
                break;

            case "oldest":
                orderBy = "created_at ASC";
                break;

            default:
                orderBy = "product_id DESC";
        }

        String sql = "SELECT * FROM products ORDER BY " + orderBy;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                products.add(mapProduct(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    @Override
    public List<Product> getProductsWithPagination(int page, int pageSize) {

        List<Product> products = new ArrayList<>();

        int offset = (page - 1) * pageSize;

        String sql = "SELECT * FROM products " +
                     "ORDER BY product_id DESC " +
                     "LIMIT ? OFFSET ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, pageSize);
            statement.setInt(2, offset);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    products.add(mapProduct(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    @Override
    public List<Product> getFilteredProducts(
            Integer categoryId,
            String brand,
            Double minPrice,
            Double maxPrice,
            String size,
            String sortBy,
            int page,
            int pageSize) {

        List<Product> products = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT p.* FROM products p"
        );

        if (size != null && !size.trim().isEmpty()) {
            sql.append(" INNER JOIN product_variants pv ")
               .append("ON p.product_id = pv.product_id ");
        }

        sql.append(" WHERE 1=1 ");

        List<Object> parameters = new ArrayList<>();

        if (categoryId != null) {
            sql.append("AND p.category_id = ? ");
            parameters.add(categoryId);
        }

        if (brand != null && !brand.trim().isEmpty()) {
            sql.append("AND p.brand = ? ");
            parameters.add(brand);
        }

        if (minPrice != null) {
            sql.append("AND p.price >= ? ");
            parameters.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append("AND p.price <= ? ");
            parameters.add(maxPrice);
        }

        if (size != null && !size.trim().isEmpty()) {
            sql.append("AND pv.size = ? ");
            parameters.add(size);
        }

        String orderBy;

        switch (sortBy) {

            case "price_low":
                orderBy = "p.price ASC";
                break;

            case "price_high":
                orderBy = "p.price DESC";
                break;

            case "discount":
                orderBy = "p.discount DESC";
                break;

            case "newest":
                orderBy = "p.created_at DESC";
                break;

            case "oldest":
                orderBy = "p.created_at ASC";
                break;

            default:
                orderBy = "p.product_id DESC";
        }

        sql.append("ORDER BY ").append(orderBy);

        int offset = (page - 1) * pageSize;

        sql.append(" LIMIT ? OFFSET ?");

        parameters.add(pageSize);
        parameters.add(offset);

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    products.add(mapProduct(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    @Override
    public boolean addProduct(Product product) {

        String sql = "INSERT INTO products "
                   + "(category_id, product_name, description, brand, color, "
                   + "price, mrp, discount, image_url) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, product.getCategoryId());
            statement.setString(2, product.getProductName());
            statement.setString(3, product.getDescription());
            statement.setString(4, product.getBrand());
            statement.setString(5, product.getColor());
            statement.setDouble(6, product.getPrice());
            statement.setDouble(7, product.getMrp());
            statement.setDouble(8, product.getDiscount());
            statement.setString(9, product.getImageUrl());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean updateProduct(Product product) {

        String sql = "UPDATE products SET "
                   + "category_id = ?, "
                   + "product_name = ?, "
                   + "description = ?, "
                   + "brand = ?, "
                   + "color = ?, "
                   + "price = ?, "
                   + "mrp = ?, "
                   + "discount = ?, "
                   + "image_url = ? "
                   + "WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, product.getCategoryId());
            statement.setString(2, product.getProductName());
            statement.setString(3, product.getDescription());
            statement.setString(4, product.getBrand());
            statement.setString(5, product.getColor());
            statement.setDouble(6, product.getPrice());
            statement.setDouble(7, product.getMrp());
            statement.setDouble(8, product.getDiscount());
            statement.setString(9, product.getImageUrl());
            statement.setInt(10, product.getProductId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean deleteProduct(int productId) {

        String sql = "DELETE FROM products WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, productId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean productExists(int productId) {

        String sql = "SELECT 1 FROM products WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, productId);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public int getProductCount() {

        String sql = "SELECT COUNT(*) FROM products";

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


    private Product mapProduct(ResultSet resultSet) throws Exception {

        Product product = new Product();

        product.setProductId(resultSet.getInt("product_id"));
        product.setCategoryId(resultSet.getInt("category_id"));
        product.setProductName(resultSet.getString("product_name"));
        product.setDescription(resultSet.getString("description"));
        product.setBrand(resultSet.getString("brand"));
        product.setColor(resultSet.getString("color"));
        product.setPrice(resultSet.getDouble("price"));
        product.setMrp(resultSet.getDouble("mrp"));
        product.setDiscount(resultSet.getDouble("discount"));
        product.setImageUrl(resultSet.getString("image_url"));
        product.setCreatedAt(resultSet.getTimestamp("created_at"));

        return product;
    }
}