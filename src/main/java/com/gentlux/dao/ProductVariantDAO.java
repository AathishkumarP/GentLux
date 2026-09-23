package com.gentlux.dao;

import com.gentlux.model.ProductVariant;

import java.util.List;

public interface ProductVariantDAO {

    // =========================================================
    // CREATE
    // =========================================================

    boolean addVariant(ProductVariant variant);


    // =========================================================
    // READ / FETCH
    // =========================================================

    ProductVariant getVariantById(int variantId);

    List<ProductVariant> getAllVariants();

    List<ProductVariant> getVariantsByProductId(int productId);

    ProductVariant getVariantByProductAndSize(
            int productId,
            String size
    );


    // =========================================================
    // FILTER / SEARCH
    // =========================================================

    List<ProductVariant> getVariantsBySize(String size);

    List<ProductVariant> getVariantsByStockStatus(
            boolean available
    );


    // =========================================================
    // UPDATE
    // =========================================================

    boolean updateVariant(ProductVariant variant);

    boolean updateSize(
            int variantId,
            String size
    );

    boolean updateStock(
            int variantId,
            int stockQuantity
    );

    boolean increaseStock(
            int variantId,
            int quantity
    );

    boolean decreaseStock(
            int variantId,
            int quantity
    );


    // =========================================================
    // DELETE
    // =========================================================

    boolean deleteVariant(int variantId);

    boolean deleteVariantsByProductId(int productId);


    // =========================================================
    // CHECK
    // =========================================================

    boolean variantExists(int variantId);

    boolean variantExistsForProductAndSize(
            int productId,
            String size
    );


    // =========================================================
    // STOCK
    // =========================================================

    int getStock(int variantId);

    boolean isInStock(int variantId);

    int getTotalStockByProduct(int productId);

    int getVariantCountByProduct(int productId);
}