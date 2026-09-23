package com.gentlux.controller;

import java.io.IOException;

import com.gentlux.dao.CategoryDAO;
import com.gentlux.dao.impl.CategoryDAOImpl;
import com.gentlux.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/delete-category")
public class AdminDeleteCategoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CategoryDAO categoryDAO;


    @Override
    public void init() {

        categoryDAO = new CategoryDAOImpl();
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String categoryIdParameter =
                    request.getParameter("categoryId");


            if (categoryIdParameter == null
                    || categoryIdParameter.isBlank()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories?deleteStatus=invalid"
                );

                return;
            }


            int categoryId =
                    Integer.parseInt(categoryIdParameter);


            // =========================================
            // CHECK CATEGORY EXISTS
            // =========================================

            Category category =
                    categoryDAO.getCategoryById(categoryId);


            if (category == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories?deleteStatus=notfound"
                );

                return;
            }


            // =========================================
            // CHECK PRODUCTS
            // =========================================

            int productCount =
                    categoryDAO.getProductCountByCategory(
                            categoryId
                    );


            if (productCount > 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories?deleteStatus=hasProducts"
                );

                return;
            }


            // =========================================
            // DELETE CATEGORY
            // =========================================

            boolean deleted =
                    categoryDAO.deleteCategory(
                            categoryId
                    );


            if (deleted) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories?deleteStatus=success"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/categories?deleteStatus=failed"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/categories?deleteStatus=invalid"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/categories?deleteStatus=failed"
            );
        }
    }
}