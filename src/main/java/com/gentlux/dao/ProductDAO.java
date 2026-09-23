package com.gentlux.dao;

import com.gentlux.model.Product;

import java.util.List;

public interface ProductDAO {

    // Get a single product
    Product getProductById(int productId);

    // Get all products
    List<Product> getAllProducts();

    // Search products by name or brand
    List<Product> searchProducts(String keyword);

    // Filter products by category
    List<Product> getProductsByCategory(int categoryId);

    // Filter products by brand
    List<Product> getProductsByBrand(String brand);

    // Filter products by price range
    List<Product> getProductsByPriceRange(double minPrice, double maxPrice);

    // Filter products by size
    List<Product> getProductsBySize(String size);

    // Combined filters
    List<Product> filterProducts(
            Integer categoryId,
            String brand,
            Double minPrice,
            Double maxPrice,
            String size
    );

    // Sort products
    List<Product> getProductsSorted(String sortBy);

    // Pagination
    List<Product> getProductsWithPagination(int page, int pageSize);

    // Combined filters + sorting + pagination
    List<Product> getFilteredProducts(
            Integer categoryId,
            String brand,
            Double minPrice,
            Double maxPrice,
            String size,
            String sortBy,
            int page,
            int pageSize
    );

    // Add product
    boolean addProduct(Product product);

    // Update product
    boolean updateProduct(Product product);

    // Delete product
    boolean deleteProduct(int productId);

    // Check whether product exists
    boolean productExists(int productId);

    // Get total number of products
    int getProductCount();
}