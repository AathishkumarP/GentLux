package com.gentlux.dao;

import com.gentlux.model.Category;

import java.util.List;

public interface CategoryDAO {

    // =========================================================
    // CREATE
    // =========================================================

    boolean addCategory(Category category);


    // =========================================================
    // READ / FETCH
    // =========================================================

    Category getCategoryById(int categoryId);

    Category getCategoryByName(String categoryName);

    List<Category> getAllCategories();


    // =========================================================
    // SEARCH
    // =========================================================

    List<Category> searchCategories(String keyword);


    // =========================================================
    // UPDATE
    // =========================================================

    boolean updateCategory(Category category);

    boolean updateCategoryName(
            int categoryId,
            String categoryName
    );


    // =========================================================
    // DELETE
    // =========================================================

    boolean deleteCategory(int categoryId);


    // =========================================================
    // CHECK
    // =========================================================

    boolean categoryExists(int categoryId);

    boolean categoryNameExists(String categoryName);


    // =========================================================
    // COUNT
    // =========================================================

    int getCategoryCount();


    // =========================================================
    // PRODUCT RELATED
    // =========================================================

    int getProductCountByCategory(int categoryId);
}